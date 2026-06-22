---
title: "Error Codes"
source_url: "https://www.licor.com/support/EddyPro/topics/error-codes.html"
---
# Run errors

If an EddyFlow run fails, it typically has to do with the setup or data files being processed. Here are some solutions to common issues.

## EddyFlow processing stops immediately or does not start

The processing log typically says ** No valid data files found ** in the folder.

This often arises from an incorrect ** Raw file name format **. See [Raw file name format](raw-file-name-format.md#top) for more details.

## EddyFlow starts processing but fails: Unable to use Biomet Data File or Dynamic Metadata File

This is typically caused by a timestamp issue in the data files.

Errors may arise from an improper number of characters or unacceptable formatting in the time stamp fields of external biomet files. Here are several examples and solutions:

** Example 1:** This file has incorrect formatting in the day-of-year, hour, and minute columns. All values in the day-of-year column should have three characters. Some have only two. The same applies to the hour and minute fields, which have one or two characters instead of the required two.

![Screenshot showing how a spreadsheet can alter the time stamp](../assets/bad-time-stamp01.png)

** Example 2:** This file shows automatic formatting done by Excel® for the first timestamp that contains the date. It also shows the same issue from Example 1 in the hour/minute column.

![Scren shot showing how a spreadsheet can alter the time stamp](../assets/bad-time-stamp02.png)

** Solutions:**

1. With the files open in Excel, configure the date formatting.
2. Select the column that needs to be corrected. Right click and select Format Cells.
3. ![Fix a bad time](../assets/bad-time-fix01.png)
4. To correct the date formatting, click Custom. Under Type, enter yyyy-mm-dd.
5. ![Fix a bad time](../assets/bad-time-fix02.png)
6. To correct day of year, select the column and open Format Cells. Select Custom and enter 000 to specify three-digit day of year.
7. ![Fix a bad time](../assets/bad-time-fix03.png)
8. To correct hour and minute, select the column and open Format Cells. Select Custom and enter 0000 to specify four-digit time.
9. ![Set to custom](../assets/bad-time-fix04.png)
10. Click ** OK** and save the file in its original format.

## EddyFlow starts processing but fails: Too many implausible values for xyz columns

If the error happens at the first file:

1. The metadata is incorrect under Raw File Description, check the Number of Header Rows and separator
2. Go to the ** Statistical Analysis > Absolute Limits ** and clear the ** Filter outranged values ** option or expand the allowed ranges.

If the error happens after processing a few files, consider the following:

1. The data file format or structure has changed in one or more files.
2. The folder may have files with different metadata.
3. When processing `.ghg ` files, the EddyFlow interface loads the first file in the folder when you select the raw data folder. It uses the metadata for that file to set up processing. When data processing starts, the processing engine uses that information for subsequent files. Data processing proceeds until the file format or structure changes (i.e., different number of variables or variables in different order), at which point there is a mismatch between the metadata and the data file and EddyFlow fails to process that file. The solution is to processes files with different data format or structures separately by putting the raw data files into a separate folder.
