---
title: "Calculating Fluxes for the LI-7500 and LI-7700"
source_url: "https://www.licor.com/support/EddyPro/topics/calculate-flux-open-path-analyzers.html"
---
# Calculating turbulent fluxes for a system composed of an LI-7500A/RS/DS and LI-7700

The common example of an open path eddy covariance system is a station equipped with an anemometer, LI-7500, LI-7500A/RS, or LI-7500DS, and LI-7700.

In this case, corrected fluxes are calculated from uncorrected (fluxes as) according to the following procedure:

## Level 1 fluxes: application of spectral corrections

Spectral corrections are applied first to open path fluxes. This is because sensible and latent heat fluxes used in the WPL (or air density fluctuation) correction are the "environmental ones," those actually present in the atmosphere and affecting measurements of molar densities in open path analyzers. These are best estimated by compensating uncorrected fluxes for spectral losses. However, sensible heat flux is not yet corrected here (explained later). Therefore, at level 1 we have:

6‑91F1,gas = F0,gas · SCFw,gas

where the subscript 'gas' indicates that it is applied to all gases. Latent heat and evapotranspiration fluxes are spectrally corrected using the correction factor calculated for water vapor:

6‑92LE1 = LE0 ·SCFw,h2o

6‑93E1 = E0 · SCFw,h2o

Furthermore, uncorrected momentum flux and friction velocity are corrected using the relevant spectral correction factor:

6‑94T1 = T0 · SCFu,w

6‑95u*1 = u*0 · SCFu,w

## Level 2 and 3 fluxes

As a first step after spectral correction, evapotranspiration flux E is corrected with the WPL term, following the formulation proposed in [Webb et al. (1980, eq. 42b)](references.md#Webb):

6‑96
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1031.svg)

where μ = Md /Mh2o, and ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1032.svg) (that is, corrected for instrument-related sensible heat fluxes) if an LI-7500 was used for water vapor concentration.

Hence, Level 2 water vapor and latent heat fluxes are simply calculated as:

6‑97
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1033.svg)

6‑98
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1034.svg)

Now sensible heat flux is corrected for humidity effects following [van Dijk et al. (2004)](references.md#vanDijk), revising [Schotanus et al. (1983)](references.md#Schot) as explained in [Calculating Fluxes, Level 1, 2, and 3](calculate-flux-level-123.md).

6‑99
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1035.svg)

where α=0.51, and then it is spectrally corrected to get the first fully corrected flux:

6‑100H3 = H2 · SCFw,Ts

Now that sensible heat is fully corrected, evapotranspiration flux is corrected again, adding the WPL terms with the revised H:

6‑101
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1036.svg)

where, again, H3 contains the additional sensible heat contributions when an LI-7500 is used. Water vapor and latent heat fluxes are easily refined:

6‑102
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1037.svg)

6‑103LE3 = λ · E3

Now that evapotranspiration and sensible heat fluxes are fully corrected, fluxes of other gases such as carbon dioxide and methane can be corrected for air density fluctuations, according to [Webb et al. (1980 eq. 44)](references.md#Webb). For carbon dioxide, we get:

6‑104
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1038.svg)

In the event that methane fluxes are computed with data from an open path instrument other than the LI-7700, EddyFlow automatically sets the multipliers A, B, and C to unity.

** Note:** The evapotranspiration flux needed for this formulation is not corrected for the WPL term (but is corrected for spectral attenuations). In the present case, of water vapor measured with an open path analyzer:

6‑105
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1039.svg)

Finally, corrected fluxes (Level 3) of CO2 and CH4, in systems with open path instruments, coincide with fluxes at Level 2, which thus provide the most accurate flux estimate available with EddyFlow.
