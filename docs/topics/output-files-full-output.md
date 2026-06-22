---
title: "The Full Output File"
source_url: "https://www.licor.com/support/EddyPro/topics/output-files-full-output.html"
---
# The full output file

This is the most comprehensive output file produced by EddyFlow. It contains many of the intermediate and final variables calculated during data processing. Results values are grouped by the first line of the header to facilitate interpretation. Here we provide an overview of available outputs. For more specific descriptions of each variable refer to the [Variables Table](#Variable).

## Headings

The first row in the file (when opened in a spreadsheet) gives the top-level headings below. The second row includes subheadings for variables and values included in the results.

### File info

- Raw file name
- Date and time of the end of the averaging period
- Number of valid records found in the raw file
- Number of valid records used for the current averaging period

### Corrected fluxes

- Net vertical turbulent fluxes of momentum, sensible heat, latent heat and all available gases, calculated from uncorrected fluxes, by correcting for spectral attenuations, air density fluctuations and instrument-specific effects, as applicable. Quality flags and random uncertainty estimates are provided for all fluxes.

### Storage fluxes

- Storage fluxes of sensible and latent heat and for all available gases, estimated from concentrations and based on a 1-point profile.

### Vertical advection fluxes

- Vertical advection gas fluxes obtained by multiplication of the mean vertical wind speed and mean gas concentration. These are zero if the mean vertical velocity is forced to zero, as is the case with the double rotations schemes for tilt correction.

### Gas densities, concentrations, and time lags

- Average molar density, mole fraction (moles of gas per mole of wet air) and mixing ratio (moles of gas per mole of dry air) for available gases. Quantities are either calculated or estimated from raw data, depending on the available measurements. In particular, calculation of densities to concentrations (and vice-versa) requires measured temperatures and pressures, while estimation is done using barometric pressure and/or corrected sonic temperature, if measured values are not available. Toggling between mole fractions and mixing ratios requires fast measurements of water vapor.
- Time lags used for flux calculation and a flag indicating whether the time lag used was calculated with the covariance maximization procedure (value "F") or was the nominal one ("T").

### Air properties

- Evapotranspiration flux, expressed as millimeters of water per hour
- Mean ambient pressure and temperature, either calculated or estimated, depending on the content of raw files
- Mean ambient air density and molar volume and heat capacity, calculated
- Mean ambient water vapor density, partial pressure, partial pressure at saturation
- Mean ambient specific and relative humidity, water vapor pressure deficit and dew point temperature

### Unrotated and rotated wind

- Mean wind components in the anemometer coordinate framework
- Wind components after rotations for tilt correction
- Mean wind speed, instantaneous maximum wind speed and mean wind direction

### Rotation angles

- Yaw, pitch, and roll angles used to correct anemometer tilting, according to the selected method.

### Turbulence

- Turbulence parameters: friction velocity, Monin-Obukhov length, stability parameter, turbulent kinetic energy, Bowen ratio, and scaling temperature.

### Footprint

- Estimation of crosswind integrated footprints: model used, along wind distances providing peak, 10%, 30%, 50%, 70%, and 90% contributions to total fluxes. Footprint offset is the distance from the tower providing less than 1% contribution to total fluxes. See [Estimating the flux footprint](estimating-flux-footprint.md#Footprin).

### Uncorrected fluxes

- Net vertical turbulent fluxes of momentum, sensible heat, latent heat and all available gases, calculated from corresponding covariances by conversion of physical units, prior to application of corrections.
- Spectral correction factors calculated according to the selected method.

### Statistical flags

- Results of selected statistical tests, applied to all time series.

### Diagnostics

- Number of spikes detected for each sensitive variable used for flux computation.
- Detailed summary of diagnostics for LI-7500A/RS, LI-7200/RS, and LI-7700. The values here are the sum of records in each flux averaging interval, for which flags are set to "on" (bad data). Thus values here go from zero (best case) to the number of available records (worst case).
- Average AGC or Signal Strength (LI-7500A/RS or LI-7200/RS) and RSSI (LI-7700).

### Variances

- Variances of all sensitive variables, calculated at the end of the whole raw data processing, including despiking, corrections, rotations and detrending.

### Covariances

- Covariances between *w* (vertical wind component) and all non-anemometric sensitive variables calculated at the end of the whole raw data processing, including despiking, corrections, rotations, detrending, and time lag compensation.

### Custom variables

- Mean values for all non-sensitive variables are reported at the end of the output record.

### Variables table

The following table summarizes all output results available in the rich output file. In the table, *var* stands for any available sensitive variable, *gas* stands for any available sensitive gas measurement and *extravar* stands for any non-sensitive variable.

| Label | Units, Format, or Range | Description |
| --- | --- | --- |
| filename | - | Name of the raw file (or the first of a set) from which the dataset for the current averaging interval was extracted |
| date | yyyy-mm-dd | Date of the end of the averaging period |
| time | HH:MM | Time of the end of the averaging period |
| file_records | # | Number of valid records found in the raw file (or set of raw files) |
| used_records | # | Number of valid records used for current the averaging period |
| Tau | kg m-1 s-2 | Corrected momentum flux |
| qc_Tau | # | Quality flag for momentum flux |
| rand_err_Tau | kg m-1 s-2 | Random error for momentum flux, if selected |
| H | W m-2 | Corrected sensible heat flux |
| qc_H | # | Quality flag for sensible heat flux |
| rand_err_H | W m-2 | Random error for momentum flux, if selected |
| LE | W m-2 | Corrected latent heat flux |
| qc_LE | # | Quality flag latent heat flux |
| rand_err_LE | W m-2 | Random error for latent heat flux, if selected |
| gas_flux | µmol m-2 s-1(†) | Corrected gas flux |
| qc_gas_flux | # | Quality flag for gas flux |
| rand_err_gas_flux | µmol s-1 m-2(†) | Random error for gas flux, if selected |
| H_strg | W m-2 | Estimate of storage sensible heat flux |
| LE_strg | W m-2 | Estimate of storage latent heat flux |
| gas_strg | µmol s-1 m-2(†) | Estimate of storage gas flux |
| gas_v-adv | µmol s-1 m-2(†) | Estimate of vertical advection flux |
| gas_molar_density | mmol m-3 | Measured or estimated molar density of gas |
| gas_mole_fraction | µmol mol-1(†) | Measured or estimated mole fraction of gas |
| gas_mixing_ratio | µmol mol-1(†) | Measured or estimated mixing ratio of gas |
| gas_time_lag | s | Time lag used to synchronize gas time series |
| gas_def_timelag | T/F | Flag: whether the reported time lag is the default (T) or calculated (F) |
| sonic_temperature | K | Mean temperature of ambient air as measured by the anemometer |
| air_temperature | K | Mean temperature of ambient air, either calculated from high frequency air temperature readings, or estimated from sonic temperature |
| air_pressure | Pa | Mean pressure of ambient air, either calculated from high frequency air pressure readings, or estimated based on site altitude (barometric pressure) |
| air_density | kg m-3 | Density of ambient air |
| air_heat_capactiy | J K-1 kg-1 | Specific heat at constant pressure of ambient air |
| air_molar_volume | m3 mol-1 | Molar volume of ambient air |
| ET | mm hour-1 | Evapotranspiration flux |
| water_vapor_density | kg m-3 | Ambient mass density of water vapor |
| e | Pa | Ambient water vapor partial pressure |
| es | Pa | Ambient water vapor partial pressure at saturation |
| specific_humidity | kg kg-1 | Ambient specific humidity on a mass basis |
| RH | % | Ambient relative humidity |
| VPD | Pa | Ambient water vapor pressure deficit |
| Tdew | K | Ambient dew point temperature |
| u_unrot | m s-1 | Wind component along the u anemometer axis |
| v_unrot | m s-1 | Wind component along the v anemometer axis |
| w_unrot | m s-1 | Wind component along the w anemometer axis |
| u_rot | m s-1 | Rotated u wind component (mean wind speed) |
| v_rot | m s-1 | Rotated v wind component (should be zero) |
| w_rot | m s-1 | Rotated w wind component (should be zero) |
| wind_speed | m s-1 | Mean wind speed |
| max_wind_speed | m s-1 | Maximum instantaneous wind speed |
| wind_dir | ° (degrees) | Direction from which the wind blows, with respect to Geographic or Magnetic north |
| yaw | ° (degrees) | First rotation angle |
| pitch | ° (degrees) | Second rotation angle |
| u* | m s-1 | Friction velocity |
| TKE | m2 s-2 | Turbulent kinetic energy |
| L | M | Monin-Obukhov length |
| (z-d)/L | # | Monin-Obukhov stability parameter |
| bowen_ratio | # | Sensible heat flux to latent heat flux ratio |
| T* | K | Scaling temperature |
| (footprint) model | - | Model for footprint estimation |
| x_offset | m | Along-wind distance providing <1% contribution to turbulent fluxes |
| x_peak | m | Along-wind distance providing the highest (peak) contribution to turbulent fluxes |
| x_10% | m | Along-wind distance providing 10% (cumulative) contribution to turbulent fluxes |
| x_30% | m | Along-wind distance providing 30% (cumulative) contribution to turbulent fluxes |
| x_50% | m | Along-wind distance providing 50% (cumulative) contribution to turbulent fluxes |
| x_70% | m | Along-wind distance providing 70% (cumulative) contribution to turbulent fluxes |
| x_90% | m | Along-wind distance providing 90% (cumulative) contribution to turbulent fluxes |
| un_Tau | kg m-1 s-2 | Uncorrected momentum flux |
| Tau_scf | # | Spectral correction factor for momentum flux |
| un_H | W m-2 | Uncorrected sensible heat flux |
| H_scf | # | Spectral correction factor for sensible heat flux |
| un_LE | W m-2 | Uncorrected latent heat flux |
| LE_scf | # | Spectral correction factor for latent heat flux |
| un_gas_flux | µmol s-1 m-2(†) | Uncorrected gas flux |
| gas_scf | # | Spectral correction factor for gas flux |
| spikes | 8u/v/w/ts/co2 /h2o/ch4/none | Hard flags for individual variables for spike test |
| amp_res | 8u/v/w/ts/co2 /h2o/ch4/none | Hard flags for individual variables for amplitude resolution |
| drop_out | 8u/v/w/ts/co2 /h2o/ch4/none | Hard flags for individual variables for drop-out test |
| abs_lim | 8u/v/w/ts/co2 /h2o/ch4/none | Hard flags for individual variables for absolute limits |
| skw_kur | 8u/v/w/ts/co2 /h2o/ch4/none | Hard flags for individual variables for skewness and kurtosis |
| skw_kur | 8u/v/w/ts/co2 /h2o/ch4/none | Soft flags for individual variables for skewness and kurtosis test |
| discontinuities | 8u/v/w/ts/co2 /h2o/ch4/none | Hard flags for individual variables for discontinuities test |
| discontinuities | 8u/v/w/ts/co2 /h2o/ch4/none | Soft flags for individual variables for discontinuities test |
| time_lag | 8u/v/w/ts/co2 /h2o/ch4/none | Hard flags for gas concentration for time lag test |
| time_lag | 8u/v/w/ts/co2 /h2o/ch4/none | Soft flags for gas concentration for time lag test |
| attack_angle | 0, 1, 9 | Hard flag for attack angle test |
| non_steady_wind | 0, 1, 9 | Hard flag for non-steady horizontal test |
| var_spikes | # | Number of spikes detected and eliminated for variable var |
| AGC | # | Mean value of AGC for LI-7500RS or LI-7200RS |
| RSSI | # | Mean value of RSSI for LI-7700, if present |
| var_var | -(‡) | Variance of variable var |
| w/var_cov | -(‡) | Covariance between w and variable var |
| extravar_mean | (‡) | Mean value of extravar |

† Concentrations and fluxes for water vapor are provided as [mmol mol-1] and [mmol m-2 s-1] respectively.

‡ Units depend on the nature of the variable.

### Output format

The ** Output format ** option allows you to decide to ** Output only available results ** or ** Use standard output format **.

The first option, ** Output only available results ** instructs EddyFlow to reduce the file only to results that are actually available. One advantage of this option is that it results in smaller files that are easier to read in a spreadsheet. Files do not contain columns filled with error codes for the variables that are not available.

The second option, ** Use standard output format ** instructs EddyFlow to create a file in a predefined standardized output format that includes columns from all possible results. One advantage of this option is that the file format does not vary in time, making it easier to import into post-processing analysis tools.

### Build continuous dataset

Select this option to instruct EddyFlow to create a continuous dataset. For periods that have no results available (gaps), the software will introduce dummy records of "error codes" in such a way that the results files will contain a continuous time line. This is convenient since data gaps need to be recognized (especially when time series are plotted) and addressed (e.g., by means of a gap-filling procedure). However, the procedure requires a non-negligible amount of time – especially for long datasets—so it is provided as an option. The definition of the time line is based on the time stamp of the first raw file and on the selected flux averaging period.
