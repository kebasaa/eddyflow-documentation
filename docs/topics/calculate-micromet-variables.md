# Calculating micrometeorological variables

Before calculating fluxes, EddyFlow calculates an additional set of micrometeorological parameters, which are used to calculate corrected fluxes or for future analysis of calculated fluxes. These are listed and briefly described here.

## Molecular weight of wet air (Ma, kg mol-1)

Calculated as the sum of molecular weights of dry air and water vapor, weighted by the water vapor mole fraction:

6‑32Ma=Mh2o•χh2o+Md•(1-χh2o)

where the subscript d is used for quantities referring to dry air, and where Md = 0.02897 kg mol-1 and Mh2o = 0.01802 kg mol-1.

## Ambient water vapor mass density (ρh2o, kg m-3)

Calculated from water vapor mole fraction as:

$$
\rho_{\mathit{h2o}} = \frac{\chi_{\mathit{h2o}} \cdot M_{\mathit{h2o}}}{v_a} \tag{6-33}
$$

## Water vapor partial pressure (e, Pa)

Calculated from the ideal gas law:

6‑34e = ρh2oRh2oTa

where \(R_{\mathit{h2o}} = \mathfrak{R} / M_{\mathit{h2o}}\ \left(J kg^{-1} K^{-1}\right)\), is the water vapor gas constant.

## Water vapor partial pressure at saturation (es, Pa)

Calculated after [Campbell and Norman (1998)](references.md#Campbell) as:

$$
e_s = T_a^{-8.2}\, e^{77.345 + 0.0057 \cdot T_a - 7235 \cdot T_a^{-1}} \tag{6-35}
$$

(e=2.7182, the base of the exponential function, not the water vapor partial pressure)

## Relative humidity (RH, %)

RH is computed according to its definition as:

$$
RH = \frac{e}{e_s} \cdot 100 \tag{6-36}
$$

## Water vapor pressure deficit (VPD, Pa)

It is given by the difference between actual water vapor pressure and its saturation value:

6‑37VPD = e-es

## Dew point temperature (Tdew, K)

It is calculated after [Campbell and Norman (1998)](references.md#Campbell) as:

$$
T_{\mathit{dew}} = 240.97 \cdot \frac{\ln\left(\frac{e}{0.611}\right)}{17.502 - \ln\left(\frac{e}{0.611}\right)} + 273.16 \tag{6-38}
$$

where e is intended to be in *kPa*.

## Dry air partial pressure (Pd, Pa)

This is given simply by the difference between total (ambient) pressure and water vapor partial pressure.

6‑39Pd = Pa - e

## Dry air molar volume (vd, m3 mol-1)

It is calculated after [Ibrom et al. (2007b)](references.md#Ibrom) as:

6‑40
                                                            \(v_d = v_a \frac{P_a}{P_d}\),

this formula has the same result as the direct application of the ideal gas law.

## Dry air mass density (ρd, kg m-3)

From the ideal gas law:

6‑41
                                                            \(\rho_d = \frac{P_d}{R_d T_a}\),

where \(R_d = \mathfrak{R} / M_d\ \left(J kg^{-1} K^{-1}\right)\) is the dry air gas constant.

## Moist air mass density (ρd, kg m-3)

It is given by the sum of dry air and water vapor mass densities:

6‑42
                                                            \(\rho_a = \rho_d + \rho_{\mathit{h2o}}\) .

## Dry air heat capacity at constant pressure (cp,d, J kg-1 K-1)

It is calculated as a function of temperature as:

6‑43
                                                            \(c_{p,d} = 1005 + \frac{(T_a + 23.12)^2}{3364}\),

where Ta is expressed in degrees Celsius.

## Water vapor heat capacity at constant pressure (cp,h2o, J kg-1 K-1)

It is calculated as a function of temperature and relative humidity as:

$$
c_{p,\mathit{h2o}} = 1859 + 0.13 RH + \left(0.193 + 5.6 \cdot 10^{-3} RH\right) \cdot T_a + \left(10^{-3} + 5 \cdot 10^{-5} RH\right) \cdot T_a^{2} \tag{6-44}
$$

where Ta is expressed in degrees Celsius.

## Specific humidity (Q, kg kg-1)

It is calculated according to its definition as:

6‑45
                                                            \(Q = \frac{\rho_{\mathit{h2o}}}{\rho_a}\) .

## Refining ambient temperature (Ta, K)

If ambient air temperature was calculated from sonic temperature, it is now corrected for the effect of ambient moisture content [(van Dijk, 2004](references.md#vanDijk), eq. 3.49):

6‑46
                                                            \(\widetilde{T}_a = \frac{T_a}{1 + 0.51 Q}\) .

Otherwise, if ambient air temperature was calculated by averaging raw data of ambient air temperature, Ta does not need a correction. In this case, a temperature mapping factor (Tmap) is calculated to rescale covariances that involve sonic temperature fluctuations arising from possible errors in the estimation of the acoustic path length of the anemometer ([van Dijk, 2004](references.md#vanDijk)):

$$
T_{\mathit{map}} = \frac{T_a}{T_s} \Rightarrow \overline{T_s\,'x'} \rightarrow \overline{T_s\,'x'} \cdot T_{\mathit{map}} \tag{6-47}
$$

where x is any other variable, notably w.

## Refinement of cell temperature (Tc, K) (closed path systems only)

Cell temperature is now updated to account for the effect of ambient moisture content if, in the previous calculation, it was set equal to ambient air temperature. Recall that this happens only when no temperature reading from inside the cell is available.

## Moist air heat capacity at constant pressure (Cp, J kg-1 K-1)

It is calculated as a function of ambient moisture content as:

$$
c_p = c_{p,d}\,(1 - Q) + c_{p,\mathit{h2o}} Q \tag{6-48}
$$

## Specific evaporation heat (λ, J kg-1)

It is calculated as a function of ambient air temperature:

6‑49λ=103 (3147.5-2.37Ta)

## Water to dry air density ratio (σ, non-dimensional)

It is given by:

$$
\sigma = \frac{\rho_{\mathit{h2o}}}{\rho_d} \tag{6-50}
$$
