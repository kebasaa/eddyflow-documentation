# Troubleshooting and tips

Here we provide some general tips for solving common problems. For a list of specific run failures and their solutions, see [Run errors](error-codes.md#top). For answers to common questions, see the [FAQs](../reference/faqs.md#top).

## Check the Messages panel first

EddyFlow lists incomplete or inconsistent settings in the Messages panel (**View > EddyFlow Messages**). Messages in red font must be resolved before you can advance to the next page or run the project; messages in blue or green font are informational. Reviewing this panel before running a project catches most configuration issues early.

## Verify the raw file name format

A large share of "no valid data files found" and similar startup failures trace back to a mismatch between the **Raw file name format** and the actual file names in the input folder. See [Raw file name format](raw-file-name-format.md#top).

## Check the metadata file

If a run fails partway through, or produces implausible fluxes, check that the metadata (station, instruments, and raw file description) actually matches the dataset being processed — for example, the wrong instrument model, path lengths, or column mapping. See [Using the Metadata File Editor](metadata-file-editor-using.md#top).

## Isolate the failing file

If a run fails at a particular raw file but that same file processes correctly on its own, the file is often not itself corrupted; more commonly a neighboring file in the same batch has a formatting problem (e.g. an inconsistent timestamp or column count) that only surfaces during batch processing. Narrow down the failing file by processing smaller batches, then inspect it as described in [Run errors](error-codes.md#top).

## Large datasets and performance

For datasets spanning many months or years, expect substantially longer processing times, particularly with spectral corrections, Advanced Mode planar fit, or time lag optimization pre-passes enabled. Use the `-j`/`--jobs` command-line option (see [Command Line](command-line.md#top)) to parallelize the planar fit and time lag pre-passes across multiple CPU cores and reduce run time.

## Problems with shared drives (Google Drive and Dropbox)

A **Remote Drive** warning in the interface, or **Fatal error(120)**, **Warning(121)** or **Fatal error(122)** in the run log, points at an input read from a shared link. Check these first:

- The folder or file is shared with **Anyone with the link**. Open the link in a browser where you are not signed in to confirm.
- The link is a Google Drive or Dropbox share link, and it points at a folder where a folder is needed and a file where a file is needed.
- The computer can reach the internet, both in the interface and while the run is going.
- `curl` is available (`curl.exe` ships with Windows 10 and later). Its absence stops the run with Fatal error(120).
- The **Output directory** is a local folder. A link there is refused (Fatal error(122)).
- A single raw file that fails to download three times is skipped with Warning(121); the periods that needed it are lost or reduced. Rerun when the connection is stable.

See [Remote folders and shared links](remote-folders.md#troubleshooting) for the complete list of messages and their causes.

## Still stuck?

Consult the [Calculation Reference](software-reference.md#top) and [Interface Feature Reference](software-reference-introduction.md#top) sections for details on any specific setting, or check the project's GitHub repository for known issues.
