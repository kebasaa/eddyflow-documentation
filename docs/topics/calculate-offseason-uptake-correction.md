---
title: "Calculating the Off-season Uptake Correction (LI-7500 only)"
source_url: "https://www.licor.com/support/EddyPro/topics/calculate-offseason-uptake-correction.html"
---
# Calculating the off-season uptake correction (LI-7500 only)

See [Add instrument sensible heat components (LI-7500)](selecting-advanced-options.md#Add) for more information.

When CO2 and H2O molar densities are measured with the an LI-7500 in cold environments (low temperatures below -10 °C), a correction should be applied to account for the additional instrument-related sensible heat flux, due to instrument surface heating/cooling. The correction is not needed with the LI-7500A/RS/DS unless the analyzer was configured for the ** summer ** setting but used in a very cold environment. The correction is fully described and tested in literature ([Burba et al., 2008](references.md#Burba); [Grelle and Burba, 2007](references.md#Grelle); [Jarvi et al., 2009](references.md#Jarvi)). EddyFlow implements the correction according to Table 1, Method 4 of [Burba et al. (2008)](references.md#Burba), which involves calculating a corrected sensible heat flux (![](https://www.licor.com/support/GeneratedImages/Equations/Equation1005.svg)) by adding estimated sensible heat fluxes from key instrument surface elements, including the bottom window (Hbot), top window (Htop), and spar (Hspar)—to the ambient sensible heat flux (H):

6‑72
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1006.svg)

where the factor 0.15 accounts for the possibility that the heat flux may or may not enter the instrument path.

Additional sensible heat fluxes are calculated according to equations in the same Table 1 ([Nobel's (1983)](references.md) formulation) and the implied surface temperatures are estimated either with linear equations similar to those in Eqs. 3-8 in [Burba et al. (2008)](references.md#Burba), using slope and offset parameters from Table 3 in the same paper, or with multiple linear regression relationships between instrument temperatures and controlling factors (Table 2 in [Burba et al., 2008](references.md#Burba)). Corrected sensible heat flux is only used for calculating WPL terms when gas densities are measured by an LI-7500.

** Note:** In results files and elsewhere, the used and reported sensible heat is the environmental one (H). We also stress again that this correction does not apply to data measured with an LI-7500RS, unless the LI-7500RS was configured for the ** summer ** setting but used in a very cold environment.
