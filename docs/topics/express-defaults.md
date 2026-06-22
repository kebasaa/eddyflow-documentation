# Express default settings

The default settings in the ** Advanced Settings ** page correspond with the settings applied in Express Mode. These settings are given in the table below. In Express Mode, EddyFlow ignores any altered settings in the ** Advanced Settings ** page and it generates a predefined set of output files. Express Mode will not alter any user-specified settings in the ** Advanced Settings ** page.

| Option | Settings |
| --- | --- |
| Crosswind correction: | Not applied in EddyFlow; assuming the correction was applied by the sonic anemometer. |
| Processing Options |  |
| Axis rotation for tilt correction: | Double rotation |
| Turbulent fluctuations: | Block averaging |
| Time lag compensation: | Covariance maximization |
| Statistical Tests |  |
| Spike count/removal: | Maximum number of consecutive outliers: 3Accepted spikes: 1.0%Replace spikes with linear interpolation: YesPlausibility ranges:• W: 5.0 [σ]• CO2: 3.5 [σ]• H2O: 3.5 [σ]• CH4: 8.0 [σ]• 4th Gas: 8.0 [σ]• All other variables: 3.5 [σ] |
| Amplitude resolution: | Range of variation: 7.0 [σ] Number of bins: 100 Accepted empty bins: 70% |
| Drop-outs: | Percentile defining extreme bins: 10 Accepted central drop-outs: 10.0 [σ] Accepted extreme drop-outs: 6.0% |
| Absolute limits: | Minimum • U: -30.0 [m/s] • W: -5.0 [m/s] • Ts: -20.0 [°C] • CO2: 200 [µmol/mol] • H2O: 0.0 [mmol/mol] • CH4: 0.170 [µmol/mol] • 4th Gas: 0.03 [µmol/mol] Maximum • U: 30.0 [m/s] • W: 5.0 [m/s] • Ts: 50.0 [°C] • CO2: 600 [µmol/mol] • H2O: 40.0 [mmol/mol] • CH4: 1000 [µmol/mol] • 4th Gas: 1000 [µmol/mol] |
| Minimum • U: -30.0 [m/s] • W: -5.0 [m/s] • Ts: -20.0 [°C] • CO2: 200 [µmol/mol] • H2O: 0.0 [mmol/mol] • CH4: 0.170 [µmol/mol] • 4th Gas: 0.03 [µmol/mol] | Maximum • U: 30.0 [m/s] • W: 5.0 [m/s] • Ts: 50.0 [°C] • CO2: 600 [µmol/mol] • H2O: 40.0 [mmol/mol] • CH4: 1000 [µmol/mol] • 4th Gas: 1000 [µmol/mol] |
| Skewness and kurtosis: | Hard-flag threshold • Skewness lower limit: -2.0 • Skewness upper limit: 2.0 • Kurtosis lower limit: 1.0 • Kurtosis upper limit: 8.0 Soft-flag threshold • Skewness lower limit: -1.0 • Skewness upper limit: 1.0 • Kurtosis lower limit: 2.0 • Kurtosis upper limit: 5.0 |
| Hard-flag threshold • Skewness lower limit: -2.0 • Skewness upper limit: 2.0 • Kurtosis lower limit: 1.0 • Kurtosis upper limit: 8.0 | Soft-flag threshold • Skewness lower limit: -1.0 • Skewness upper limit: 1.0 • Kurtosis lower limit: 2.0 • Kurtosis upper limit: 5.0 |
| Discontinuities: | N/A |
| Time lags: | N/A |
| Angle of Attack: | • Nakai et al. (2006) for Gill R2 and Gill R3 anemometers• Nakai and Shimoyama (2012) for Gill WindMaster™ and Gill WindMaster™ Pro• Not applied for all other anemometer models |
| Steadiness of horizontal wind: | N/A |
| Spectral Corrections |  |
| Low frequency range: | Analytic correction of high-pass filtering effects (Moncrieff et al., 2004) |
| High frequency range: | Fully analytic method of Moncrieff et al. (1997) |

** Note:** Detrending in EddyFlow Express Mode is performed by a block-averaging procedure, which calculates fluctuations around the average variable value, estimated on the whole averaging period. This implies that statistics at levels 6 and 7 are identical. However, for consistency with EddyFlow Advanced and the original ECO2S, where detrending can be performed in other ways (such as linear detrending or running mean), the distinction is maintained. Similarly, the Angle of Attack correction may not be performed, depending on the processing choice and on the anemometer model. Accordingly, statistics at levels 2, 3 and 4 may or may not coincide.
