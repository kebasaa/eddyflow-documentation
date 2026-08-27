# Importing EddyPro and EddyUH projects

If you have an existing project from LI-COR's EddyPro or from EddyUH, you do not need to rebuild it from scratch in EddyFlow. EddyFlow can import a legacy project file and convert it to the current EddyFlow formats: Processing Project file (.eddyflow, format version 5.1.0) and metadata file (.metadata, format version 3.2.2). Because the current formats are newer than the legacy ones, imported settings are upgraded during conversion, not simply read as-is, so it is worth reviewing the result before running a full dataset through it.

## Importing an EddyPro project

The engine (v8.0.0 and later) can ingest a legacy **.eddypro** project file directly and auto-convert it into an .eddyflow/.metadata pair.

**From the GUI:**

1. Click **File > Import EddyPro Project**.
2. Select the **.eddypro** file to import.
3. EddyFlow converts the project to the current .eddyflow (5.1.0) and .metadata (3.2.2) formats and opens it for review.

**From the command line:**

1. Run `eddyflow_rp` and pass the path to the legacy **.eddypro** file as the project file argument, for example:

   ```
   eddyflow_rp path\to\legacy_project.eddypro
   ```

2. The engine converts the file to .eddyflow/.metadata on this first run. The converted project is written alongside the original.
3. Run `eddyflow_fcc` against the resulting **.eddyflow** project to continue processing (flux computation).

!!! note

    The auto-conversion from `eddyflow_rp` happens once, on that first invocation. Subsequent runs should reference the converted .eddyflow project rather than the original .eddypro file.

## Importing an EddyUH project

Click **File > Import EddyUH Project** to convert a legacy EddyUH project into a new EddyFlow project.

As of GUI v8.1.0, this import produces a fully runnable project: it now carries across settings that earlier versions omitted, including `use_pfile`, gas and master sonic records, column selections, and the date range, as well as EddyUH despiking settings. The import dialog reports which settings could and could not be converted.

!!! note

    Before v8.1.0, importing an EddyUH project produced an incomplete project that was not runnable without manual fixes.

## What to verify after import

Imported projects should still be reviewed before production processing:

- Confirm the raw data directory, raw file name format, and date range are correct.
- Check the column/variable assignments in the metadata file, especially for gas analyzer and master sonic records.
- For EddyUH imports, confirm despiking settings and any other statistical screening or processing options carried over as expected.
- Review anything flagged by the import dialog as not converted, and configure it manually.
