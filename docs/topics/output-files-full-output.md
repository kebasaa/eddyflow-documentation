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

### Conditional eddy covariance partitioning

- When [Conditional Eddy Covariance](conditional-eddy-covariance.md#top) is activated, the full output includes evapotranspiration partitioned into transpiration and evaporation and net carbon dioxide flux partitioned into photosynthetic uptake and ecosystem respiration.

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
| corr_iter_dev | % | Convergence of the iterative correction: the change in the corrected flux between the last two passes, for the gas that changed most in the averaging period. Written only when **Iterate the correction** (`corr_iter_meth`) is on. See [Spectral corrections](spectral-corrections.md#top). |
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
| gas_detlim | covariance units | Flux detection limit of the gas, after Wienhold et al. (1994): the noise floor of the covariance of the gas with *w*, read from the cross-covariance function away from its peak. Written when the detection limit is calculated (`detlim_meth`). Stays in covariance units and is not converted to a flux. See [Flux detection limit](flux-detection-limit.md#top). |
| sonic_temperature | K | Mean temperature of ambient air as measured by the anemometer |
| air_temperature | K | Mean temperature of ambient air, either calculated from high frequency air temperature readings, or estimated from sonic temperature |
| air_pressure | Pa | Mean pressure of ambient air, either calculated from high frequency air pressure readings, or estimated based on site altitude (barometric pressure) |
| air_density | kg m-3 | Density of ambient air |
| air_heat_capactiy | J K-1 kg-1 | Specific heat at constant pressure of ambient air |
| air_molar_volume | m3 mol-1 | Molar volume of ambient air |
| ET | mm hour-1 | Evapotranspiration flux |
| P_cec | µmol m-2 s-1 | CEC photosynthetic carbon dioxide flux. Negative values indicate ecosystem carbon dioxide uptake. Available when Conditional Eddy Covariance is activated. |
| Reco_cec | µmol m-2 s-1 | CEC ecosystem respiration. Positive values indicate carbon dioxide release to the atmosphere. Available when Conditional Eddy Covariance is activated. |
| Tr_cec | mmol m-2 s-1 | CEC transpiration. Positive values indicate an upward water vapor flux. Available when Conditional Eddy Covariance is activated. |
| E_cec | mmol m-2 s-1 | CEC evaporation. Positive values indicate an upward water vapor flux. Available when Conditional Eddy Covariance is activated. |
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
| T* | K | Scaling temperature (T* = −H/(ρ·cp·u*), negative for upward heat flux) |
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

The **Output format** option allows you to decide to **Output only available results** or **Use standard output format**.

The first option, **Output only available results** instructs EddyFlow to reduce the file only to results that are actually available. One advantage of this option is that it results in smaller files that are easier to read in a spreadsheet. Files do not contain columns filled with error codes for the variables that are not available.

The second option, **Use standard output format** instructs EddyFlow to create a file in a predefined standardized output format that includes columns from all possible results. One advantage of this option is that the file format does not vary in time, making it easier to import into post-processing analysis tools.

### Build continuous dataset

Select this option to instruct EddyFlow to create a continuous dataset. For periods that have no results available (gaps), the software will introduce dummy records of "error codes" in such a way that the results files will contain a continuous time line. This is convenient since data gaps need to be recognized (especially when time series are plotted) and addressed (e.g., by means of a gap-filling procedure). However, the procedure requires a non-negligible amount of time – especially for long datasets—so it is provided as an option. The definition of the time line is based on the time stamp of the first raw file and on the selected flux averaging period.

## Columns and files added or changed in recent versions

This section lists what is new or different in the output, by label. Methods are described on the linked pages.

### Full output file

- **`corr_iter_dev`** (%, group *iterative_correction*): convergence of the iterative correction, worst gas of the period. Present only when `corr_iter_meth` is on; the column is absent otherwise, not filled with the error code.
- **`<gas>_detlim`** (covariance units), in the *gas_densities_concentrations_and_timelags* group after `<gas>_def_timelag`: flux detection limit of the gas (Wienhold et al., 1994). Not scaled to a flux. See [Flux detection limit](flux-detection-limit.md#top).
- **`T*`**: when the fluxes are written by `eddyflow_fcc` (any run whose spectral correction is handed to it), `T*` was the negative of the correct value in earlier versions (for example +0.0966893 where −0.0966890 is correct). Only this column and `TSTAR` in the FLUXNET file were affected, each by exactly its sign. No flux, correction or quality flag changed. Files written by `eddyflow_rp` alone were always correct.

### FLUXNET output file

- **`SPEC_CORR_LI7700_A_<GAS>`, `SPEC_CORR_LI7700_B_<GAS>`, `SPEC_CORR_LI7700_C_<GAS>`** (for example `SPEC_CORR_LI7700_A_CO2`): the LI-7700 multipliers A, B and C of each gas, three columns per gas. They replace the three fixed columns `SPEC_CORR_LI7700_A`, `SPEC_CORR_LI7700_B` and `SPEC_CORR_LI7700_C`. A gas not measured by an LI-7700 holds the missing-value token. The multipliers are now applied to the methane flux (see [Calculating multipliers for spectroscopic corrections (LI-7700)](calculate-li-7700-multipliers.md#how-the-multipliers-enter-the-methane-flux)).
- **Number of columns.** The three fixed multiplier columns became three per configured gas, so the row is wider by 3 × (number of gases) − 3 columns, and the engine's internal count of leading fields in the row rose from 278 to 287. A script that reads the file **by column position** must be updated; reading by column name is unaffected.
- **`<gas>_DETLIM`** (covariance units): detection limit, one column per configured gas, written when the detection limit is calculated (`detlim_meth`).
- **`TSTAR`**: same sign correction as `T*` above.
- **`U_KID`, `V_KID`, `W_KID`, `T_SONIC_KID`, `<GAS>_KID`**: always written, whether or not `test_rf` is on. The values changed: KID is now computed on the flat-line-corrected difference series, so values differ from earlier versions wherever a sensor flat-lined or digitised its output (see [Kurtosis index of differences (KID)](despiking-raw-statistical-screening.md#kurtosis-index-of-differences-kid)).
- **`<var>_AL1`, `<var>_DDI`, `<var>_HF5`, `<var>_HF10`, `<var>_HD5`, `<var>_HD10`, `<var>_DIP`, `<var>_CCF`**: extra raw-signal diagnostics, each a family with one column for `U`, `V`, `W`, `T_SONIC` and each gas (for example `U_AL1`, `T_SONIC_DIP`, `CO2_CCF`). Written only when **Extra raw-signal diagnostics (RFlux)** (`test_rf`) is on, at the very end of the row after the biomet columns. See [Statistical tests](statistical-tests.md#top).

### Other files

- **`<project id>_flux_despiking<timestamp>.csv`**: written when **Post-flux despiking (STL)** (`test_pfd`) is on, with the columns `TIMESTAMP`, `NEE`, `NEE_SPIKE`, `NEE_CLEANED`, `H`, `H_SPIKE`, `H_CLEANED`, `LE`, `LE_SPIKE`, `LE_CLEANED`. See [Statistical tests](statistical-tests.md#top).
- The processing log summary column `S4_instrument_filled` is now named `S4_borrowed`.
- The spectral assessment file marks a gas that has more than one acquisition rate with a `rates=` token; see [Spectral corrections](spectral-corrections.md#top).

### What changed in the numbers

| Change | What you see |
| --- | --- |
| LI-7700 multipliers B and C applied | LI-7700 methane flux larger in magnitude (10.6% on the LI-COR test archives) |
| Burba heating applied per gas | with `bu_corr=1` and several open-path analyzers, the methane flux no longer includes the LI-7500's heating |
| T* sign in `eddyflow_fcc` | `T*` and `TSTAR` flip sign; nothing else |
| KID on the flat-line-corrected series | `*_KID` values change where flat-lining occurred |
| Atm biomet pressure constant | biomet channel in `Atm` 3.3% higher (now correct) |
