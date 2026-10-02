# Mixed acquisition rates

<span id="top"></span>

An eddy covariance station does not always record at one rate for its whole life. A data logger may be switched from 10 Hz to 20 Hz, or an analyser inside a fast file may be reconfigured (a quantum cascade laser spectrometer that reports at 1 Hz in one season and at 0.33 Hz in the next, inside a 20 Hz file). This page describes how EddyFlow handles such projects: how it detects a change, which periods it can still process, what it does to the spectral assessment, and which results it deliberately refuses to mix.

Everything described here concerns LI-COR **.ghg** archives, because each archive carries its own metadata, and with it its own acquisition frequency. A project whose raw files all share one rate is processed exactly as before and prints nothing new in the log, with the exceptions listed under [Results that change in single-rate projects](#results-that-change-in-single-rate-projects).

## The problem and what is done now

Before engine version 8.1.1, the processing module sized its period buffer and its record limits once, from the first file of the run. A project that changed rate part way therefore lost data. After a change *up* in rate only the first half of each period fitted in the buffer: a 10 Hz period of 18000 records was read as 9000 records, and from the next period on every period was dropped with Warning(58). The planar-fit, time-lag and drift pre-passes never recomputed the limits at all, and silently used the half of the data that fitted.

EddyFlow now treats every archive's own rate as the truth about its data. In outline:

1. The rate stated by each archive is checked before its data are read ([Rate check per archive](#rate-check-per-archive)).
2. If a period starts in a file at a new rate, the period is read again at that rate. Nothing is resampled ([Re-reading at the new rate](#re-reading-at-the-new-rate)).
3. If the files inside one period disagree, the period cannot be a single time series and is skipped with Warning(116) ([Periods that straddle a change](#periods-that-straddle-a-change-warning-116)).
4. Before processing starts, a survey finds where the rate changes and lists the changes in the log ([Rate survey](#rate-survey-and-log-lines)).
5. The spectral assessment is done separately for each rate ([Spectral assessment per acquisition rate](#spectral-assessment-per-acquisition-rate)).

## Rate check per archive

Each .ghg archive contains a metadata file stating the acquisition frequency of the data in it. EddyFlow compares that rate with the rate the current period buffer is sized for, after reading the archive's metadata and before reading its data. The same check applies in the main pass and in the planar-fit, time-lag and drift pre-passes, which all import periods through the same routine, so the pre-passes no longer use a truncated half of the data.

The check covers two things:

- the **file rate**, that is, the rate of the rows in the file;
- the rate that an **instrument in use** states for itself. An analyser may declare a slower rate than the file (for example an LI-7700 that states 1 Hz inside a 10 Hz file, a column that is mostly missing values by design). If that stated rate changes between files while the file rate stays the same, it is detected per column in use.

## Re-reading at the new rate

When the first file of a period is at a rate different from the one the buffer is sized for, EddyFlow resizes the buffer and the record limits for the new rate and reads the period again. This costs one extra extraction of the archive at each change and no more. The data are read at the file's own rate. **Nothing is resampled, interpolated or decimated**: a 10 Hz period contains 10 Hz samples and a 5 Hz period contains 5 Hz samples, and every later step (despiking, rotation, time lags, spectra) works on the period at its own rate.

As a check of this behaviour, a test project in which the same archives were decimated to 5 Hz for the first three half-hours and left at 10 Hz for the last three processes all six periods, and the three 10 Hz periods give the same fluxes, digit for digit, as the unchanged archives.

## Periods that straddle a change (Warning 116)

A period whose files are not all at the same rate cannot be turned into one time series, because the same sample position would mean two different time steps. Such a period is **skipped**, and EddyFlow writes Warning(116) to the log, naming the file at which the rate changed:

- the file rates differ inside the period, or
- the rate stated by an instrument in use differs between files of the period (the warning then names the instrument).

The next period starts at the file where the rate changed and runs at that file's rate. Whether this loses a period depends on the averaging interval and on where the change falls. If the change falls on a period boundary (for example the first 30-minute file of a new season is also the first file of a period) nothing is lost. With a 60-minute averaging interval over 30-minute files, the hour containing the change is skipped and its neighbours are processed.

!!! note

    Warning(58), which previously fired for every period after the change, is not raised for a rate change any more. See [Error codes](error-codes.md#top).

## Rate survey and log lines

Before processing, EddyFlow reads the rate of a selection of files to find out whether the project has more than one rate, where it changes, and what the highest rate is. A survey reads:

- the first and the last file;
- 20 files spread evenly between them;
- the files at which the compressed size of neighbouring archives steps up or down. File size scales with the number of rows, so 10 Hz to 20 Hz roughly doubles it, and the file system reports the size at no cost.

Between any two files that were read and disagree, EddyFlow then reads the file halfway, and repeats until the two files that disagree are neighbours; the later one is where the new rate starts. This takes about log2(n) reads per change (about 15 reads for a year of half-hourly files), where reading every file would take far longer. Reading one rate means extracting the archive's metadata, about 0.1 s.

If the survey finds more than one rate, the log opens with a list such as:

```
 The raw files are not all at one acquisition frequency:
   5.000 Hz from 2021-08-21 01:00
  10.000 Hz from 2021-08-21 02:30
 (Frequencies read from 27 of 120 files.)
 Each averaging period is processed at its own files' frequency.
 Binned spectra are gridded up to the Nyquist frequency of 10.000 Hz.
```

(the file counts above are illustrative). A project at a single rate prints none of these lines.

The survey is not what processing relies on, because every archive's rate is checked again when it is imported. A change the survey missed (a rate that goes and returns between two files read at the same rate, with no size step to point at it) is therefore still processed correctly. What a miss costs is its line in the list.

### Binned-spectra frequency grid (Warning 117)

The frequency grid on which binned spectra, cospectra and ogives are written is built up to the Nyquist frequency of the **highest** rate found by the survey, so that no period's spectra are cut. If a period turns out to be at a faster rate than the survey found, Warning(117) is written: the binned spectra, cospectra and ogives of that period stop at the grid's Nyquist frequency. **Fluxes are not affected.**

## Spectral assessment per acquisition rate

The spectral assessment (the in situ determination of the system's transfer function, see [Low-pass filtering correction](low-pass-filtering.md#in-situ-assessment-at-more-than-one-acquisition-rate)) used to fit one noise line and one transfer function per gas over all periods. When the rate of a gas is not constant, a single fit is wrong: the noise floor depends on the rate, and so do the frequencies at which a cut-off can be resolved (the Nyquist frequency), so a fit over a mixture of rates is dominated by the top bins of the fast periods.

The assessment is done separately for each rate of each gas when:

- the **file rate** changes during the run, or
- the **analyser rate** changes while the file rate stays constant, for example a QCLS going from 1 Hz to 0.33 Hz inside a 20 Hz file.

For each rate, the ensemble spectra, the high-frequency noise floor, the transfer-function fit and the Nyquist check are computed on that rate's spectra only, and only up to that rate's own Nyquist frequency. Each period is then corrected with the result for **its own rate**.

- A gas whose rate never changed is fitted once, from all its periods, even if another gas changed rate.
- A rate for which no usable result exists (too few spectra, no resolvable cut-off) takes the result of the same gas at the **next faster** rate with a usable result, since a faster rate resolves the cut-off better. If there is no faster usable rate, the next slower one is used; if there is no usable rate at all, the gas falls back to the analytic method. Every substitution is listed in the log, for example `CO2 at 5.000 Hz: no usable spectral assessment of its own, using the 10.000 Hz result.`
- **A gas never borrows the result of another gas**, whatever its rate.
- The correction-factor model of [Ibrom et al. (2007)](references.md#Ibrom), which is derived from the covariance of w and temperature (not from a gas), is fitted per **file** rate.

Warning(119) is written once, listing each gas with its rates and the number of periods at each rate, for example `CO2: 10.000 Hz (3 periods), 5.000 Hz (3 periods)`.

On a test project, the CO2 cut-off frequency came out at 0.808 Hz at 10 Hz and 0.481 Hz at 5 Hz, and the CO2 flux of the same archive differed accordingly (8.10 at 5 Hz against 7.51 at 10 Hz). These figures illustrate the mechanism, not a typical size of the effect. On a QCLS station where no rate gives a resolvable cut-off, every rate falls back to the analytic method and applying the different rates' assessments to each other changed nothing.

### The `rates=` token in the spectral assessment file

The assessment output stays **one file**. For a gas with more than one rate, its block header carries a `rates=` token listing the rates (fastest first, in Hz), and each row carries **one value set per rate**, in the same order, after the `=`. For example, for rates 10 Hz and 5 Hz a month row holds the `Fn` and `fc` pair for 10 Hz followed by the pair for 5 Hz. The same convention is used for:

- the standalone water-vapour exponential, through tokens on its label row (its number row keeps the fastest rate's values), and
- the high-pass correction-factor model of Ibrom et al. (2007), which gets a `rates=` token and one `c1 c2` pair per **file** rate on the `unstable` and `stable` rows.

Compatibility:

- A project at one rate writes exactly the format it always wrote.
- The interface's assessment-file validator accepts the extra tokens and value sets ([Assessment tests](assessment-tests.md#how-a-multi-rate-file-is-accepted)).
- A version of EddyFlow that predates this format reads the first set on each row, which is the fastest rate's, and ignores the tokens.
- When a file is read back with `sa_mode=0` (**Spectral assessment file available for this dataset**), each rate's columns are applied to the periods at that rate. A file with a single set of columns applies it to all periods.

### Warning 119

Warning(119) informs you that the raw files are not all at one acquisition frequency for the listed gases, that their assessment is done per rate, that periods without a usable result of their own take the next faster one, and that the assessment file carries one column set per rate. It needs no action; it is there so that a multi-rate assessment is never produced silently.

## Dynamic metadata does not override the file's own rate (Warning 118)

When the embedded metadata of a .ghg archive is used, a [dynamic metadata](dynamic-metadata.md#top) file can no longer override the **acquisition frequency** or the **file duration** that the archive states about itself. The data were recorded and read at the archive's rate, so a different value from an external table would describe data that do not exist. If the dynamic metadata file states a value that differs from the archive's, Warning(118) is written once and the archive's values are used. All other dynamic metadata items keep working. The metadata retriever (the step that collects metadata from every file) continues to read every file at its own rate.

## Cut-off frequency versus each gas's own Nyquist frequency

A fitted cut-off frequency is only meaningful if the data could have shown it, that is, if it is below the Nyquist frequency of that gas (half its effective acquisition rate). EddyFlow now checks the cut-off of **every** gas against **its own** Nyquist frequency, on the **magnitude** of the fitted value. Before, only water vapour's relative-humidity fit was checked, and against the station's rate. Because the transfer-function model contains the cut-off only squared, the fit can land on either sign: a gas with no attenuation it can resolve came out at fc = -250 Hz, which was accepted and applied as an in situ correction factor of about 1.

A gas whose fitted cut-off lies above its own Nyquist frequency is now treated like any other unfitted gas and falls back to the **analytic method**.

!!! warning

    This changes results in projects with a single acquisition rate too, wherever a gas had an unresolvable fit. On the QCLS of one test site, the COS, CO2, CO and N2O fits (at 1, 0.5 and 0.33 Hz in a 20 Hz file) were such cases and are now analytic. A gas that was fitted properly is unaffected.

## Results that change in single-rate projects

Two fixes made for mixed-rate projects can change numbers in projects with one rate:

- The Nyquist check of the cut-off frequency (above), for gases whose fit was unresolved.
- The Fratini et al. (2012) period sizing (below), for projects with gaps or periods of different length.

## Fratini et al. (2012) period sizing

With the method of [Fratini et al. (2012)](references.md#Fratini2012), the full cospectrum was sized from the first full-cospectra file of the run. A shorter period (a slower rate, or simply a gap) integrated memory that had not been read, and a longer period was cut at the first file's Nyquist frequency. Each period is now sized from **its own** file. The routine that measured a file's length also never closed its file unit, so the first correction that opened the same file a second time found itself at the end of the file and stopped the run; this is fixed. Expect a numerical change for users of this method whose data contain gaps or mixed rates.

## Other fixes made on the way

- The highest acquisition rate over all records, and each analyser's, which sets the Nyquist limit of the relative-humidity fit, sat behind a flag that was never set, so the first record's rate stood. It is now evaluated on every record.
- One period above 10 Hz switched the block-averaging correction off for every later period. Each period now starts from the project's setting. (No effect on results yet, because that correction is not applied.)
- A high-frequency noise fit with fewer than two points above its start frequency divided by zero. An open-path hygrometer without a fitted relative-humidity class wrote the logarithm of NaN as its RH exponential. Both cases are now skipped and marked as unfitted.
- A spectral-assessment output file that could not be opened used to be written silently to a file `fort.<n>` in the working directory. This is fixed.
- Each archive's metadata is extracted under a fixed name, so an archive that was renamed after it was written is read in the same way.

## See also

- [Importing data](importing-data.md#top) for how files are read and merged.
- [Low-pass filtering correction](low-pass-filtering.md#top) and [Calculating spectral correction factors](calculate-spectral-correction-factors.md#top) for the correction methods.
- [Assessment tests](assessment-tests.md#top) for the checks the interface applies to assessment files.
- [Error codes](error-codes.md#top) for Warnings 116 to 119.
