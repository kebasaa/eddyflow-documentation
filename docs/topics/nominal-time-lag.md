---
title: "Nominal Time Lag"
source_url: "https://www.licor.com/support/EddyPro/topics/nominal-time-lag.html"
---
# Nominal, minimal, and maximum Time Lag

The name ** time lag ** refers to the delay with which the gas analyzer measures ambient quantities (concentrations, temperatures, pressures, etc.), with respect to the anemometer, taken as a reference. The anemometer provides measurements of an air parcel virtually instantaneously. The gas analyzer provides readings for the same parcel with a delay that can be due to: 1) the physical distance from the anemometer; 2) the need to take the air sample to the measuring cell through an intake tube (closed path analyzers).

The nominal time lag is the *expected* value of the delay time, which primarily depends on the distance between the measuring volumes and, for closed-path systems, the sampling line geometry and the flow rate. However, due to changing wind directions and possible instabilities of the flow rates, the actual time lag can deviate from the nominal one. In addition, transit time of water vapor along the intake tube of a closed path system can vary substantially with relative humidity, due to absorption/desorption processes at the tube walls.

For these reasons, a range of plausible time lags can be specified by providing its minimum and maximum values. Within this lag window EddyFlow attempts to determine the actual time lag for each averaging period, by means of the [covariance maximization procedure](time-lag-detect-correct.md).

If not set explicitly, ** or if any of the time lag values are zero **, EddyFlow will set nominal, minimum, and maximum time lag values according to meta-information available. However, if the user-provided or calculated time lags are very close to zero, EddyFlow will use a safety margin of 0.3 to determine the minimum (τmin = τmin -0.3) and maximum (τmax = τmax +0.3) time lags. Specifically, for closed path systems a nominal time lag (*τ*nom) is set by calculating the nominal transit time of the airflow along the intake tube, based on tube volume and the flow rate:

5‑4
                                                            ![tnom=(tubelength*cross section)/flow rate](https://www.licor.com/support/GeneratedImages/Equations/Equation902.svg)

5‑5
                                                            ![tmin=tnom-2](https://www.licor.com/support/GeneratedImages/Equations/Equation903.svg)

5‑6
                                                            ![tmax=tnom+2*tnom](https://www.licor.com/support/GeneratedImages/Equations/Equation904.svg)

The range is set asymmetrically because it is more likely that the time lag will increase (due, for example, to lower flow rates caused by clogged filters), rather than decrease. The constant 2 in the last equation is replaced by 10 for water vapor, as the time lag of water vapor is observed to exhibit a strong dependence on relative humidity (e.g., [Ibrom et al., 2007b](references.md#Ibrom2))

For open path systems, by contrast, the nominal time lag is set to zero as the most likely value in sites that lack a prevailing wind direction. Minimum and maximum values are calculated based on the separation between the gas analyzer and the anemometer and a 0.5 m/s average wind speed:

5‑7
                                                            ![tnom=0](https://www.licor.com/support/GeneratedImages/Equations/Equation905.svg)

5‑8
                                                            ![tmin=-sensor separation/0.5](https://www.licor.com/support/GeneratedImages/Equations/Equation906.svg)

5‑9
                                                            ![tmax=sensor separation/0.5](https://www.licor.com/support/GeneratedImages/Equations/Equation907.svg)
