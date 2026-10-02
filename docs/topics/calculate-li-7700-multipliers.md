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

!!! note

    The multipliers, as a function of air temperature, pressure and water vapor mole fraction, must be recalculated for each averaging period.

## How the multipliers enter the methane flux

With an LI-7700, the density-fluctuation correction of the methane flux (Level 2) is not the generic open-path WPL formula. It is the formulation of [Webb et al. (1980)](references.md#Webb) as modified in the LI-7700 manual, in which all three multipliers act:

    F2,ch4 = A · [ F1,ch4 + B · μ · ρc · E1 / ρd + C · (1 + μσ) · H3 · ρc / (ρ·cp·Ta) ]

where F1,ch4 is the spectrally corrected methane flux, ρc the methane molar density term, E1 the spectrally corrected evapotranspiration flux **before** the WPL term, ρd and ρ the dry air and air densities, cp the specific heat of air, Ta the ambient temperature, H3 the fully corrected sensible heat flux, μ = Md/Mh2o and σ the mixing ratio of water vapor to dry air.

- **A** scales the whole flux. It is also applied to the methane concentration and mixing ratio, which is why those columns always carried it.
- **B** scales the water-vapor (evapotranspiration) term.
- **C** scales the sensible-heat term. The heat term carries the extra factor (1 + μσ), and it has no instrument-surface heating (Burba et al., 2008) component, because the LI-7700 is not an LI-7500.

Multipliers are computed **per gas**, from the water vapor the gas is corrected with, so two LI-7700 analyzers paired with different hygrometers each keep their own A, B and C. They are recomputed for every averaging period, and the stored values are cleared at the start of each period, so a period in which they cannot be computed does not inherit the previous period's numbers.

!!! warning "What changed in your methane fluxes"

    Earlier versions applied only **A** to the methane flux; **B** and **C** were computed and written to the FLUXNET file but entered no calculation. Methane fluxes measured with an LI-7700 are therefore **larger in magnitude** now. On the LI-COR test archives (B = 1.41706, C = 1.32187) the methane flux was −0.0164255 µmol m⁻² s⁻¹ before and is −0.0183822 µmol m⁻² s⁻¹ now, so the earlier value was 10.6% low; the new value agrees to the last printed digit with EddyPro 7.0.9 on the same archives. The size of the change depends on the data, because it follows B, C and the water vapor and heat fluxes of each period. Concentrations, mixing ratios, time lags and spectral correction factors are unchanged. Only methane fluxes from an LI-7700 move; fluxes of CO2 and H2O from other analyzers are not affected by this.

## Multipliers in the FLUXNET output

The FLUXNET file carries the multipliers as **three columns per gas**, `SPEC_CORR_LI7700_A_<GAS>`, `SPEC_CORR_LI7700_B_<GAS>` and `SPEC_CORR_LI7700_C_<GAS>` (for example `SPEC_CORR_LI7700_A_CO2`), in place of the former fixed `SPEC_CORR_LI7700_A`, `SPEC_CORR_LI7700_B` and `SPEC_CORR_LI7700_C`. A gas that is not measured by an LI-7700 holds the missing-value token. See [The full output file](output-files-full-output.md#columns-and-files-added-or-changed-in-recent-versions).

In a project where the multipliers are not available (open-path methane from an analyzer other than the LI-7700), A, B and C are set to unity.
