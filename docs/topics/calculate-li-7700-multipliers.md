# Calculating multipliers for spectroscopic corrections (LI-7700)

When an LI-7700 CH4 analyzer is used, methane fluxes are calculated using Eq. 5.1 of the LI-7700 Instruction Manual. In this equation, which is formulated to highlight the correction terms for air density fluctuations ([Webb et al., 1980](references.md#Webb)), multipliers A, B, and C are specific to the LI-7700 analyzer, accounting for spectroscopic effects of temperature, pressure, and water vapor on methane molar density (A), spectroscopic effects of pressure and water vapor on the latent heat flux (B), and spectroscopic effects of temperature, pressure and water vapor on sensible heat flux (C). These multipliers are defined as:

6‑73
                                                            ![A=kappa](https://www.licor.com/support/GeneratedImages/Equations/Equation1007.svg)

6‑74
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1008.svg)

6‑75
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1009.svg)

where groups of parameters have been conveniently created (GROUP1 and GROUP2). Refer to the LI-7700 Instruction Manual for a detailed description of all parameters and variables that appear in these equations. For a description and testing of the correction please refer to ([McDermitt et al., 2010](references.md#McDermitt)).

The groups ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1010.svg), GROUP1 and GROUP2 are functions of air temperature (Tα), and equivalent pressure (Pe) and tabulated values are available with a resolution of 1° C and 1 kPa, for -50 to 55 °C and 50 to 115 kPa. Given actual values of Tα and Pe (the latter being a function of air pressure and water vapor mole fraction, χh2o). EddyFlow Software employs a look-up table (LUT) and performs a bi-linear interpolation to calculate the best estimates of the three groups. Once the values of ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1011.svg), GROUP1 and GROUP2 have been obtained, multipliers A, B, and C can be calculated according to equations above, and kept available for the later calculation of methane fluxes.

** Note:** The multipliers, as a function of air temperature, pressure and water vapor mole fraction, must be recalculated for each averaging period.
