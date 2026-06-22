---
title: "Calculating Fluxes for the LI-7200 and LI-7700"
source_url: "https://www.licor.com/support/EddyPro/topics/calculate-flux-7200-and-7700.html"
---
# Calculating turbulent fluxes for a system composed of an LI-7200/RS and LI-7700

In this situation, corrected fluxes are calculated from uncorrected (fluxes as F0) with the following procedure:

## Level 1 fluxes: application of spectral corrections

As a first step, uncorrected methane fluxes from the LI-7700 are corrected for spectral attenuation, as explained in [Calculating Fluxes for Open Path Analyzers](calculate-flux-open-path-analyzers.md):

6‑106F1,ch4 = F0,ch4 · SCFw,ch4

Momentum flux and friction velocity are also spectrally corrected at Level 1, similarly:

6‑107T1 = T0 · SCFu,w

6‑108u*1 = u*0 · SCFu,w

Fluxes from the LI-7200 are not spectrally corrected at this stage, because the application of correction for air density fluctuation effects to concentrations calculated with closed path systems requires using uncorrected fluxes.

## Level 2 and 3 fluxes

Whenever possible, air density fluctuation effects in closed path systems are addressed by converting raw gas concentration measurements into mixing ratios (see [Converting to Mixing Ratios](converting-to-mixing-ratio.md)). However, when this is not possible due to unavailability of necessary raw information, the correction is implemented following the WPL approach, as refined by [Ibrom et al. (2007b)](references.md#Ibrom). As a first step, evapotranspiration flux is corrected for the WPL term using the formulation proposed in [Webb et al. (1980, eq. 42b)](references.md#Webb), properly modified to account for the fact that the relevant sensible heat flux is measured inside the cell of the LI-7200 (and not in ambient conditions):

6‑109
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1040.svg)

where ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1041.svg) and ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1042.svg) are covariances of w and cell temperature pressure respectively, evaluated after dislodging the cell temperature time series using the time lag of CO2. If covariance ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1043.svg) or ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1044.svg) are not available, they are assumed negligible and E1 is corrected only for the dilution term due to water vapor:

6‑110E2 = (1 + μσ)E1

Fully corrected (level 3) evapotranspiration flux can now be calculated from E2 by applying the proper spectral correction factor:

6‑111E3 = E2 · SCFw,h2o

Fully corrected latent heat and water vapor flux can now be calculated:

6‑112F3,h2o = E3 · 10-3·Mh2o

6‑113LE3 = λ · E3

Now, ambient sensible heat flux is corrected for humidity effects following [van Dijk et al. (2004)](references.md#vanDijk), revising [Schotanus et al. (1983)](references.md#Schot) as explained in [Calculating Fluxes Level 1 2 and 3](calculate-flux-level-123.md).

6‑114
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1045.svg)

Then it is spectrally corrected to get fully corrected sensible heat flux:

H3 = H2 · SCFw,Ts

Next, level 2 CO2 flux is calculated by applying the correction for air density fluctuations. EddyFlow uses a formulation similar to [Webb et al. (1980 eq. 24)](references.md#Webb), where, however, sensible heat flux and latent heat flux are evaluated in the cell and using the time lag of CO2:

6‑115
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1046.svg)

where Ecell and Hcell are calculated as:

6‑116
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1047.svg)

6‑117
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1048.svg)

and the subscript τ_co2 indicates that covariances are evaluated at time lags of CO2. The factor vc / va is needed to compute ambient quantities from cell quantities.

Methane fluxes are evaluated similarly to in a manner similar to [fluxes for the LI-7500 and LI-7700 analyzers](calculate-flux-open-path-analyzers.md):

6‑118
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1049.svg)

where now, the spectrally corrected, not-WPL-corrected evapotranspiration flux is calculated as:

6‑119
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1050.svg)

Finally, CO2 fluxes are corrected for spectral attenuations:

6‑120
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1051.svg)
