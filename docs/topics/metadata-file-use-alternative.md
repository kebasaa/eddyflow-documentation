---
title: "Use Alternative Metadata File"
source_url: "https://www.licor.com/support/EddyPro/topics/metadata-file-use-alternative.html"
---
# Use alternative metadata file

Metadata is simply information about the dataset—or data on the data. It includes site information, instrument information, and a description of the raw file structure.

There are three scenarios in which you need to use an alternative metadata file, rather than those embedded inside the .ghg files:

- You need to process raw files others than .ghg files;
- You want to process .ghg files but information in the embedded metadata files needs to be bypassed because it is incorrect, for example;
- You want to process .ghg files but information in the embedded metadata files can be bypassed, for example, because it is identical for all .ghg files. In this case, using an alternative metadata file will result in faster processing.

In the first case, no metadata file is available, so it must be created and saved using the Metadata File Editor. Learn more about the [Metadata file editor](metadata-file-editor.md#top).

In the latter two cases, a metadata file is available, so the process of creating the alternative metadata file can be greatly simplified. Unzip any .ghg file using an archive manager (such as 7-zip or ZipGenius). Locate the extracted metadata file and load it from the ** Use alternative metadata file ** ** Load ** button. Make changes if needed and save the file.

** Important:** Using an alternative metadata file means that all .ghg files will be interpreted and processed using identical meta-information. This implies that data files must all be identical in structure and that dynamic variations of meta-information cannot be taken into account unless you provide a dynamic metadata file.
