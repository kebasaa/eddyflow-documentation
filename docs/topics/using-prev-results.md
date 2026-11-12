# Using results from previous runs

An Advanced run processes raw data in one or two steps. You click **Run** once and EddyFlow goes through them on its own:

- **Raw data processing (RP):** raw files are imported, filtered, corrected and processed into mean values, covariances, uncorrected fluxes, turbulence parameters and (co)spectra. This step reads every raw file and takes by far the most time.
- **Flux computation and correction (FCC):** fluxes are corrected, starting from what RP computed. It works on the half-hourly statistics only and takes a small part of the run time.

With a purely analytic spectral correction method (or none), and without ensemble-averaged spectra or cospectra outputs, RP also corrects the fluxes and the run ends there. Otherwise RP writes an intermediate FLUXNET file, `eddyflow_OutputID_fluxnet_yyyy-mm-ddThhmmss_adv.csv`, plus the binned and full cospectra, and FCC continues from them.

## Re-running only the flux correction

When only flux-correction settings changed since the last run, RP would compute the same intermediate results again. EddyFlow can then skip it and re-run only FCC on the results the previous run left in the output folder. Examples of such settings are the spectral assessment limits and periods, the low-frequency correction, the footprint model, the quality flagging scheme and the result files.

When you start a run in Advanced mode and the output folder holds results of an earlier run, the **Advanced run** dialog asks how to treat them. If date subsets are set, the same dialog also shows them. When the output folder holds no earlier run, the run starts straight away as a full run (after the date check, if date subsets are set). In the dialog's **Previous run** section:

- **Flux correction only (reuse the raw-processing results)** is selected when it is possible. A note reminds you that EddyFlow compares the settings, not the contents of the metadata, biomet or raw data files. Use this option only if those files are unchanged since the previous run.
- **Full re-run (raw processing and flux correction)** processes the raw data again.
- When **Flux correction only** is not possible, it is greyed out and the dialog lists the reasons. It names any setting that requires raw processing again, and explains how to keep the raw-processing results next time.

The buttons decide what happens to the files the chosen run makes obsolete:

- **Keep and run** (the default) leaves every earlier file in place.
- **Delete and run** removes them before the run starts. With **Flux correction only**, these are the files of earlier flux corrections over the same raw processing (full output, FLUXNET and metadata files, spectral analysis files, log and `processing_*.eddyflow` copy). The raw-processing results are kept. With **Full re-run**, they are all files that earlier runs of this project wrote under EddyFlow's own names, including the binned and full cospectra. Other files in the output folder are never touched. **Show files** lists what would be deleted.

Clearing the cospectra folders before a full re-run also matters for the results. The flux correction reads every file in those folders, so cospectra left there by an earlier run would be read together with the new ones.

## When a correction-only run is possible

EddyFlow offers **Flux correction only** when all of the following hold:

- **Previous run is on record.** The output folder holds the `processing_yyyy-mm-ddThhmmss_adv.eddyflow` copy of an earlier Advanced run of this project, as written at the end of every flux correction.
- **Intermediate file kept.** The intermediate FLUXNET file it names is still there, and was written by a version whose flux correction can read it. The flux correction deletes this file when it finishes, unless **Keep raw-processing results for a faster correction-only re-run** is checked in [Output files](output-files.md#keep-raw-processing-results). That box is checked by default.
- **No raw-processing setting changed.** None of the settings raw processing reads has changed since that run. These are everything on **Project Creation** and **Basic Settings**, the raw processing options and statistical tests, and among others the random uncertainty, limit of detection, WPL terms and the spectral correction method. Paths to files are compared, not the files' contents.
- **Flux correction needed.** The current settings need the flux correction at all: an *in situ* spectral correction method (Horst, Ibrom, Fratini), or ensemble-averaged spectra or cospectra outputs.
- **Spectra available.** The binned cospectra (and, for Fratini et al. 2012, the full cospectra) that the current settings need were written by that raw processing, and no other run's files are mixed in with them.

If a flux correction that followed its raw processing fails or is stopped, EddyFlow records the raw processing in the output folder, so that the flux correction alone can be run again.
