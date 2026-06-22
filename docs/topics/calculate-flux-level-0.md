---
title: "Calculating Fluxes Level 0 (uncorrected fluxes)"
source_url: "https://www.licor.com/support/EddyPro/topics/calculate-flux-level-0.html"
---
# Calculating turbulent fluxes level 0 (uncorrected fluxes)

Level 0 fluxes are uncorrected. They are computed according to the following equations:

## Ambient sensible heat flux, uncorrected (H, W m-2)

6‑51
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation984.svg)

## CO2 flux, uncorrected (F0,co2, μmol m-2 s-1)

If CO2 is measured as molar density with an open path analyzer:

6‑52
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation985.svg)

If CO2 is measured as molar density with a closed path analyzer:

6‑53
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation986.svg)

If CO2 is measured as mixing ratio:

6‑54
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation987.svg)

If CO2 is measured as mole fraction:

6‑55
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation988.svg)

## H2O flux, uncorrected (F0,co2, mmol m-2 s-1)

If H2O is measured as molar density with an open path analyzer:

6‑56
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation989.svg)

If H2O is measured as molar density with a closed path analyzer:

6‑57
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation990.svg)

If H2O is measured as mixing ratio:

6‑58
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation991.svg)

If H2O is measured as mole fraction:

6‑59
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation992.svg)

## CH4 flux, uncorrected: (F0,ch4, μmol m-2 s-1)

If CH4 is measured as molar density with an open path analyzer:

6‑60
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation993.svg)

If CH4 is measured as molar density with a closed path analyzer:

6‑61
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation994.svg)

If CH4 is measured as mixing ratio:

6‑62
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation995.svg)

If CH4 is measured as mole fraction:

6‑63
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation996.svg)

## Latent heat flux, uncorrected (LE0, W m-2)

6‑64
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation997.svg)

## Evapotranspiration flux, uncorrected: (E0, kg m-2 s-1)

6‑65
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation998.svg)

## Momentum flux, uncorrected: (T0, kg m-1 s-2)

Calculated after [van Dijk et al. (2004)](references.md#vanDijk), eq. 2.85

6‑66
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation999.svg)

## Friction velocity (u*, ms-1)

Calculated according to its definition as:

6‑67
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1000.svg)

## Potential temperature (Tp, K)

Calculated according to:

6‑68
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1001.svg)

where P0,a*=10*5 Pa, and is the reference pressure.

## Monin-Obukhov length (L, m)

Calculated according to its definition as:

6‑69
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1002.svg)

where κ = ~0.41, and is the von Kármán constant; g = ~9.81 m s-1, and is the gravity.

## Monin-Obukhov stability parameter (ζ, non-dimensional)

ζ is calculated as:

6‑70
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1003.svg)

where hm is the measurement height above the ground, as measured in the center of the anemometer measurement volume, and d is the [displacement height](displacement-height.md).

## Dynamic temperature (T*, K)

Calculated according to its definition (e.g., [Foken and Wichura, 1996](references.md#Foken)):

6‑71
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1004.svg)
