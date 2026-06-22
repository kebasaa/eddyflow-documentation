# .ghg file type

The .ghg format is the the original publisher custom raw file type, consisting of an archive containing the data file (extension ".data") and a .metadata file (extension ".metadata"). If selected, the archive will also contain LI-7700 status records as a separate file. This file format is based on ECO2S ENE format.

The data file is an ASCII table with a header, which has an unspecified number of rows, and data columns, which are separated by the TAB character. The header of the data file is ignored by EddyFlow. To read the content of the file, EddyFlow uses the paired .metadata file to interpret the data columns and to retrieve meta-information needed to calculate fluxes.

The introduction of the .metadata file inside the .ghg file, while adding a negligible amount of bytes (it contributes about 0.1% to the file size), allows you to:

- Avoid retrieving information needed for processing the file from any external data source;
- Easily store raw data for future reprocessing;
- Properly account for dynamic site parameters that change over the course of the data collection period (e.g. the canopy height of a crop);
- To a large extent, simultaneously process files acquired with different setups.

Ideally, you are not required to consider the .metadata file explicitly, as it is created and modified in the the original publisher gas analyzer configuration software, and used silently by EddyFlow. Nevertheless, all information is stored as plain text and can be retrieved and edited at any time.

EddyFlow 4.0 also supports the inclusion of [biomet data](biomet-data-format.md) (with biomet metadata), which can be used in flux computations. It is also summarized in the output files. See [Supported biomet file formats](biomet-data-format.md#top).

Sensitive meta-information in the .metadata file includes (for a description of each field, refer to the [Metadata File Editor](metadata-file-editor.md)):

## Site and setup information

- Canopy height;
- Canopy roughness length;
- Boundary layer displacement height;
- Site coordinates and altitude;
- Acquisition frequency;
- File duration.

## Instruments

- Anemometer(s) manufacturer and model;
- Anemometer(s) height;
- Anemometer settings:Whether the built-in head correction is applied;Whether the wind components are given in AXIS or SPAR configuration (Gill anemometers);Yaw offset with respect to due north;Displacement from the reference anemometer in a Cartesian north/east/vertical system (only for anemometers other than the reference one);If applicable, the instrument time response and the paths length;
- Gas analyzer(s) manufacturer and model;
- Gas analyzer settings:Flow rate and intake tube length and inner diameter (for closed path gas analyzers only);Displacement of the reference anemometer in a Cartesian north/east/vertical system;If applicable, the instrument time response and path lengths;If applicable, the relevant extinction coefficients (for Krypton and Lyman-α hygrometers)

## Raw file columns

- Name of the variable;
- The instrument that measured the variable;
- For gas concentrations, the type of measurement (molar density, mole fraction or mixing ratio);
- Physical units of the variable, as stored in the raw file;
- If applicable, linear conversion information:Type of conversion (Gain/Offset);Units of the variable as stored in the raw file;Gain/Offset;Physical units of the variable, as expected after the linear conversion;
- Nominal time-lag for the variable, based either on the displacement of the instrument from the reference anemometer (open path analyzers), or on the intake tube properties and flow rate (closed path analyzers).
- Minimum and maximum plausible time lags, for automatic time lag determination by means of circular correlation.
