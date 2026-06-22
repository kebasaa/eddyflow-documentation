# Converting concentrations or densities into mixing ratios

See [Compensation of density fluctuations](selecting-advanced-options.md#Compensa) for more information.

For closed path gas analyzers, data may be converted to mixing ratios. At this point in the raw data processing, metadata concerning gas concentrations from closed path systems are analyzed by EddyFlow to autonomously decide whether to perform a sample-by-sample conversion into *mixing ratios* (r, moles of gas per mole of dry air). Expressing gas concentrations as mixing ratios is convenient because this makes it unnecessary to apply the WPL correction ([Webb et al., 1980](references.md#Webb)). It is an alternative way to account for air density fluctuations resulting from thermal expansion/contraction and concentration/dilution due to water vapor (see [Ibrom et al., 2007b](references.md#Ibrom), for example). For a thorough discussion concerning the use of mixing ratios in closed path instruments, see [Burba et al. (2012)](references.md#Burba2).

Conversion from mole fractions of any gas (χgas, moles of gas per mole of wet air) into mixing ratios is performed according to:

6‑21
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation951.svg)

where χh2o,i is the mole fraction of water vapor and the subscript i is used to stress that these are "instantaneous" values (individual data samples).

Conversion of mole densities of any gas (dgas, moles of gas per unit of volume) into mixing ratios is performed according to:

6‑22
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation952.svg)

where vcell,i (volume per mole of wet air) is the molar volume inside the cell, evaluated for each data sample.

** Note:** Actual units are handled automatically by EddyFlow, as different gas concentrations might be measured with different units, due to their very different ambient concentrations, from parts per thousand (*mmol/mol* or *ppt*) of water vapor to parts per billion of methane (*nmol/mol* or *ppb*).

However, these conversions are not always feasible. In particular, conversion of mole fractions into mixing ratios is performed if the following conditions hold:

1. The gas was measured by the same instrument that measured water vapor;
2. Water vapor is available as (or convertible into) mole fraction.

Conversion of molar densities into mixing ratios is performed if the following conditions hold:

1. The gas was measured by the same instrument that measured water vapor;
2. Water vapor is available as (or convertible into) mole fraction;
3. Fast cell temperature and pressure readings are available in the raw files.

If any of these conditions do not hold, EddyFlow applies the density correction following the classic WPL approach.

** Note:** The conversion is performed before compensating eventual time lags, because water vapor, as an adsorbing/desorbing scalar, typically shows different time lags than passive scalars such as carbon dioxide ([Ibrom et al., 2007b](references.md#Ibrom)). The conversion must be performed using the water vapor concentration that was present in the cell at the moment the other scalar was measured. Compensating different time lags prior to the conversion would lead to the use of the wrong water vapor concentration sample for any given sample of the gas to be converted.
