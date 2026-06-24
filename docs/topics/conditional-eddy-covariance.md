# Conditional Eddy Covariance

<span id="top"></span>

Conditional Eddy Covariance (CEC) partitions conventionally processed eddy covariance fluxes into plant and non-plant components using simultaneous high-frequency measurements of vertical wind, water vapor, and carbon dioxide. EddyFlow implements the method described by [Zahn et al. (2022)](references.md#Zahn2022).

CEC partitions:

- evapotranspiration (ET) into transpiration (Tr) and evaporation (E); and
- net carbon dioxide flux (F<sub>c</sub>) into a photosynthetic component, reported by EddyFlow as gross primary productivity (GPP), and ecosystem respiration (Reco).

The photosynthetic component called *P* by Zahn et al. (2022) is net photosynthesis: carboxylation minus photorespiration and leaf respiration. EddyFlow reports this component in the `GPP_cec` column. Because EddyFlow retains the flux-direction sign convention, `GPP_cec` is negative when carbon dioxide is taken up by the ecosystem.

## Activating CEC

CEC is optional and is disabled by default. To activate it:

1. Open **Advanced Settings**.
2. Select **Processing Options**.
3. Under **Other options**, activate **Conditional Eddy Covariance**.

CEC requires simultaneous high-frequency measurements of carbon dioxide and water vapor in addition to the vertical wind component. The total carbon dioxide and water vapor fluxes used for partitioning are the normally processed EddyFlow fluxes, including the applicable density, spectral, and instrument corrections.

## Method

CEC uses scalar and vertical-wind fluctuations within each flux averaging period. Here, *w'*, *q'*, and *c'* are fluctuations in vertical wind, water vapor, and carbon dioxide, respectively. The method analyzes upward-moving air parcels, or ejections (*w'* > 0), in two conditional classes:

- **Non-stomatal class:** *w'* > 0, *q'* > 0, and *c'* > 0. These samples are associated with evaporation and respiration.
- **Stomatal class:** *w'* > 0, *q'* > 0, and *c'* < 0. These samples are associated with transpiration and photosynthetic carbon dioxide uptake.

Conditional sample fluxes are calculated for evaporation (*f*<sub>E</sub>), transpiration (*f*<sub>Tr</sub>), respiration (*f*<sub>Reco</sub>), and photosynthesis (*f*<sub>GPP</sub>). Their ratios are assumed to represent the ratios of the corresponding complete flux components:

<p align="center"><em>r</em><sub>ET</sub> = <em>f</em><sub>E</sub> / <em>f</em><sub>Tr</sub> = E / Tr</p>

<p align="center"><em>r</em><sub>Fc</sub> = <em>f</em><sub>Reco</sub> / <em>f</em><sub>GPP</sub> = Reco / GPP</p>

The ratios are combined with the conventionally calculated total fluxes, ET = E + Tr and F<sub>c</sub> = Reco + GPP:

<p align="center">E<sub>cec</sub> = ET / (1 + 1 / <em>r</em><sub>ET</sub>)</p>

<p align="center">Tr<sub>cec</sub> = ET / (1 + <em>r</em><sub>ET</sub>)</p>

<p align="center">Reco<sub>cec</sub> = F<sub>c</sub> / (1 + 1 / <em>r</em><sub>Fc</sub>)</p>

<p align="center">GPP<sub>cec</sub> = F<sub>c</sub> / (1 + <em>r</em><sub>Fc</sub>)</p>

The conditional fluxes characterize the relative contributions of the sources and sinks; they are not themselves the final component fluxes. The final components retain the corrections included in the total EddyFlow fluxes.

## Output variables

When CEC is activated, EddyFlow adds the following columns to the full output file:

| Label | Units | Description |
| --- | --- | --- |
| `GPP_cec` | µmol m<sup>-2</sup> s<sup>-1</sup> | CEC photosynthetic carbon dioxide flux. Negative values indicate ecosystem carbon dioxide uptake. |
| `Reco_cec` | µmol m<sup>-2</sup> s<sup>-1</sup> | CEC ecosystem respiration. Positive values indicate carbon dioxide release to the atmosphere. |
| `Tr_cec` | mmol m<sup>-2</sup> s<sup>-1</sup> | CEC transpiration. Positive values indicate an upward water vapor flux. |
| `E_cec` | mmol m<sup>-2</sup> s<sup>-1</sup> | CEC evaporation. Positive values indicate an upward water vapor flux. |

## Assumptions and limitations

CEC relies on similarity in the turbulent transport of the paired stomatal components and of the paired non-stomatal components. Consider the following limitations when interpreting the results:

- **Conditional sample size:** The two ejection classes must contain enough samples to represent both kinds of transport. In the method described by Zahn et al. (2022), the two classes together must contain at least 20% of all samples. If either class contains less than 5%, the flux is assigned entirely to the other component.
- **Small net carbon dioxide flux:** Carbon partitioning becomes unstable when photosynthesis and respiration are both substantial but nearly balance, so that F<sub>c</sub> approaches zero and *r*<sub>Fc</sub> approaches -1. Carbon component estimates should be scrutinized or avoided under these conditions, although ET partitioning can remain usable.
- **Source coupling:** Respiration and evaporation must occur simultaneously and be spatially collocated for their shared air-parcel signature to be detected. Dense canopies or weak turbulence can decouple below-canopy sources from an above-canopy system.
- **Measurement height:** Sensors should be close enough to the canopy to retain distinct ground and plant signatures. Measurements taken too far above the canopy may be too thoroughly mixed for robust conditional sampling.
- **Intercepted water:** Evaporation of intercepted water from leaves or branches while photosynthesis is occurring can be classified as transpiration. Periods following precipitation should therefore be interpreted separately or excluded when interception is important.
- **Condensation:** Negative water vapor fluxes, such as during dew formation, do not meet the assumed upward directions of evaporation and transpiration and can lead to nonphysical partitioning.

CEC results are method-dependent estimates rather than independent measurements of the four component fluxes. Site characteristics, atmospheric conditions, data quality, and the placement of the eddy covariance system should all be considered during interpretation.
