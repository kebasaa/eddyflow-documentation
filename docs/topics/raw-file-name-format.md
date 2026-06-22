---
title: "Raw File Name Format"
source_url: "https://www.licor.com/support/EddyPro/topics/raw-file-name-format.html"
---
# Raw file name format

In order to correctly detect only valid raw files inside the ** Raw data directory ** (and possibly its subfolder), you need to specify a ** Raw file name format ** that EddyFlow uses as a template to select only files that comply with it. Valid raw files must match this template with respect to three aspects:

- The length of the file name must match the length of the template name.
- The timestamp tokens must match the wildcards of the template, see later.
- Any string prepended or appended to the timestamp (including file extension) must match between the file name and the template, with the exception of the question mark character (?)[1 Earlier versions of EddyFlow used an asterisk (*)](#), that is used in the template as a placeholder to allow variables characters in the file name, see examples below.

For each file type discovered in the Raw data directory, EddyFlow will provide you a sample file name. The easiest way to enter the Raw file name format is to:

1. Substitute timestamp information in the sample file name with the following characters:yy for a 2-digit year;yyyy for a 4-digit year;dd for a 2-digit day-of-month;mm for a 2-digit month-of-the-year;ddd for a 3-digit day-of-year (DOY);HH for a 2-digit hour;MM for a 2-digit minute.
2. Substitute any character that is expected to change between file names of the same dataset, with a question mark.

** Note:** All timestamp information must be present in raw file names. While day/month (or DOY) and hour information are virtually always available, years and minutes are sometimes not documented on file names. However, they are necessary to EddyFlow. A tool is available on demand to automatically rename raw files including missing timestamp information.

As an example, if the raw file name prototype is:

mysite_yyyy_ddd_HHMM_****.dat

then valid file names are:

mysite_2015_005_1030_abcd.dat

mysite_2015_005_1030_1234.dat

but the following ones are invalid:

mysight_2015_005_1030_abcde.dat (both prefix and suffix too long)

123456_2015_005_1030_1234.dat (although of the same length, the prefix is different from that in the template)
