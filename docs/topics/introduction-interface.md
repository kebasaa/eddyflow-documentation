# Project creation page

The Project Creation page is where you specify details about your project, including the project name and raw file format. The visible fields on the projects page depend on the file type you are processing. For .ghg files, under a typical scenario, you will only need to enter the **Project Name** before advancing to the **Basic Settings** page. Under other circumstances, or any time you are processing a file other than the .ghg file type, you will need to use the **Metadata File Editor** to create or modify an existing metadata file.

You can also specify a dynamic metadata file, or instruct EddyFlow to use bio-meteorological ("biomet") data from another file or files contained in a folder.

![](../assets/Project_Page1.png)

Fields in the **Project Creation** page are described below:

## Project name

Enter a name for the flux computation project. This will be the default file name for this project, but you can edit it while saving the project. This field is optional. The graphical interface does not allow the use of characters that result in file names unacceptable to the underlying operating system (for Windows these include: \\ /: @ ? * " < >).

## Raw file format

Select the format of your raw files. Supported formats are described below:

**LI-COR .ghg:** A compressed raw file format for complete eddy covariance raw data files. Each .ghg file is an archive containing the raw high-frequency data (with a .data extension) and the corresponding metadata (with a .metadata extension) describing the format and content of the data file, and giving essential information about the study site. Both files are in readable text format. Files can also include bio-meteorological data and corresponding metadata. See [.ghg file type](ghg-file-format.md#top).

**ASCII Plain Text:** Any text file organized in data columns, with or without header. All typical field separators (tab, space, comma and semicolon) are supported. The Campbell® Scientific TOA5 format is an example of a supported ASCII data file. See [Processing ASCII and TOB1 raw data files](processing-ascii-and-tob1-files.md#top) for a tutorial.

**Generic Binary:** Generic binary (unformatted) raw data files. Limited to fixed-length binary words that contain data stored as single precision (real) numbers. Click the **Settings...** button and provide specifications of the binary format:

- **Number of ASCII header lines:** Enter the number of ASCII (readable text) header lines present at the beginning of the binary files. Enter 0 if there is no ASCII header.
- **ASCII header end of line:** If an ASCII header is present in the files, specify the line terminator. Typically, Windows operating systems use Carriage Return + Line Feed (0x0D+0x0A), Linux operating systems and macOS use Line Feed (0x0A), while Mac operating systems up to version 9 and OS-9 use Carriage Return (0x0D).
- **Number of bytes per variable:** Specify the number of bytes reserved for each variable stored as a single precision number. Typically, 2 bytes are reserved for each number.
- **Endianess:** In a multi-bytes binary word, *little endian* means that the most significant byte is the last byte (highest address); *big endian* means that the most significant byte is the first byte (lowest address).

**TOB1:** Raw files in the Campbell® Scientific binary format. Support of TOB1 format is limited to files containing only ULONG and IEEE4 fields, or ULONG and FP2 fields. In the second case, FP2 fields must follow any ULONG field, while for ULONG and IEEE4 there is no such limitation. See [Processing ASCII and TOB1 raw data files](processing-ascii-and-tob1-files.md#top) for a tutorial.

!!! note

    ULONG fields are not interpreted by EddyFlow, thus they can only be defined as "ignore" variables.

- **Detect Automatically:** Let EddyFlow figure out whether TOB1 files contain (ULONG and) IEEE4 fields or (ULONG and) FP2 fields.
- **Only ULONG and IEEE4 fields:** Choose this option to specify that your TOB1 files contain only IEEE4 fields and possibly ULONG fields. EddyFlow does not interpret ULONG fields. This means that any variable stored in ULONG format must be marked with "ignore" in the Raw File Description table. Typically ULONG format is used for time stamp information.
- **Only ULONG and FP2 fields:** Choose this option to specify that your TOB1 files contain only FP2 fields and possibly ULONG fields. ULONG fields, if present, must come first in the sequence of fields. EddyFlow does not interpret ULONG fields. This means that any variable stored in ULONG format must be declared marked with the "ignore" option in the Raw File Description table. Typically ULONG format is used for time stamp information.

**SLT (EddySoft):** Format of binary files created by EddyMeas, the data acquisition tool of the EddySoft suite, by O. Kolle and C. Rebmann (Max Planck Institute, Jena, Germany). This is a fixed-length binary format. It includes a binary header in each file that needs to be interpreted to correctly retrieve data. EddyFlow does everything automatically.

**SLT (EdiSol):** Format of binary files created by EdiSol, the data acquisition tool developed by Univ. of Edinburg, UK. This is a fixed-length binary format. It includes a binary header in each file that needs to be interpreted to correctly retrieve data. EddyFlow does everything automatically.

## Metadata

Metadata is information that describes the raw eddy covariance data. More specifically, it describes where and how the data were collected, what instruments were used, and how the data are arranged in the data files. Choose whether to use metadata files embedded into .ghg files or to bypass them by using an alternative metadata file. See [Metadata file editor](metadata-file-editor.md#top) and [.ghg file type](ghg-file-format.md#top).

**Use embedded file:** Select this option to use file-specific metadata, retrieved from the metadata file residing inside the .ghg file.

**Use alternative file:** Select this option to use an alternative metadata file. In this case all files are processed using the same metadata, retrieved from the alternative metadata file. This file is created and/or edited in the **Metadata File Editor**. If you are about to process .ghg files, you can speed up the completion of the alternative metadata file by unzipping any raw file and loading the extracted metadata file from the **Use alternative metadata file > Load** button. Make changes if needed and save the file.

**Load:** Load an existing metadata file. If you use the Metadata File Editor to create and save a new metadata file from scratch, its path will appear here.

**Remote drive...:** Choose the alternative metadata file from a Google Drive or Dropbox folder shared with **Anyone with the link**. The file is copied next to the project, and the project then points at the copy, so that the **Metadata File Editor** can update it. See [Remote folders and shared links](remote-folders.md#top).

**Use dynamic metadata file:** Check this option and provide the corresponding path to instruct EddyFlow to use an externally-created file that contains time changing metadata, such as canopy height, instrument separations and more. See [Time-varying (dynamic) metadata](dynamic-metadata.md#top).

**Remote drive...:** Next to **Load**, picks the dynamic metadata file from a shared Google Drive or Dropbox folder. See [Remote folders and shared links](remote-folders.md#top).

## Biomet data

**Biomet data:** Select this option and choose the source of biomet data. Biomet data are slow (< 1Hz) measurements of biological and meteorological variables that complement eddy covariance measurements. Some biomet measurements can be used to improve flux results (ambient temperature, relative humidity and pressure, global radiation, PAR and long-wave incoming radiation). All biomet data available are screened for physical plausibility, averaged on the same time scale of the fluxes, and provided in a separate output file if requested.

- **Use embedded files:** Choose this option to use data from biomet files embedded in the .ghg files. This option is only available for files collected with the original SmartFlux System or SmartFlux 2 and 3 Systems, provided a biomet system was used during data collection. EddyFlow will automatically read biomet files from the files, interpret them and extract relevant variables.
- **Use external file:** Choose this option if you have all biomet data collected in a single external file. Provide the path to this file by using the **Load...** button. **Remote drive...** picks the file from a shared drive instead (see [Remote folders and shared links](remote-folders.md#top)).
- **Use external directory:** Choose this option if you have biomet data collected in more than one external file, and provide the path to the directory that contains those files by using the **Browse...** button. **Remote drive...** picks a folder of a shared Google Drive or Dropbox instead (see [Remote folders and shared links](remote-folders.md#top)).

!!! warning

    All biomet files must be formatted according the guidelines that you can find in [External biomet files](biomet-data-format.md#ExternalBiomet).

## Where Browse opens (8.1.2)

**Exact UI label:** **Browse...** (and **Load...**), on every field that takes a folder or a file.

The file or folder dialog opens at the first of these places that exists:

1. The path the field already holds.
2. The location the field was given, even if it has since gone: the dialog opens at the nearest folder above it that still exists.
3. The folder where that field was last browsed. This is remembered separately for each field.
4. The folder of the project that was opened last.

A file field opens with its file already selected, but only while that file exists. For the **Raw data directory** and the **Output directory**, the value the project held before the field was cleared is used, so a folder that has gone still points the dialog at its nearest parent.

A shared drive link is never used as a start folder, and **Remote drive...** is not affected: it still opens the drive the field points to (see [Remote folders and shared links](remote-folders.md#top)). The Metek head correction **Table directory** now remembers its last location like the other fields. Before this change a field filled from a project could open somewhere unrelated, wherever that field had been browsed last.

## Messages while settings are applied (8.1.2)

When EddyFlow changes settings for you, for example when you pick a run mode or an output preset on the **Output Files** page, or when a project is loaded, warnings and information boxes that would only announce those changes are written to the interface's own message log (not the run log of the engine) instead of opening a window; each entry starts with "Not shown while settings were being applied:". Messages that report a failure that stopped something, and every question, still open a window.
