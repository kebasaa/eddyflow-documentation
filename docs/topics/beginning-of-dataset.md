---
title: "Beginning of Data Set"
source_url: "https://www.licor.com/support/EddyPro/topics/beginning-of-dataset.html"
---
# Beginning of dataset

By convention, all output files of EddyFlow report results for each averaging interval, associating them with the timestamp of the ending minute of each interval, regardless of the convention used in the file names.

For example, imagine a 30 minute raw file with a name such as:

2011-02-15-1230_mysite.raw

with the timestamp referring to the beginning of the averaging period. It means the file contains data from 12:30 to 13:00 of 02/15/2011. Assume now that you select 15 minutes as a flux averaging period. From this file, you will get two result records with the following headings:

2011-02-15-1230_mysite.raw, 2011-02-15, 12:45

2011-02-15-1230_mysite.raw, 2011-02-15, 13:00

where the time refers to the end of each 15 minute block.

On the contrary, if the timestamp in the raw file name referred to the end of the averaging period, the file contained data from 12:00 to 12:30 and the corresponding result records would read:

2011-02-15-1230_mysite.raw, 2011-02-15, 12:15

2011-02-15-1230_mysite.raw, 2011-02-15, 12:30.
