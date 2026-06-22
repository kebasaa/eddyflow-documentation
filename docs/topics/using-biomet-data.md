# Using biomet data

EddyFlow Software allows you to import and use biomet measurements for improved flux computation and other purposes. Biomet measurements include meteorological as well as ecological (e.g., soil and vegetation) measurements. These data are typically sampled at lower rates than the eddy covariance data (e.g., once per second) and averaged over longer time periods (e.g., 1 to 30 minutes). Traditionally, biomet data—collected by means of a datalogger—are stored in one or more files, distinct from high-speed eddy data. However, the original publisher eddy covariance systems allow you to collect .ghg files, a raw file format that bundles eddy covariance data (and the corresponding metadata) together with biomet data (and, again, the corresponding metadata). The advantages are evident:

- Eddy covariance and biomet data (high-speed and low-speed data) corresponding to the same time span are stored together;
- Both eddy covariance and biomet data are documented in the paired metadata files, so the whole file archive is a self-descriptive file that can be interpreted and processed by someone who did not collect those data and does not have any information regarding the site where they were collected and the instruments deployed;
- Biomet data are automatically extracted, interpreted, filtered and used by EddyFlow, along with the paired eddy data.

While processing eddy covariance data for each given time period (for example from 8:00 to 8:45, no matter the flux averaging interval), EddyFlow retrieves all biomet data available, whose time stamp falls in that time slot. Biomet data are then used for two main purposes:

- Improve flux computation by using slow, accurate measurements of absolute meteorological quantities such as air temperature, pressure, relative humidity, etc.;
- Screen values and calculate averages of all available biomet measurements, on the same time scale as the flux averaging interval.

## Use of biomet data for improved flux computation and correction

EddyFlow uses biomet data for the following purposes:

- Ambient temperature, pressure and relative humidity, if available, are used to replace the mean values of the same quantities as estimated from eddy covariance data or from site characteristics. For example, in the absence of a reliable ambient temperature reading in the eddy covariance data (as that provided, for example, by the LI-7700), mean ambient temperature is estimated using sonic temperature, corrected for crosswind and humidity effects. However, absolute sonic temperature may be inaccurate (while its fluctuations, used for calculating sensible heat fluxes, are typically accurately captured), thereby biasing all results that make use of mean ambient temperature (e.g., the WPL correction). If ambient temperature is available in the biomet data file, this can be averaged over the selected flux averaging interval and used directly for improved flux computations/corrections. Similar considerations can be done for the absolute water content of ambient air as derived from eddy covariance data, or for ambient pressure as assumed from site altitude;
- Data of global radiation and long-wave incoming radiation can be used in the "multiple regression" version of the off-season uptake correction (Burba et al., 2008);
- Data of photosynthetically active radiation (PAR, also called PPFD, photosynthetic photon flux density) can be used to assess day and night-time radiation loading on the surface of the instrument, to apply the appropriate coefficients and modeling of the instrument surface temperature in the off-season uptake correction.

** Note:** Before using biomet data, EddyFlow screens them for quality (checks that values are within physically plausible ranges) and calculates averages over the appropriate time scale. If the resulting average values are physically implausible, EddyFlow automatically switches to classic eddy covariance data-based calculations.

## Averaging biomet data for further analysis

Besides using some biomet variables for flux computation and refinement, EddyFlow processes all available biomet measurements by doing the following:

- Screening individual measurements and excluding outlying values;
- Automatically converting units to conform with EddyFlow standard units;
- Averaging all good measurements over the time range defined by the current time averaging period;
- Outputting average biomet values in a separate file, using the same conventions and formats as all other EddyFlow output files, so as to be readily processed and merged, for example, with the "full output" file for further analysis.
