---
title: "Calculating Fluxes"
source_url: "https://www.licor.com/support/EddyPro/topics/calculate-fluxes.html"
---
# Calculating fluxes

After completing preliminary calculations, EddyFlow can start evaluating fluxes, starting from uncorrected fluxes. With 'uncorrected fluxes' gas, energy, and momentum fluxes are obtained by merely adjusting units of relevant covariances, in order to match the desired output units.

This operation may imply the inclusion of some previously calculated physical parameters. These fluxes are 'uncorrected' because some effects are not accounted for in their calculation, notably the effects of air density fluctuations, of spectral losses, and effects of humidity on air temperature estimation through the sonic anemometer. Furthermore, sensor-specific effects such as the so-called off-season uptake effect for the LI-7500 and the spectroscopic effects for the LI-7700 are not taken into account in uncorrected fluxes.

All these effects, instead, are addressed later, with different paths of processing depending mainly on the type of analyzer used (closed or open path). In fact, EddyFlow calculates a total of 4 levels of fluxes (from level '0', uncorrected fluxes, to level '3', fully corrected fluxes). However, only level '0' and level '3' are provided in the output. Intermediate levels '1' and '2' are not provided, mainly because they assume different meanings in different situations, thus their interpretation may be ambiguous and their utility is limited.

In the following sections, along with common fluxes, we also describe how cell fluxes are evaluated for the purpose of evaluating WPL terms in closed path systems. In general, the expression 'cell fluxes' refers to the sensible heat and evapotranspiration fluxes as evaluated by using cell covariances.
