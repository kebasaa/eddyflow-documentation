# TOB1 file type

See [Processing ASCII and TOB1 raw data files](processing-ascii-and-tob1-files.md#top) for a tutorial on this procedure.

TOB1 is a binary format often used for storing raw data obtained from Campbell® Scientific dataloggers. These files are customizable, as one can select the format of each individual variable (e.g. integer, single precision, etc.). EddyFlow can process TOB1 files with the following characteristics:

- TOB1 files that contain only variables in the formats "ULONG" and "IEEE4", no matter how these are intercalated;
- TOB1 files that contain only variables in the formats "ULONG" and "FP2", provided that the variables in the "ULONG" format precede those in the "FP2" format.

Thus, files containing variables in the "IEEE4" and "FP2" formats are not supported. Similarly, files in which "FP2" variables precede "ULONG" variables are not supported.

** Note:** "ULONG" variables are not actually imported (they are skipped), which implies that variables in this format must be described with the property of ** Ignore **. This is usually not a limitation, because the "ULONG" format is normally reserved to timestamp information that EddyFlow does not use anyway.

When you select the TOB1 format, a further option activates to specify the "IEEE4" or "FP2" format. If you are unsure, select the option ** Detect automatically **. EddyFlow will rely on the header of TOB1 files to determine the actual format.

When you describe TOB1 files in the ** Metadata File Editor **, just consider each variable as a column, (although the term "column" is not appropriate for unformatted binary data), and proceed as you would do with any ASCII file.
