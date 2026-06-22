---
title: "Calculating Fluxes Level 1, 2, and 3 (corrected fluxes)"
source_url: "https://www.licor.com/support/EddyPro/topics/calculate-flux-level-123.html"
---
# Calculating corrected fluxes

Calculating corrected fluxes in EddyFlow involves the application of the following corrections:

## Humidity correction of sonic temperature

Correction of air temperature estimated via sonic temperature for the effects of humidity. This includes mean temperature values as well as any covariance (and related fluxes) that include sonic temperature.

This correction was firstl described in [Schotanus et al. (1983)](references.md#Schot) and is applied in EddyFlow according to the revision described in [van Dijk et al. (2004, eq. 3.53)](references.md#vanDijk).

6‑88 ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1028.svg)

6‑89
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1029.svg)

where α=0.51, Q is specific humidity and covariance (w'Q') ̅ (m s-1) is calculated from evapotranspiration flux (E, kg m-2 s-1):

6‑90
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1030.svg)

## Correction of gas fluxes for air density fluctuation effects (WPL terms)

This "correction" was first described in Webb et al. (1980) for open-path analyzers and was revised by Ibrom et al. (2007) for closed-path analyzers. The way the correction is applied and the order with respect to other corrections depend on the analyzer type, the nature of the gas concentration measurements and the available raw data. EddyFlow automatically selects the optimal calculation path based on available data and metadata. The way the correction is applied is described in [Compensation for density fluctuations (WPL terms)](raw-processing-options.md#Compensa), while the way it is interwoven with other corrections is detailed in [Calculating turbulent fluxes for a system composed of an LI-7500A/RS/DS and LI-7700](calculate-flux-open-path-analyzers.md#top) for open-path setups and [Calculating turbulent fluxes for a system composed of an LI-7200/RS and LI-7700](calculate-flux-7200-and-7700.md#top) for closed-path setups.

In general terms:

- For closed-path systems, air density fluctuations are accounted for by converting raw concentration data into mixing ratios whenever possible. If that's not possible, the formulation of [Ibrom et al. (2007)](references.md#Ibrom) is used to account for all WPL terms, for which the necessary data is available. For closed-path systems, WPL terms are accounted for before applying the correction for spectral attenuations (see later).
- For open-path systems, air density fluctuations are accounted for by using the formulation of [Webb et al. (1980)](references.md#Webb). Where necessary, additional WPL terms are included, e.g. to account for the instrument-induced extra sensible heat flux ("off-season uptake correction") for LI-7500(A) or to account for spectroscopic effects for the LI-7700 methane analyzer.

## Correction for high-frequency and low-frequency spectral attenuations

Calculation of correction factors is described in detail in [Calculating Spectral correction factors](calculate-spectral-correction-factors.md#top).

## Off-season uptake correction (LI-7500 only)

Calculation of corrected sensible heat flux is described in detail in [Calculating the off-season uptake correction (LI-7500 only)](calculate-offseason-uptake-correction.md#top).

## Spectroscopic correction (LI-7700 only)

Calculation of spectroscopic multipliers is described in detail in [Calculating multipliers for spectroscopic corrections (LI-7700)](calculate-li-7700-multipliers.md#top).
