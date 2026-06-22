---
title: "Supported Biomet Files Formats"
source_url: "https://www.licor.com/support/EddyPro/topics/biomet-data-format.html"
---
# Supported biomet file formats

EddyFlow supports biomet data in two main formats: embedded in compressed .ghg eddy covariance data files, and as external text files. These are described in detail below.

## Biomet data files embedded in .ghg files

The preferred, easiest, and most robust system to store and process biomet data is to collect them with a the original publisher biomet station. When collected through the SmartFlux 2 or 3 System, biomet data are stored in an ASCII, tab-separated file in a format that closely resembles that of the EddyFlow data files, featuring a preamble and a header with variable names and units. This biomet file, identified by the suffix -biomet.data, comes with a paired -biomet.metadata file, which describes the format and, more importantly, the content of the file, with identification of the variables, their units, the sampling and averaging rates, etc. This structure closely replicates that of the EddyFlow .data and .metadata. If the SmartFlux 2 or 3 System is collecting both eddy and biomet data, all four files are bundled together in a unique file with a .ghg extension containing all data corresponding to every time period of the specified length, and the corresponding metadata.

You can download a sample .ghg file including eddy and biomet files from the the original publisher web site. We suggest taking a few minutes to explore its content of this file. Unzip the file using, for example, 7-zip (after installation, right-click → 7zip → Extract Here) and open any of the files with a text editor. You will quickly figure out the format of both the .data and .metadata files and the organization of the content.

## External biomet files

If you don't have biomet data collected with the .ghg files, or if you want to process data collected as text files, you can still do so by formatting your biomet file(s) as described below.

External biomet files must be formatted (outside EddyFlow, for example using MS Excel) in such a way that EddyFlow can interpret them without the need to specify anything in the EddyFlow interface. This means that extreme care must be given in correctly labeling variables, writing units, defining timestamps, etc.

Following you can find detailed guidelines that should allow you to correctly format your biomet file(s):

- Files are formatted as ASCII, comma-separated files;
- Each data line—terminated by CR/LF (Windows) or by LF (Mac/Linux)—is a record of biomet measurements, identified by a timestamp;
- Each file starts with a 2-line header:In the first line, a label is associated to each data column (including the timestamp) to identify the variable. For the naming convention, refer to the tables below;In the second line, a label is associated with each data column (including the timestamp) to identify the unit of each measurement. For the naming convention, refer to the tables below;Capitalization in the header is irrelevant;Location qualifier: The variable labels in the first line of the header can include as a suffix the "location qualifier" designed by the [European Fluxes Database Cluster](http://www.europe-fluxdata.eu/home/guidelines/how-to-submit-data/variables-codes). The location qualifier is comprised of a numeric triplet in the form _X_Y_Z where X, Y and Z are integer numbers identifying the location of the instrument/sensor that measured the variable. An example of a label with location qualifier is: TA_1_2_3. If you are not required to use the location qualifier, you can simply use the variable label. Note, however, that EddyFlow outputs are standardized on the usage of the location qualifier. Any time EddyFlow encounters a variable without the qualifier, EddyFlow will rename it by adding a default qualifier as a suffix to the label provided. As an example, if the variable is labeled TA, the variable will be identified as TA_0_0_1 in the biomet output. If there are multiple instances of the same variable, the last number of the default qualifier will be increased: TA_0_0_2, …, TA_0_0_5", …Since the official usage of the location qualifier does not foresee the use of zeros, having zeros in the first two positions of the qualifier in EddyFlow's output is an indication that the variable was provided without qualifier.

- Timestamps: Timestamps can occupy up to 7 (comma-separated) fields, that can appear anywhere in the file (i.e., not necessarily in the first columns). In the first header line, timestamp columns are identified by the labels:

TIMESTAMP_1, TIMESTAMP_2, ..., TIMESTAMP_7

In the second header line, the format of the timestamp is specified according to the following conventions:

| Variable | EddyFlow Label | Description of corresponding data |
| --- | --- | --- |
| yyyy | year | 4-digit integer number |
| mm | month of year | 2-digit integer number, between 01 and 12 |
| ddd | day of year | 3-digit integer number, between 001 and 366 |
| dd | day of month | 2-digit integer number, between 01 and 31 |
| HH | hour of the day | 2-digit integer number between 00 and 23 |
| MM | minute of the hour | 2-digit integer number between 00 and 59 |

The following examples are of valid timestamp headers and data:

TIMESTAMP_1, ...

yyyy-mm-dd HHMM, ...

2012-04-05 0800, ...

TIMESTAMP_1, TiMeStAmP_2, ...  
yyyy-mm-dd, HHMM, ...  
2012-04-05, 0800, ...

TIMESTAMP_1, TIMESTAMP_2, Timestamp_3, ...

yyyy, ddd, HHMM, ...

2012, 96, 0800, ...

TIMESTAMP_1, Timestamp_2, TIMESTAMP_3, Timestamp_4, ...

yyyy, ddd, HH, MM, ...

2012, 096, 8, 00, ...

Labeling and units conventions for formatting external biomet files:

| Variable | EddyFlow Label | EddyFlow Units | How to Write Units | Other Supported Units |
| --- | --- | --- | --- | --- |
| Air Temperature | Ta | K | K | C, cC, F, cF, cK |
| Atmospheric pressure | Pa | Pa | Pa | hPa, kPa, PSI, Torr, mmHg, Atm, Bar |
| Relative humidity | RH | % | % | # |
| Canopy temperature | Tc | K | K | C, cC, F, cF, cK |
| Air temperature below canopy | Tbc | K | K | C, cC, F, cF, cK |
| Diffuse radiation | Rd | W m-2 | W+1m-2 | J s-1 m-2 |
| Reflected radiation | Rr | W m-2 | W+1m-2 | J s-1 m-2 |
| Global radiation | Rg | W m-2 | W+1m-2 | J s-1 m-2 |
| Net radiation | Rn | W m-2 | W+1m-2 | J s-1 m-2 |
| UVA radiation | R_uva | W m-2 | W+1m-2 | J s-1 m-2 |
| UVB radiation | R_uvb | W m-2 | W+1m-2 | J s-1 m-2 |
| Longwave incoming radiation | LWin | W m-2 | W+1m-2 | J s-1 m-2 |
| Longwave outgoing radiation | LWout | W m-2 | W+1m-2 | J s-1 m-2 |
| Shortwave incoming radiation | SWin | W m-2 | W+1m-2 | J s-1 m-2 |
| Shortwave outgoing radiation | SWout | W m-2 | W+1m-2 | J s-1 m-2 |
| Shortwave below canopy | SWbc | W m-2 | W+1m-2 | J s-1 m-2 |
| Shortwave incoming diffuse | SWdif | W m-2 | W+1m-2 | J s-1 m-2 |
| Photosynthetic photon flux density | PPFD | μmol m-2 s-1 | umol+1m-2s-1 | μE m-2 s-1 |
| Diffuse PPFD | PPFDd | μmol m-2 s-1 | umol+1m-2s-1 | μE m-2 s-1 |
| Reflected PPFD | PPFDr | μmol m-2 s-1 | umol+1m-2s-1 | μE m-2 s-1 |
| Below Canopy PPFD | PPFDbc | μmol m-2 s-1 | umol+1m-2s-1 | μE m-2 s-1 |
| Total precipitation | P | m | m | um, μm, mm, cm, km |
| Rain precipitation | P_rain | m | m | um, μm, mm, cm, km |
| Snow precipitation | P_snow | m | m | um, μm, mm, cm, km |
| Snow depth | SNOWd | m | m | um, μm, mm, cm, km |
| Maximum wind speed | MWS | m s-1 | m+1m-1 | cm s-1, km h-1 |
| Wind direction | WD | deg. from N | degrees | - |
| Bole temperature | Tbole | K | K | C, cC, F, cF, cK |
| SapFlow | SapFlow | g h-1 | g+1h-1 | - |
| StemFlow | StemFlow | g h-1 | g+1h-1 | - |
| Soil temperature | Ts | K | K | C, cC, F, cF, cK |
| Soil heat flux | SHF | W m-2 | W+1m-2 | J s-1 m-2 |
| Soil water content | SWC | m3 m-3 | m+3m-3 | - |
