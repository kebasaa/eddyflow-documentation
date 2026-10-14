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

!!! note

    Actual units are handled automatically by EddyFlow, as different gas concentrations might be measured with different units, due to their very different ambient concentrations, from parts per thousand (*mmol/mol* or *ppt*) of water vapor to parts per billion of methane (*nmol/mol* or *ppb*).

The conversion happens only with **Compensate density fluctuations (WPL terms)** ticked, and only where it is feasible. Conversion of mole fractions into mixing ratios is performed if the following conditions hold:

1. The water the gas's record names (`gas_<i>_moist`; by default the H<sub>2</sub>O on the gas's own analyser) is a closed-path hygrometer in the project. It may sit on a different analyser from the gas - EddyFlow then says so with Warning(106) - but the biomet RH has no fast series and cannot be used;
2. Water vapor is available as (or convertible into) mole fraction.

Conversion of molar densities into mixing ratios is performed if the following conditions hold:

1. Both conditions above hold;
2. Fast cell temperature and pressure readings for the gas's own analyser are available in the raw files.

Each hygrometer is converted in the same way, with its own cell. If any of these conditions do not hold, EddyFlow applies the density correction to the flux instead, following Ibrom et al. (2007) on a closed path and Webb et al. (1980) on an open one.

!!! note

    A gas already reported as a **mixing ratio** (moles per mole of dry air) is neither converted nor corrected, whether or not the box is ticked: its density effects are already gone. The decision is made per gas, from the measure type in the Raw File Description, so an analyser that reports dry mixing ratios - such as a MIRO for its trace gases - is never corrected twice, while its water, if reported as a mole fraction of wet air, still is. To leave an analyser uncorrected, give its gases the measure type it really reports; do not untick the box, which switches the correction off for every gas.

!!! note

    The conversion is performed before compensating eventual time lags, because water vapor, as an adsorbing/desorbing scalar, typically shows different time lags than passive scalars such as carbon dioxide ([Ibrom et al., 2007b](references.md#Ibrom)). The conversion must be performed using the water vapor concentration that was present in the cell at the moment the other scalar was measured. Compensating different time lags prior to the conversion would lead to the use of the wrong water vapor concentration sample for any given sample of the gas to be converted.
