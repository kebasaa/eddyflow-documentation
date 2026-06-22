#!/usr/bin/env python
"""Convert the local LI-COR EddyPro mirror into a MkDocs Markdown site."""

from __future__ import annotations

import argparse
import html
import json
import posixpath
import re
import shutil
import sys
from pathlib import Path
from urllib.parse import urljoin, urlparse

try:
    from lxml import etree, html as lxml_html
except ImportError as exc:
    raise SystemExit(
        "Missing Python dependency 'lxml'. Install requirements-docs.txt or pass a Python "
        "environment that includes lxml."
    ) from exc


DISCLAIMER = (
    "Unofficial archive of LI-COR EddyPro documentation for research/reproducibility. "
    "Not affiliated with LI-COR."
)
SOURCE_ROOT = "https://www.licor.com/support"
EDDYPRO_ROOT = "https://www.licor.com/support/EddyPro/"


def slugify(value: str) -> str:
    value = html.unescape(value or "").strip().lower()
    value = re.sub(r"[^\w\s.-]+", "", value, flags=re.UNICODE)
    value = re.sub(r"[\s_.]+", "-", value)
    value = re.sub(r"-+", "-", value).strip("-")
    return value or "page"


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8-sig", errors="replace")


def mirror_path_for_url(mirror_root: Path, url: str) -> Path:
    parsed = urlparse(url)
    rel = parsed.path.lstrip("/")
    return mirror_root / parsed.netloc / Path(*rel.split("/"))


def extract_toc_entries(mirror_root: Path) -> list[dict]:
    chunk = mirror_root / "www.licor.com" / "support" / "Data" / "Tocs" / "EddyPro__EddyPro_Support_all_Chunk0.js"
    if not chunk.exists():
        raise SystemExit(f"TOC chunk not found: {chunk}")

    text = read_text(chunk)
    entries: list[dict] = []
    pattern = re.compile(
        r"'(?P<path>/EddyPro/[^']+)'\s*:\s*\{i:\[(?P<ids>[^\]]*)\],t:\[(?P<titles>[^\]]*)\]",
        re.DOTALL,
    )
    for match in pattern.finditer(text):
        path = match.group("path")
        titles = re.findall(r"'((?:\\'|[^'])*)'", match.group("titles"))
        title = html.unescape((titles[0] if titles else Path(path).stem).replace("\\'", "'"))
        if not path.endswith((".html", ".htm")):
            continue
        source_url = f"{SOURCE_ROOT}{path}"
        source_path = mirror_path_for_url(mirror_root, source_url)
        if not source_path.exists():
            continue
        entries.append({"path": path, "title": title, "source_url": source_url, "source_path": source_path})
    return entries


def clean_tree(root) -> None:
    cleanup_xpath = (
        ".//*[self::script or self::style or self::noscript or self::form "
        "or contains(concat(' ', normalize-space(@class), ' '), ' nocontent ') "
        "or contains(concat(' ', normalize-space(@class), ' '), ' breadcrumbs ') "
        "or contains(concat(' ', normalize-space(@class), ' '), ' sticky-side-nav ') "
        "or contains(concat(' ', normalize-space(@class), ' '), ' support-contact-expanded ')]"
    )
    for node in list(root.xpath(cleanup_xpath)):
        parent = node.getparent()
        if parent is not None:
            parent.remove(node)

    for node in list(root.iter()):
        tag = local_name(node)
        if tag in {"concept", "keyword", "xref"} or tag.startswith("madcap"):
            node.drop_tag()
        if tag == "a" and not (node.get("href") or (node.text and node.text.strip())):
            node.drop_tree()


def text_content(node) -> str:
    return re.sub(r"\s+", " ", "".join(node.itertext())).strip()


def local_name(node) -> str:
    if not isinstance(node.tag, str):
        return ""
    if node.tag.startswith("{"):
        try:
            return etree.QName(node).localname.lower()
        except ValueError:
            return node.tag.lower()
    return node.tag.split(":", 1)[-1].lower()


def escape_md(text: str) -> str:
    return html.unescape(text or "").replace("\\", "\\\\").replace("|", "\\|")


def copy_asset(src: Path, docs_root: Path, asset_map: dict[Path, str]) -> str | None:
    if not src.exists() or not src.is_file():
        return None
    src = src.resolve()
    if src in asset_map:
        return asset_map[src]
    assets_dir = docs_root / "assets"
    target_name = src.name
    target = assets_dir / target_name
    counter = 2
    while target.exists() and target.resolve() != src:
        target = assets_dir / f"{src.stem}-{counter}{src.suffix}"
        counter += 1
    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, target)
    rel = posixpath.join("assets", target.name)
    asset_map[src] = rel
    return rel


def rewrite_link(href: str, source_url: str, url_to_md: dict[str, str], current_md: str) -> str:
    if not href:
        return ""
    href = html.unescape(href)
    if href.startswith("#"):
        return href
    absolute = urljoin(source_url, href)
    parsed = urlparse(absolute)
    anchor = f"#{parsed.fragment}" if parsed.fragment else ""
    no_fragment = parsed._replace(fragment="").geturl()
    if no_fragment in url_to_md:
        return posixpath.relpath(url_to_md[no_fragment], posixpath.dirname(current_md) or ".") + anchor
    return absolute


def relative_doc_link(target: str, current_md: str) -> str:
    return posixpath.relpath(target, posixpath.dirname(current_md) or ".")


def render_inline(node, source_url: str, url_to_md: dict[str, str], current_md: str, docs_root: Path, mirror_root: Path, asset_map: dict[Path, str]) -> str:
    pieces: list[str] = []
    if node.text:
        pieces.append(escape_md(node.text))
    for child in node:
        tag = local_name(child)
        child_text = render_inline(child, source_url, url_to_md, current_md, docs_root, mirror_root, asset_map)
        if tag in {"strong", "b"} and child_text.strip():
            pieces.append(f"**{child_text.strip()}**")
        elif tag in {"em", "i"} and child_text.strip():
            pieces.append(f"*{child_text.strip()}*")
        elif tag == "code":
            pieces.append(f"`{child_text.strip()}`")
        elif tag == "br":
            pieces.append("  \n")
        elif tag == "a":
            href = child.get("href")
            label = child_text.strip() or href or ""
            if href:
                pieces.append(f"[{label}]({rewrite_link(href, source_url, url_to_md, current_md)})")
            else:
                pieces.append(label)
        elif tag == "img":
            src = child.get("src")
            alt = child.get("alt") or ""
            if src:
                absolute = urljoin(source_url, src)
                parsed = urlparse(absolute)
                if parsed.netloc == "www.licor.com":
                    local = mirror_path_for_url(mirror_root, parsed._replace(fragment="", query="").geturl())
                    copied = copy_asset(local, docs_root, asset_map)
                    pieces.append(f"![{escape_md(alt)}]({relative_doc_link(copied, current_md) if copied else absolute})")
                else:
                    pieces.append(f"![{escape_md(alt)}]({absolute})")
        else:
            pieces.append(child_text)
        if child.tail:
            pieces.append(escape_md(child.tail))
    return "".join(pieces)


def render_blocks(parent, source_url: str, url_to_md: dict[str, str], current_md: str, docs_root: Path, mirror_root: Path, asset_map: dict[Path, str]) -> list[str]:
    blocks: list[str] = []
    for child in parent:
        tag = local_name(child)
        if tag in {"h1", "h2", "h3", "h4", "h5", "h6"}:
            level = int(tag[1])
            title = text_content(child)
            if title:
                blocks.append(f"{'#' * level} {title}")
        elif tag == "p":
            text = render_inline(child, source_url, url_to_md, current_md, docs_root, mirror_root, asset_map).strip()
            if text:
                blocks.append(text)
        elif tag in {"ul", "ol"}:
            ordered = tag == "ol"
            lines = []
            for idx, li in enumerate(child.xpath("./li"), start=1):
                prefix = f"{idx}. " if ordered else "- "
                lines.append(prefix + render_inline(li, source_url, url_to_md, current_md, docs_root, mirror_root, asset_map).strip())
            if lines:
                blocks.append("\n".join(lines))
        elif tag == "pre":
            code = child.text_content().rstrip()
            blocks.append(f"```\n{code}\n```")
        elif tag == "table":
            rows = []
            for tr in child.xpath(".//tr"):
                cells = [escape_md(text_content(cell)) for cell in tr.xpath("./th|./td")]
                if cells:
                    rows.append(cells)
            if rows:
                width = max(len(r) for r in rows)
                rows = [r + [""] * (width - len(r)) for r in rows]
                table = ["| " + " | ".join(rows[0]) + " |", "| " + " | ".join(["---"] * width) + " |"]
                for row in rows[1:]:
                    table.append("| " + " | ".join(row) + " |")
                blocks.append("\n".join(table))
        elif tag in {"div", "section", "article"}:
            blocks.extend(render_blocks(child, source_url, url_to_md, current_md, docs_root, mirror_root, asset_map))
        else:
            text = render_inline(child, source_url, url_to_md, current_md, docs_root, mirror_root, asset_map).strip()
            if text:
                blocks.append(text)
    return blocks


def parse_html(path: Path):
    parser = lxml_html.HTMLParser(encoding="utf-8")
    return lxml_html.fromstring(path.read_bytes(), parser=parser)


def page_toc_path(path: Path) -> list[str]:
    doc = parse_html(path)
    value = doc.get("data-mc-toc-path") or ""
    return [part for part in value.split("|") if part and part not in {"Support", "EddyPro", "Contents"}]


def yaml_quote(value: str) -> str:
    return json.dumps(value, ensure_ascii=False)


def write_nav(f, node, indent=2):
    spaces = " " * indent
    for item in node:
        if "file" in item:
            f.write(f"{spaces}- {yaml_quote(item['title'])}: {item['file']}\n")
        else:
            f.write(f"{spaces}- {yaml_quote(item['title'])}:\n")
            write_nav(f, item["children"], indent + 2)


def add_nav_item(nav: list[dict], groups: list[str], title: str, file_path: str) -> None:
    cursor = nav
    for group in groups:
        existing = next((item for item in cursor if item.get("title") == group and "children" in item), None)
        if existing is None:
            existing = {"title": group, "children": []}
            cursor.append(existing)
        cursor = existing["children"]
    cursor.append({"title": title, "file": file_path})


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--mirror-root", required=True, type=Path)
    parser.add_argument("--docs-root", required=True, type=Path)
    parser.add_argument("--repo-root", required=True, type=Path)
    args = parser.parse_args()

    mirror_root = args.mirror_root.resolve()
    docs_root = args.docs_root.resolve()
    repo_root = args.repo_root.resolve()
    manifest_path = mirror_root / "download-manifest.json"
    if not manifest_path.exists():
        raise SystemExit(f"Manifest not found: {manifest_path}")
    manifest = json.loads(read_text(manifest_path))

    entries = extract_toc_entries(mirror_root)
    if not entries:
        raise SystemExit("No TOC entries found to convert.")

    if docs_root.exists():
        shutil.rmtree(docs_root)
    docs_root.mkdir(parents=True)
    (docs_root / "assets").mkdir()

    url_to_md: dict[str, str] = {}
    used_files: set[str] = set()
    for entry in entries:
        rel_dir = "reference"
        if "/topics/" in entry["path"]:
            rel_dir = "topics"
        elif "/videos/" in entry["path"]:
            rel_dir = "videos"
        name = slugify(Path(entry["path"]).stem)
        rel = posixpath.join(rel_dir, f"{name}.md")
        counter = 2
        while rel in used_files:
            rel = posixpath.join(rel_dir, f"{name}-{counter}.md")
            counter += 1
        used_files.add(rel)
        entry["md_rel"] = rel
        url_to_md[entry["source_url"]] = rel

    asset_map: dict[Path, str] = {}
    nav: list[dict] = [{"title": "Home", "file": "index.md"}, {"title": "Provenance", "file": "provenance.md"}]

    for entry in entries:
        doc = parse_html(entry["source_path"])
        main_nodes = doc.xpath("//*[@id='mc-main-content']")
        if not main_nodes:
            continue
        main_node = main_nodes[0]
        clean_tree(main_node)
        blocks = render_blocks(main_node, entry["source_url"], url_to_md, entry["md_rel"], docs_root, mirror_root, asset_map)
        target = docs_root / Path(entry["md_rel"])
        target.parent.mkdir(parents=True, exist_ok=True)
        frontmatter = [
            "---",
            f"title: {json.dumps(entry['title'], ensure_ascii=False)}",
            f"source_url: {json.dumps(entry['source_url'], ensure_ascii=False)}",
            "---",
            "",
        ]
        body = "\n\n".join(blocks).strip()
        target.write_text("\n".join(frontmatter) + body + "\n", encoding="utf-8")

        groups = page_toc_path(entry["source_path"])
        if groups and groups[-1] == entry["title"]:
            groups = groups[:-1]
        add_nav_item(nav, groups[:3], entry["title"], entry["md_rel"])

    generated_at = manifest.get("generatedAt", "unknown")
    (docs_root / "index.md").write_text(
        "\n".join(
            [
                "# EddyPro Documentation Archive",
                "",
                f"> {DISCLAIMER}",
                "",
                "This site is a readable Markdown conversion of a local archive of the LI-COR EddyPro support documentation.",
                "",
                f"- Original support area: [{EDDYPRO_ROOT}]({EDDYPRO_ROOT})",
                f"- Mirror generated: `{generated_at}`",
                "- Raw mirror: generated locally by `eddypro-documentation/download-eddypro-docs.ps1` and intentionally ignored by git.",
                "- Provenance: [Archive provenance](provenance.md)",
                "",
            ]
        ),
        encoding="utf-8",
    )

    summary = manifest.get("summary", {})
    (docs_root / "provenance.md").write_text(
        "\n".join(
            [
                "# Archive Provenance",
                "",
                f"> {DISCLAIMER}",
                "",
                f"- Manifest generated: `{generated_at}`",
                f"- Downloaded entries: `{summary.get('downloaded', 'unknown')}`",
                f"- Existing entries skipped during last run: `{summary.get('skippedExisting', 'unknown')}`",
                f"- Failed mirror URLs: `{summary.get('failed', 'unknown')}`",
                f"- Skipped external URLs: `{summary.get('skippedExternal', 'unknown')}`",
                "",
                "The raw mirror is kept locally under `eddypro-documentation/mirror/` as provenance input for this generated site.",
                "That directory is intentionally excluded from git unless the archive policy changes.",
                "",
            ]
        ),
        encoding="utf-8",
    )

    with (repo_root / "mkdocs.yml").open("w", encoding="utf-8") as f:
        f.write("site_name: EddyPro Documentation Archive\n")
        f.write("site_description: Unofficial archive of LI-COR EddyPro documentation\n")
        f.write("docs_dir: docs\n")
        f.write("theme:\n")
        f.write("  name: material\n")
        f.write("  features:\n")
        f.write("    - navigation.sections\n")
        f.write("    - navigation.indexes\n")
        f.write("    - search.suggest\n")
        f.write("    - content.code.copy\n")
        f.write("extra:\n")
        f.write(f"  generator_notice: {yaml_quote(DISCLAIMER)}\n")
        f.write("markdown_extensions:\n")
        f.write("  - admonition\n")
        f.write("  - tables\n")
        f.write("  - toc:\n")
        f.write("      permalink: true\n")
        f.write("extra_css:\n")
        f.write("  - assets/archive.css\n")
        f.write("nav:\n")
        write_nav(f, nav)

    (docs_root / "assets" / "archive.css").write_text(
        ".md-footer-meta::before{content:'"
        + DISCLAIMER.replace("'", "\\'")
        + "';display:block;max-width:61rem;margin:0 auto;padding:.6rem .8rem;color:var(--md-footer-fg-color--lighter);}\n"
        ".md-typeset blockquote{border-left:.2rem solid var(--md-accent-fg-color);}\n",
        encoding="utf-8",
    )

    print(f"Converted {len(entries)} pages into {docs_root}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
