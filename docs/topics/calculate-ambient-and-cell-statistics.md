---
title: "Calculating Ambient and Cell Statistics"
source_url: "https://www.licor.com/support/EddyPro/topics/calculate-ambient-and-cell-statistics.html"
---
# Calculating ambient and cell statistics

At each relevant step of the raw data processing, statistics are calculated for all available variables, either sensitive or non-sensitive. Single-variable statistics include average, standard deviation, skewness, and kurtosis. Relevant covariances are also calculated, notably covariances among vertical wind component w and all other variables. In particular, covariances between w and ambient scalars such as gas concentrations or temperatures, used for flux estimates, are calculated after compensation of scalars time lags.

However, when a closed path instrument is used, other covariances might also be needed for correcting fluxes for the effect of air density fluctuations ([Webb et al., 1980](references.md#Webb)). Namely, for each given gas, the covariances ![w'c'h2o](https://www.licor.com/support/GeneratedImages/Equations/Equation961.svg) and ![w't'cell](https://www.licor.com/support/GeneratedImages/Equations/Equation962.svg) (where ch2o is water vapor concentration expressed in any suitable units) are needed, calculated after compensating ch2o and Tcell*using the time lag of the gas under consideration*. Here, of course EddyFlow® Software checks that water vapor is measured by the same instrument that measures the concentration of the gas considered. Otherwise, the covariance ![w'c'h2o](https://www.licor.com/support/GeneratedImages/Equations/Equation963.svg) is not calculated.

If you wish to learn more about accounting for air density fluctuations in closed path systems, refer to [Ibrom et al. (2007b)](references.md#Ibrom), for example.
