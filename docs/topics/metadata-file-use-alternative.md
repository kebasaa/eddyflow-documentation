# Use alternative metadata file

Metadata is simply information about the dataset—or data on the data. It includes site information, instrument information, and a description of the raw file structure.

There are three scenarios in which you need to use an alternative metadata file, rather than those embedded inside the .ghg files:

- You need to process raw files others than .ghg files;
- You want to process .ghg files but information in the embedded metadata files needs to be bypassed because it is incorrect, for example;
- You want to process .ghg files but information in the embedded metadata files can be bypassed, for example, because it is identical for all .ghg files. In this case, using an alternative metadata file will result in faster processing.

In the first case, no metadata file is available, so it must be created and saved using the Metadata File Editor. Learn more about the [Metadata file editor](metadata-file-editor.md#top).

In the latter two cases, a metadata file is available, so the process of creating the alternative metadata file can be greatly simplified. Unzip any .ghg file using an archive manager (such as 7-zip or ZipGenius). Locate the extracted metadata file and load it from the **Use alternative metadata file** **Load** button. Make changes if needed and save the file.

!!! warning

    Using an alternative metadata file means that all .ghg files will be interpreted and processed using identical meta-information. This implies that data files must all be identical in structure and that dynamic variations of meta-information cannot be taken into account unless you provide a dynamic metadata file.

## Choosing the file in the interface

**Use alternative file:** (radio button, project key `use_pfile`) turns on the alternative metadata file. Choose it with **Load** (dialog **Select the Metadata File**), or with **Remote drive...** to take a file from a shared Google Drive or Dropbox link; see [Remote folders](remote-folders.md#top). A file taken from a drive is copied next to the project immediately and the project points at the local copy, because EddyFlow updates this file when you edit it in the Metadata File Editor. If a file of that name already exists next to the project you are asked whether to overwrite it, keep both (the copy is named `name_1.metadata`) or cancel. If you create a new metadata file from scratch in the editor, its path appears in the field. Leave **Use embedded file** selected to read the metadata inside each .ghg file.

Empty numeric entries in an alternative metadata file are read as the setting's default and not as 0; see [Metadata file editor](metadata-file-editor.md#behavior-when-metadata-is-read). If a dynamic metadata file is also used, see [Time-varying (dynamic) metadata](dynamic-metadata.md#top); it cannot change the acquisition frequency or file duration of a .ghg file.
