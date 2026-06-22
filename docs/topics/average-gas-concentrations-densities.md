# Calculating average gas concentrations and densities

After having calculated ambient and cell molar volumes, for each available gas EddyFlow can calculate average concentrations expressed as mole fractions and mixing ratios, as well as average molar densities. The equations used are:

6‑30
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation966.svg)

6‑31
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation967.svg)

where symbols have the usual meaning (see [Converting raw gas density to mixing ratio](converting-to-mixing-ratio.md)) used here to indicate mean values, averaged over the flux averaging interval, and v is either ambient air molar volume, va, or cell molar volume vc, depending on whether gases are measured from an open path or a closed path system, respectively.

These equations are combined appropriately, depending on the available measurements, to calculate unknowns.

** Note:** For CH4 measurements made with the LI-7700 Open Path CH4 Analyzer, EddyFlow reports mixing ratio and mole fraction values that are corrected for spectroscopic effects. It reports average number density values that are not corrected for spectroscopic effects. Refer to the LI-7700 Instruction Manual for more information.
