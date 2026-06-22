[CmdletBinding()]
param(
    [string]$OutputRoot = ".\mirror",
    [string]$DocsRoot = "..\docs",
    [string]$PythonPath,
    [switch]$Force,
    [switch]$SkipDownload,
    [switch]$GenerateMkDocs,
    [int]$ThrottleMs = 250,
    [int]$MaxRetries = 3
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$BaseHost = "www.licor.com"
$SeedUrls = @(
    "https://www.licor.com/support/EddyPro/topics/introduction.html",
    "https://www.licor.com/support/EddyPro/topics/output-files-full-output.html",
    "https://www.licor.com/support/Data/Tocs/EddyPro__EddyPro_Support.js",
    "https://www.licor.com/support/Data/Tocs/EddyPro__EddyPro_Support_all.js"
)

$AllowedPathPrefixes = @(
    "/support/EddyPro/",
    "/support/Data/Tocs/",
    "/support/Resources/",
    "/support/Skins/"
)

$ExternalSkipPatterns = @(
    "googletagmanager.com",
    "google-analytics.com",
    "cookielaw.org",
    "youtube.com",
    "youtu.be",
    "vimeo.com",
    "fonts.googleapis.com",
    "fonts.gstatic.com",
    "use.typekit.net",
    "cdnjs.cloudflare.com",
    "licor.matomo.cloud",
    "go.licor.com"
)

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not [System.IO.Path]::IsPathRooted($OutputRoot)) {
    $OutputRoot = Join-Path $ScriptRoot $OutputRoot
}
$OutputRoot = [System.IO.Path]::GetFullPath($OutputRoot)
if (-not [System.IO.Path]::IsPathRooted($DocsRoot)) {
    $DocsRoot = Join-Path $ScriptRoot $DocsRoot
}
$DocsRoot = [System.IO.Path]::GetFullPath($DocsRoot)
$ManifestPath = Join-Path $OutputRoot "download-manifest.json"

$Curl = Get-Command curl.exe -ErrorAction SilentlyContinue
$Downloaded = New-Object System.Collections.Generic.List[object]
$Failures = New-Object System.Collections.Generic.List[object]
$SkippedExternal = New-Object System.Collections.Generic.List[object]
$SeenSkippedExternal = New-Object "System.Collections.Generic.HashSet[string]"
$Queued = New-Object "System.Collections.Generic.Queue[string]"
$SeenUrls = New-Object "System.Collections.Generic.HashSet[string]"
$DownloadedCount = 0
$ExistingCount = 0

function Add-QueueUrl {
    param([string]$Url)
    if ([string]::IsNullOrWhiteSpace($Url)) {
        return
    }
    if ($SeenUrls.Add($Url)) {
        $Queued.Enqueue($Url)
    }
}

function ConvertTo-AbsoluteUrl {
    param(
        [string]$BaseUrl,
        [string]$RawUrl
    )

    if ([string]::IsNullOrWhiteSpace($RawUrl)) {
        return $null
    }

    $candidate = [System.Net.WebUtility]::HtmlDecode($RawUrl).Trim()
    if ($candidate.StartsWith("#")) {
        return $null
    }
    if ($candidate -match "[{}]") {
        return $null
    }
    if ($candidate -match "^(?i)(javascript|mailto|tel|data):") {
        return $null
    }
    if ($candidate.StartsWith("//")) {
        $candidate = "https:$candidate"
    }

    try {
        $base = [Uri]$BaseUrl
        $resolved = [Uri]::new($base, $candidate)
        $builder = [UriBuilder]$resolved
        $builder.Fragment = ""
        return $builder.Uri.AbsoluteUri
    }
    catch {
        return $null
    }
}

function Test-AllowedUrl {
    param([string]$Url)

    try {
        $uri = [Uri]$Url
    }
    catch {
        return $false
    }

    if ($uri.Scheme -notin @("http", "https")) {
        return $false
    }
    if ($uri.Host -ne $BaseHost) {
        return $false
    }

    foreach ($prefix in $AllowedPathPrefixes) {
        if ($uri.AbsolutePath.StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase)) {
            return $true
        }
    }
    return $false
}

function Add-SkippedExternal {
    param(
        [string]$Url,
        [string]$SourceUrl,
        [string]$Reason
    )

    if ([string]::IsNullOrWhiteSpace($Url)) {
        return
    }
    if ($SeenSkippedExternal.Add("$SourceUrl|$Url")) {
        $SkippedExternal.Add([pscustomobject]@{
            url = $Url
            sourceUrl = $SourceUrl
            reason = $Reason
        })
    }
}

function Get-LocalPathForUrl {
    param([string]$Url)

    $uri = [Uri]$Url
    $path = $uri.AbsolutePath.TrimStart("/")
    if ([string]::IsNullOrWhiteSpace($path) -or $uri.AbsolutePath.EndsWith("/")) {
        $path = Join-Path $path "index.html"
    }

    $segments = $path -split "/"
    $safeSegments = foreach ($segment in $segments) {
        $decoded = [System.Uri]::UnescapeDataString($segment)
        if ([string]::IsNullOrWhiteSpace($decoded)) {
            continue
        }
        $safe = $decoded
        foreach ($c in [System.IO.Path]::GetInvalidFileNameChars()) {
            $safe = $safe.Replace($c, "_")
        }
        $safe
    }

    $localPath = Join-Path $OutputRoot $uri.Host
    foreach ($segment in $safeSegments) {
        $localPath = Join-Path $localPath $segment
    }

    if (-not [string]::IsNullOrWhiteSpace($uri.Query)) {
        $query = $uri.Query.TrimStart("?")
        foreach ($c in [System.IO.Path]::GetInvalidFileNameChars()) {
            $query = $query.Replace($c, "_")
        }
        $localPath = "$localPath.query-$query"
    }

    return $localPath
}

function Invoke-Download {
    param([string]$Url)

    $localPath = Get-LocalPathForUrl $Url
    $dir = Split-Path -Parent $localPath
    New-Item -ItemType Directory -Force -Path $dir | Out-Null

    if ((Test-Path -LiteralPath $localPath) -and -not $Force) {
        $script:ExistingCount += 1
        Write-Verbose "Skipping existing file: $Url"
        return [pscustomobject]@{
            url = $Url
            localPath = $localPath
            statusCode = $null
            contentType = $null
            downloadedAt = (Get-Date).ToString("o")
            result = "skipped-existing"
            error = $null
        }
    }

    $attempt = 0
    $lastError = $null
    while ($attempt -lt $MaxRetries) {
        $attempt += 1
        $tmp = "$localPath.tmp"
        if (Test-Path -LiteralPath $tmp) {
            Remove-Item -LiteralPath $tmp -Force
        }

        try {
            if ($Curl) {
                $curlOutput = & $Curl.Source --location --silent --show-error --max-redirs 10 --connect-timeout 20 --output $tmp --write-out "`n%{http_code}|%{content_type}|%{url_effective}" $Url 2>&1
                $writeOutLine = @($curlOutput | Where-Object { $_ -match "^\d{3}\|" } | Select-Object -Last 1)[0]
                if (-not $writeOutLine) {
                    throw "curl did not report an HTTP status. Output: $curlOutput"
                }
                $parts = $writeOutLine -split "\|", 3
                $statusCode = [int]$parts[0]
                $contentType = if ($parts.Count -gt 1) { $parts[1] } else { $null }
            }
            else {
                $response = Invoke-WebRequest -Uri $Url -MaximumRedirection 10 -TimeoutSec 30 -OutFile $tmp -UserAgent "Mozilla/5.0"
                $statusCode = [int]$response.StatusCode
                $contentType = $response.Headers["Content-Type"]
            }

            if ($statusCode -ge 400) {
                if (Test-Path -LiteralPath $tmp) {
                    Remove-Item -LiteralPath $tmp -Force
                }
                throw "HTTP $statusCode"
            }

            Move-Item -LiteralPath $tmp -Destination $localPath -Force
            $script:DownloadedCount += 1
            Start-Sleep -Milliseconds $ThrottleMs
            Write-Verbose "Downloaded $Url"
            return [pscustomobject]@{
                url = $Url
                localPath = $localPath
                statusCode = $statusCode
                contentType = $contentType
                downloadedAt = (Get-Date).ToString("o")
                result = "downloaded"
                error = $null
            }
        }
        catch {
            $lastError = $_.Exception.Message
            if (Test-Path -LiteralPath $tmp) {
                Remove-Item -LiteralPath $tmp -Force
            }
            if ($attempt -lt $MaxRetries) {
                Start-Sleep -Milliseconds ([Math]::Max($ThrottleMs, 250) * $attempt)
            }
        }
    }

    $failure = [pscustomobject]@{
        url = $Url
        localPath = $localPath
        statusCode = $null
        contentType = $null
        downloadedAt = (Get-Date).ToString("o")
        result = "failed"
        error = $lastError
    }
    $Failures.Add($failure)
    Write-Warning "Failed $Url - $lastError"
    return $failure
}

function Find-UrlsInText {
    param(
        [string]$Text,
        [string]$SourceUrl,
        [switch]$IncludeCssUrls
    )

    $urls = New-Object System.Collections.Generic.List[string]

    foreach ($match in [regex]::Matches($Text, "(?i)(?:href|src)\s*=\s*['""]([^'""]+)['""]")) {
        $absolute = ConvertTo-AbsoluteUrl -BaseUrl $SourceUrl -RawUrl $match.Groups[1].Value
        if ($absolute) {
            $urls.Add($absolute)
        }
    }

    foreach ($match in [regex]::Matches($Text, "(?i)data-mc-linked-toc\s*=\s*['""]([^'""]+)['""]")) {
        $tocPath = $match.Groups[1].Value
        if ($tocPath -match "^Data/Tocs/") {
            $absolute = "https://$BaseHost/support/$tocPath"
        }
        else {
            $absolute = ConvertTo-AbsoluteUrl -BaseUrl $SourceUrl -RawUrl $tocPath
        }
        if ($absolute) {
            $urls.Add($absolute)
        }
    }

    if ($IncludeCssUrls) {
        foreach ($match in [regex]::Matches($Text, "(?i)url\(\s*['""]?([^)'""\s]+)['""]?\s*\)")) {
            $rawUrl = $match.Groups[1].Value
            if ($rawUrl -match "^[A-Za-z_$][A-Za-z0-9_$]*(?:\.|$|\[|\()") {
                continue
            }
            $absolute = ConvertTo-AbsoluteUrl -BaseUrl $SourceUrl -RawUrl $rawUrl
            if ($absolute) {
                $urls.Add($absolute)
            }
        }
    }

    return $urls
}

function Find-TocUrls {
    param(
        [string]$Text,
        [string]$SourceUrl
    )

    $urls = New-Object System.Collections.Generic.List[string]

    foreach ($match in [regex]::Matches($Text, "prefix\s*:\s*['""]([^'""]+)['""]")) {
        $prefix = $match.Groups[1].Value
        foreach ($chunkMatch in [regex]::Matches($Text, "numchunks\s*:\s*(\d+)")) {
            $numChunks = [int]$chunkMatch.Groups[1].Value
            for ($i = 0; $i -lt $numChunks; $i += 1) {
                $urls.Add((ConvertTo-AbsoluteUrl -BaseUrl $SourceUrl -RawUrl "$prefix$i.js"))
            }
        }
    }

    foreach ($match in [regex]::Matches($Text, "['""](/EddyPro/[^'""]+)['""]\s*:")) {
        $path = "/support$($match.Groups[1].Value)"
        $urls.Add("https://$BaseHost$path")
    }

    return $urls
}

function Add-DiscoveredUrls {
    param(
        [string]$DownloadedUrl,
        [string]$LocalPath,
        [string]$ContentType
    )

    if (-not (Test-Path -LiteralPath $LocalPath)) {
        return
    }

    $extension = [System.IO.Path]::GetExtension($LocalPath)
    $looksText = $extension -in @(".html", ".htm", ".css", ".js", ".xml", ".json", ".txt") -or ($ContentType -match "(text|javascript|json|xml|html|css)")
    if (-not $looksText) {
        return
    }

    $text = Get-Content -LiteralPath $LocalPath -Raw -ErrorAction Stop
    $candidates = New-Object System.Collections.Generic.List[string]
    $includeCssUrls = $extension -in @(".css", ".html", ".htm") -or ($ContentType -match "(css|html)")
    foreach ($url in Find-UrlsInText -Text $text -SourceUrl $DownloadedUrl -IncludeCssUrls:$includeCssUrls) {
        $candidates.Add($url)
    }
    foreach ($url in Find-TocUrls -Text $text -SourceUrl $DownloadedUrl) {
        if ($url) {
            $candidates.Add($url)
        }
    }

    foreach ($candidate in $candidates) {
        if (Test-AllowedUrl $candidate) {
            Add-QueueUrl $candidate
        }
        else {
            $reason = "outside allowed mirror scope"
            foreach ($pattern in $ExternalSkipPatterns) {
                if ($candidate -like "*$pattern*") {
                    $reason = "external service skipped by default"
                    break
                }
            }
            Add-SkippedExternal -Url $candidate -SourceUrl $DownloadedUrl -Reason $reason
        }
    }
}

function Resolve-PythonPath {
    param([string]$RequestedPythonPath)

    function Test-PythonExecutable {
        param([string]$Candidate)
        try {
            $output = & $Candidate --version 2>&1
            return ($LASTEXITCODE -eq 0 -and ($output -match "Python\s+\d+"))
        }
        catch {
            return $false
        }
    }

    if (-not [string]::IsNullOrWhiteSpace($RequestedPythonPath)) {
        if (Test-Path -LiteralPath $RequestedPythonPath) {
            $resolved = (Resolve-Path -LiteralPath $RequestedPythonPath).Path
            if (Test-PythonExecutable $resolved) {
                return $resolved
            }
            throw "PythonPath exists but is not a working Python executable: $RequestedPythonPath"
        }
        $cmd = Get-Command $RequestedPythonPath -ErrorAction SilentlyContinue
        if ($cmd -and (Test-PythonExecutable $cmd.Source)) {
            return $cmd.Source
        }
        throw "PythonPath was provided but not found: $RequestedPythonPath"
    }

    foreach ($name in @("python", "py")) {
        $cmd = Get-Command $name -ErrorAction SilentlyContinue
        if ($cmd -and (Test-PythonExecutable $cmd.Source)) {
            return $cmd.Source
        }
    }

    $runtimePython = Join-Path $env:USERPROFILE ".cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe"
    if ((Test-Path -LiteralPath $runtimePython) -and (Test-PythonExecutable $runtimePython)) {
        return $runtimePython
    }

    throw "Python was not found. Install Python, pass -PythonPath, or run from a Codex workspace with bundled Python."
}

if (-not $SkipDownload) {
    New-Item -ItemType Directory -Force -Path $OutputRoot | Out-Null
    foreach ($seed in $SeedUrls) {
        Add-QueueUrl $seed
    }

    while ($Queued.Count -gt 0) {
        $url = $Queued.Dequeue()
        if (-not (Test-AllowedUrl $url)) {
            Add-SkippedExternal -Url $url -SourceUrl "(seed-or-queue)" -Reason "outside allowed mirror scope"
            continue
        }

        $record = Invoke-Download -Url $url
        $Downloaded.Add($record)
        if ($record.result -in @("downloaded", "skipped-existing")) {
            Add-DiscoveredUrls -DownloadedUrl $url -LocalPath $record.localPath -ContentType $record.contentType
        }
    }

    $manifest = [pscustomobject]@{
        generatedAt = (Get-Date).ToString("o")
        outputRoot = $OutputRoot
        seeds = $SeedUrls
        allowedPathPrefixes = $AllowedPathPrefixes
        entries = $Downloaded
        failures = $Failures
        skippedExternal = $SkippedExternal
        summary = [pscustomobject]@{
            downloaded = $DownloadedCount
            skippedExisting = $ExistingCount
            failed = $Failures.Count
            skippedExternal = $SkippedExternal.Count
            totalEntries = $Downloaded.Count
        }
    }

    $manifest | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $ManifestPath -Encoding UTF8

    $startPage = Get-LocalPathForUrl "https://www.licor.com/support/EddyPro/topics/introduction.html"
    Write-Host "EddyPro documentation mirror complete."
    Write-Host "Downloaded: $DownloadedCount"
    Write-Host "Skipped existing: $ExistingCount"
    Write-Host "Failed: $($Failures.Count)"
    Write-Host "Skipped external: $($SkippedExternal.Count)"
    Write-Host "Manifest: $ManifestPath"
    Write-Host "Start page: $startPage"
}
else {
    if (-not (Test-Path -LiteralPath $ManifestPath)) {
        throw "Cannot use -SkipDownload because manifest was not found: $ManifestPath"
    }
    Write-Host "Skipped mirror download. Using existing manifest: $ManifestPath"
}

if ($GenerateMkDocs) {
    $python = Resolve-PythonPath -RequestedPythonPath $PythonPath
    $converter = Join-Path $ScriptRoot "convert-mirror-to-mkdocs.py"
    if (-not (Test-Path -LiteralPath $converter)) {
        throw "MkDocs converter not found: $converter"
    }

    Write-Host "Generating MkDocs source with Python: $python"
    & $python $converter --mirror-root $OutputRoot --docs-root $DocsRoot --repo-root (Split-Path -Parent $ScriptRoot)
    if ($LASTEXITCODE -ne 0) {
        throw "MkDocs conversion failed with exit code $LASTEXITCODE"
    }
}
