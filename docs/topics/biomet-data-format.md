# Supported biomet file formats

EddyFlow supports biomet data in two main formats: embedded in compressed .ghg eddy covariance data files, and as external text files. These are described in detail below.

## Biomet data files embedded in .ghg files

The preferred, easiest, and most robust system to store and process biomet data is to collect them with a LI-COR biomet station. When collected through the SmartFlux 2 or 3 System, biomet data are stored in an ASCII, tab-separated file in a format that closely resembles that of the EddyFlow data files, featuring a preamble and a header with variable names and units. This biomet file, identified by the suffix -biomet.data, comes with a paired -biomet.metadata file, which describes the format and, more importantly, the content of the file, with identification of the variables, their units, the sampling and averaging rates, etc. This structure closely replicates that of the EddyFlow .data and .metadata. If the SmartFlux 2 or 3 System is collecting both eddy and biomet data, all four files are bundled together in a unique file with a .ghg extension containing all data corresponding to every time period of the specified length, and the corresponding metadata.

You can download a sample .ghg file including eddy and biomet files from the LI-COR web site. We suggest taking a few minutes to explore its content of this file. Unzip the file using, for example, 7-zip (after installation, right-click → 7zip → Extract Here) and open any of the files with a text editor. You will quickly figure out the format of both the .data and .metadata files and the organization of the content.

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

## Variable names, aliases and the positional qualifier

The label in the first header line identifies the variable. EddyFlow reads it as follows.

1. **The positional qualifier is stripped first.** Trailing `_<integer>` groups are removed from the right, one at a time, until the next segment is not a number. `SW_IN_1_1_1` becomes `SW_IN`, `TA_1_3_1` becomes `TA`, `P_RAIN_1_1_1` becomes `P_RAIN`, and a label with no qualifier, such as `SW_IN` itself, is left alone. This is why the number of underscores in a name does not matter.
2. **The remaining base name is matched whole**, ignoring capitalization, against the alias sets below. It is not matched by substring: `PPFD_OUT` is outgoing PAR and is not taken for incoming PAR just because it contains `PPFD`.
3. **The full label, qualifier included, is kept.** A file with `TA_1_1_1` and `TA_1_3_1` has two air-temperature channels, each averaged and written under its own label. Earlier versions kept only the part before the first underscore, which merged the two into a single `TA`.

The aliases below are accepted for the quantities EddyFlow uses in flux computation and correction.

| Quantity | Accepted base names |
| --- | --- |
| Air temperature | `TA`, `T_A`, `T_AIR`, `TAIR` |
| Atmospheric pressure | `PA`, `P_A`, `PAIR`, `P_AIR` |
| Relative humidity | `RH` |
| Global radiation (incoming shortwave) | `RG`, `R_G`, `RGLOBAL`, `R_GLOBAL`, `SWIN`, `SW_IN` |
| Longwave incoming radiation | `LWIN`, `LW_IN` |
| Photosynthetically active radiation, incoming | `PPFD`, `PPFD_IN` |

Global radiation and incoming shortwave radiation are the same quantity, so all six spellings are filed together as `SW_IN`. `LWIN` and `LW_IN` are filed as `LW_IN`. Outgoing PAR (`PPFDR`, `PPFD_R`, `PPFD_OUT`) is a separate quantity and is never used as incoming PAR. A single-letter name such as `G` or `P` used to slip into the interface's list of offered channels by matching part of a longer name; it no longer does. Whole-name matching decides what is offered for the ambient-measurement slots.

Other aliases recognized by the engine include (the full set is longer): `TBC`, `T_BC`, `T_BELOW_CANOPY`; `TS`, `T_S`, `T_SOIL`, `TSOIL`; `RN`, `R_N`, `NETRAD`, `NET_RAD`, `NET_RADIATION`, `RNET`, `R_NET`; `SWDIF`, `SW_DIF`, `RD`, `R_D`; `SWOUT`, `SW_OUT`, `RR`, `R_R`; `LWOUT`, `LW_OUT`; `PPFD_DIF`, `PPFDDIF`, `PPFDD`, `PPFD_D`; `PPFDBC`, `PPFD_BC`; `WS`, `WIND_SPEED`; `MWS`, `MAX_WIND_SPEED`; `WD`, `WIND_DIRECTION`; `P_RAIN`, `PRAIN`; `P_SNOW`, `PSNOW`; `SNOWD`, `SNOW_D`, `D_SNOW`, `DSNOW`; `SHF`, `G`; `SWC`; `TC`, `T_C`, `T_CANOPY`, `TCANOPY`; `TBOLE`, `T_BOLE`; `SAP_FLOW`, `SAPFLOW`; `STEMFLOW`, `STEM_FLOW`. The same spellings are accepted for embedded biomet (see [Biomet data embedded in .ghg files](#biomet-data-files-embedded-in-ghg-files)).

In the interface, the **Ambient measurements** variables (Basic Settings, dataset selection) list the channel that was matched, for example **Global Radiation 'SW_IN_1_1_1' (col 22)** or **Longwave Incoming Radiation 'LW_IN_1_1_1' (col 5)**, with the source **biomet files: Column # N**. See [Variables: Ambient measurements](introduction-dataset-selection.md#variables-ambient-measurements).

## Per-channel calibration with gain and offset

A biomet channel can be calibrated before it is used, which lets raw counts or voltages from a logger become physical readings without a pre-processing step outside EddyFlow. Two optional numbers per channel, `_gain` and `_offset`, are applied as

    value = raw × gain + offset

**before** the unit conversion, so the calibration is stated in the channel's own input unit and the result is then converted to EddyFlow standard units. Details:

- A channel that states neither is left untouched. A channel that states only a gain uses an offset of 0, and one that states only an offset uses a gain of 1.
- Missing-value codes are preserved: a record that is missing is not calibrated.
- There is no quadratic term.
- It applies to biomet embedded in .ghg files, where each channel's metadata carries `biomet_<n>_gain` and `biomet_<n>_offset`, and to external biomet files once `biom_use_native_header` is switched off (next section), because the two-line header of an external file has no room for calibration.

## Describing an external biomet file with a sidecar metadata file

**Project file key:** `biom_use_native_header` in the `[RawProcess_BiometMeasurements]` section. Default `1`: an external biomet file describes itself through its own two-line header, as described above, and nothing changes. There is no control for it in the interface; it is set in the project file (`biom_use_native_header=0`).

With `biom_use_native_header=0`, EddyFlow takes the per-channel description from a sidecar `.metadata` file in the same key=value format that biomet embedded in .ghg files uses, instead of from the header. This gives an external biomet file the calibration and channel description that embedded biomet has. Consequences:

- **Location of the sidecar.** For **Use external file**, the sidecar has the biomet file's name with the extension replaced by `metadata`, in the same folder (for `site_biomet.csv`, `site_biomet.metadata`). For **Use external directory**, it is named `biomet.metadata` and sits in the biomet directory.
- **One layout for all files.** Every file in a directory must share the column layout stated in the sidecar; the sidecar is read once, and each file's own header lines are skipped by count (`biomet_header_rows`, for a file with a two-line header write 2) and not parsed.
- **Contents.** `biomet_separator` (`tab`, `comma`, `semicolon`, `space`, or the character itself), `biomet_data_label`, `biomet_header_rows`, `biomet_file_duration`, `biomet_data_rate`, and per column `biomet_<n>_variable` (the label, with the `DATE` and `TIME` columns marked by those words), `biomet_<n>_id`, `biomet_<n>_instrument`, `biomet_<n>_unit_in`, `biomet_<n>_gain`, `biomet_<n>_offset`. A minimal sidecar:

        biomet_separator=comma
        biomet_data_label=none
        biomet_header_rows=0
        biomet_file_duration=daily
        biomet_data_rate=30
        biomet_1_variable=DATE
        biomet_2_variable=TIME
        biomet_3_variable=TA
        biomet_3_unit_in=K

- **If the sidecar cannot be read**, the log states "Biomet: could not read the sidecar metadata file" with its path and the biomet data are not used for the run.

## Pressure units

A biomet pressure channel stated in `Atm` is converted with the standard atmosphere, 101325 Pa exactly. Earlier versions used 98066.5 Pa (a technical atmosphere), so a channel in `Atm` came out 3.3% low. The conversions for `mmHg`, `Torr` and `PSI` were also tightened, by less than 0.003%. Channels in Pa, hPa or kPa are unaffected.

## Embedded biomet crash

Processing .ghg files with embedded biomet data used to end in a segmentation fault on every run. This is fixed; embedded biomet is read, calibrated and averaged as described above.
