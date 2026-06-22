# Calculating micrometeorological variables

Before calculating fluxes, EddyFlow calculates an additional set of micrometeorological parameters, which are used to calculate corrected fluxes or for future analysis of calculated fluxes. These are listed and briefly described here.

## Molecular weight of wet air (Ma, kg mol-1)

Calculated as the sum of molecular weights of dry air and water vapor, weighted by the water vapor mole fraction:

6‑32Ma=Mh2o•χh2o+Md•(1-χh2o)

where the subscript d is used for quantities referring to dry air, and where Md = 0.02897 kg mol-1 and Mh2o = 0.01802 kg mol-1.

## Ambient water vapor mass density (ρh2o, kg m-3)

Calculated from water vapor mole fraction as:

6‑33
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation968.svg)

## Water vapor partial pressure (e, Pa)

Calculated from the ideal gas law:

6‑34e = ρh2oRh2oTa

where ![](https://www.licor.com/support/GeneratedImages/Equations/Equation969.svg), is the water vapor gas constant.

## Water vapor partial pressure at saturation (es, Pa)

Calculated after [Campbell and Norman (1998)](references.md#Campbell) as:

6‑35
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation970.svg)

(e=2.7182, the base of the exponential function, not the water vapor partial pressure)

## Relative humidity (RH, %)

RH is computed according to its definition as:

6‑36
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation971.svg)

## Water vapor pressure deficit (VPD, Pa)

It is given by the difference between actual water vapor pressure and its saturation value:

6‑37VPD = e-es

## Dew point temperature (Tdew, K)

It is calculated after [Campbell and Norman (1998)](references.md#Campbell) as:

6‑38
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation972.svg)

where e is intended to be in *kPa*.

## Dry air partial pressure (Pd, Pa)

This is given simply by the difference between total (ambient) pressure and water vapor partial pressure.

6‑39Pd = Pa - e

## Dry air molar volume (vd, m3 mol-1)

It is calculated after [Ibrom et al. (2007b)](references.md#Ibrom) as:

6‑40
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation973.svg),

this formula has the same result as the direct application of the ideal gas law.

## Dry air mass density (ρd, kg m-3)

From the ideal gas law:

6‑41
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation974.svg),

where ![](https://www.licor.com/support/GeneratedImages/Equations/Equation975.svg) is the dry air gas constant.

## Moist air mass density (ρd, kg m-3)

It is given by the sum of dry air and water vapor mass densities:

6‑42
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation976.svg) .

## Dry air heat capacity at constant pressure (cp,d, J kg-1 K-1)

It is calculated as a function of temperature as:

6‑43
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation977.svg),

where Ta is expressed in degrees Celsius.

## Water vapor heat capacity at constant pressure (cp,h2o, J kg-1 K-1)

It is calculated as a function of temperature and relative humidity as:

6‑44
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation978.svg)

where Ta is expressed in degrees Celsius.

## Specific humidity (Q, kg kg-1)

It is calculated according to its definition as:

6‑45
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation979.svg) .

## Refining ambient temperature (Ta, K)

If ambient air temperature was calculated from sonic temperature, it is now corrected for the effect of ambient moisture content [(van Dijk, 2004](references.md#vanDijk), eq. 3.49):

6‑46
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation980.svg) .

Otherwise, if ambient air temperature was calculated by averaging raw data of ambient air temperature, Ta does not need a correction. In this case, a temperature mapping factor (Tmap) is calculated to rescale covariances that involve sonic temperature fluctuations arising from possible errors in the estimation of the acoustic path length of the anemometer ([van Dijk, 2004](references.md#vanDijk)):

6‑47
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation981.svg)

where x is any other variable, notably w.

## Refinement of cell temperature (Tc, K) (closed path systems only)

Cell temperature is now updated to account for the effect of ambient moisture content if, in the previous calculation, it was set equal to ambient air temperature. Recall that this happens only when no temperature reading from inside the cell is available.

## Moist air heat capacity at constant pressure (Cp, J kg-1 K-1)

It is calculated as a function of ambient moisture content as:

6‑48
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation982.svg)

## Specific evaporation heat (λ, J kg-1)

It is calculated as a function of ambient air temperature:

6‑49λ=103 (3147.5-2.37Ta)

## Water to dry air density ratio (σ, non-dimensional)

It is given by:

6‑50
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation983.svg)
