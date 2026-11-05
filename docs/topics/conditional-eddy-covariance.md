# Conditional Eddy Covariance

<span id="top"></span>

Conditional Eddy Covariance (CEC) partitions conventionally processed eddy covariance fluxes into plant and non-plant components using simultaneous high-frequency measurements of vertical wind, water vapor, and carbon dioxide. EddyFlow implements the method described by [Zahn et al. (2022)](references.md#Zahn2022).

CEC partitions:

- evapotranspiration (ET) into transpiration (Tr) and evaporation (E);
- net carbon dioxide flux (F<sub>c</sub>) into a photosynthetic component, reported by EddyFlow as net photosynthesis (P), and ecosystem respiration (Reco); and, as an **experimental** extension,
- any other gas measured alongside, such as carbonyl sulfide (COS), into a stomatal and a non-stomatal component.

The photosynthetic component called *P* by Zahn et al. (2022) is net photosynthesis: carboxylation minus photorespiration and leaf respiration. EddyFlow reports this component in the `P_cec` column. Because EddyFlow retains the flux-direction sign convention, `P_cec` is negative when carbon dioxide is taken up by the ecosystem.

## Activating CEC

CEC is optional and is disabled by default. To activate it:

1. Open **Advanced Settings**.
2. Select **Processing Options**.
3. Under **Other options**, activate **Conditional Eddy Covariance**.

CEC requires simultaneous high-frequency measurements of water vapor and of an *octant gas* in addition to the vertical wind component. The octant gas is carbon dioxide, as published; carbonyl sulfide can take its place experimentally. The total fluxes being partitioned are the normally processed EddyFlow fluxes, including the applicable density, spectral, and instrument corrections.

Activating this option enables the **CEC Settings** button, which opens a dialog for choosing which fluxes are partitioned, by which channels, and the quality gates a period must pass. See the [CEC settings dialog](cec-settings.md) reference for a description of each field.

## Method

CEC uses scalar and vertical-wind fluctuations within each flux averaging period. Here, *w'*, *q'*, and *c'* are fluctuations in vertical wind, water vapor, and the octant gas (normally carbon dioxide). The method analyzes moist upward-moving air parcels, or ejections (*w'* > 0, *q'* > 0), in two conditional classes, or *octants*:

- **Non-stomatal octant (O1):** *w'* > 0, *q'* > 0, and *c'* > 0. Air that gained both water and carbon dioxide: it came off the ground and the respiring parts of the ecosystem.
- **Stomatal octant (O2):** *w'* > 0, *q'* > 0, and *c'* < 0. Air that gained water but lost carbon dioxide: it passed through photosynthesizing leaves' stomata.

For every partitioned gas *x*, conditional sample fluxes are summed over the two octants, *f*<sub>O1</sub> = ⟨*w'x'*⟩<sub>O1</sub> and *f*<sub>O2</sub> = ⟨*w'x'*⟩<sub>O2</sub>. Their ratio is assumed to be the ratio of the complete non-stomatal and stomatal components:

<p align="center"><em>r</em> = <em>f</em><sub>O1</sub> / <em>f</em><sub>O2</sub> = non-stomatal / stomatal</p>

For water vapor this is *r*<sub>ET</sub> = E / Tr, and for carbon dioxide *r*<sub>Fc</sub> = Reco / P. The ratio is combined with the conventionally calculated total flux *F* = non-stomatal + stomatal:

<p align="center">non-stomatal = <em>F</em> / (1 + 1 / <em>r</em>)</p>

<p align="center">stomatal = <em>F</em> / (1 + <em>r</em>)</p>

so that E<sub>cec</sub>, Tr<sub>cec</sub>, Reco<sub>cec</sub> and P<sub>cec</sub> follow, and so do the components of any further gas. The conditional fluxes characterize the relative contributions of the sources and sinks; they are not themselves the final component fluxes. The final components retain the corrections included in the total EddyFlow fluxes, and the two components of every gas always add up to its total.

The octants are defined by *w'*, *q'* and *c'* alone. Any further gas is summed over the *same* octants, so its own sign plays no part in the sorting (Zahn et al. 2022, Sec. 2.4). This is what makes it possible to partition carbonyl sulfide, methane or nitrous oxide without assuming which way their ground exchange goes.

## Pairings and column names

A *pairing* is one octant gas and one water channel, plus every further gas sorted by the octants those two define. The CEC Settings table lists one row per flux; rows that share an octant gas and a water channel are one pairing. By default, EddyFlow creates one pairing per carbon dioxide channel, with the water vapor channel on the same analyzer, and reports water and carbon dioxide.

Every column of a pairing ends in the same suffix: the analyzer the octant gas is on, for example `_li7200_1` or `_miro_mga4_6_2`. When carbonyl sulfide sorts the octants, `_cos` is added (`_miro_mga4_6_2_cos`). Two pairings that would otherwise share a suffix are numbered `_1`, `_2`.

## Output variables

The following columns are added to the full output file, each followed by its pairing's suffix. Fluxes are in the unit of the gas's own flux column.

### Water vapor

| Label | Units | Description |
| --- | --- | --- |
| `E_cec` | mmol m<sup>-2</sup> s<sup>-1</sup> | Evaporation: the non-stomatal part of the water vapor flux. Positive upward. |
| `Tr_cec` | mmol m<sup>-2</sup> s<sup>-1</sup> | Transpiration: the stomatal part. Positive upward. |
| `E_cec_ET`, `Tr_cec_ET` | mm h<sup>-1</sup> | The same two as water depth. |
| `ET_cec` | mmol m<sup>-2</sup> s<sup>-1</sup> | The total water vapor flux that was partitioned. |
| `r_ET_cec` | – | E / Tr. |
| `cec_ns_h2o` | % | Stationarity statistic used by the stationarity gate. |
| `qc_cec_h2o` | – | Outcome of the partition (see [Quality codes](#quality-codes)). |

### Carbon dioxide (carbon dioxide octants)

| Label | Units | Description |
| --- | --- | --- |
| `Reco_cec` | µmol m<sup>-2</sup> s<sup>-1</sup> | Ecosystem respiration: the non-stomatal part. Positive (release). |
| `P_cec` | µmol m<sup>-2</sup> s<sup>-1</sup> | Net photosynthesis: the stomatal part. Negative (uptake). |
| `NEE_cec` | µmol m<sup>-2</sup> s<sup>-1</sup> | The total carbon dioxide flux that was partitioned. |
| `r_Fc_cec` | – | Reco / P. |
| `cec_ns_co2`, `qc_cec_co2` | %, – | As for water vapor. |

### Any other gas, and carbonyl sulfide (experimental)

For a further gas, and for carbonyl sulfide when it sorts the octants, the columns are named after the gas, `<gas>` being its output name (`cos`, `ch4`, `n2o_2`, …):

| Label | Description |
| --- | --- |
| `<gas>_nonstomatal_cec` | The part carried by non-stomatal air (O1). |
| `<gas>_stomatal_cec` | The part carried by stomatal air (O2). |
| `<gas>_total_cec` | The total flux that was partitioned. |
| `r_<gas>_cec` | Non-stomatal / stomatal. |
| `cec_ns_<gas>`, `qc_cec_<gas>` | As for water vapor. |
| `cec_sign_<gas>` | Carbonyl sulfide only: 1 when the stomatal part came out as emission, 0 for uptake or zero, the error code when there is no stomatal part. |

### Octant statistics

| Label | Description |
| --- | --- |
| `cec_n_o1`, `cec_n_o2` | Number of samples in the non-stomatal and stomatal octants. |
| `cec_frac_o1`, `cec_frac_o2` | The same as a fraction of all valid samples. |

### Quality codes

Every `qc_cec_<gas>` column holds one of these codes:

| Code | Meaning | Components |
| --- | --- | --- |
| 0 | Rejected by a quality gate: too little valid data, non-stationary, or too few samples in the two octants together. | Missing |
| 1 | **Partitioned**: both octants held enough samples and the ratio was usable. | Measured split |
| 2 | The non-stomatal octant held too few samples; the whole flux is assigned to the stomatal component. | Fallback |
| 3 | The stomatal octant held too few samples; the whole flux is assigned to the non-stomatal component. Typical at night. | Fallback |
| 4 | Singular: the two components nearly cancel (*r* close to -1), so the split is ill-conditioned. | Missing |
| 5 | Wrong sign: the corrected total points against the octant sums, so splitting it would turn a component the wrong way round. | Missing |
| 6 | The flux was smaller than the chosen multiple of its random error (**Only partition a resolvable flux**). For a further gas, this rejects only that gas, not its pairing. | Missing |

Only code 1 is a measured partition. Codes 2 and 3 are the fallbacks described by Zahn et al. (2022): they assign the whole flux to one component because the other octant was too sparsely sampled, not because the other component was measured to be zero.

## Interpreting the results

### Water vapor

`Tr_cec` is water that left through stomata; `E_cec` is everything else: soil evaporation, evaporation from wet leaves and stems, and open water. Both are expected to be positive and `r_ET_cec` positive. A period with a downward total, such as dew formation, cannot be split and is reported with code 5. After rain, evaporation of intercepted water from photosynthesizing leaves is carried in the same parcels as transpiration and is counted as `Tr_cec`.

### Carbon dioxide

`P_cec` is net photosynthesis (negative) and `Reco_cec` is respiration from soil, stems and leaves (positive), so `r_Fc_cec` is normally negative. The closer it is to -1, the more the two components cancel and the less certain both become; the **Singularity band** rejects the worst of these periods (code 4). At night, photosynthesis stops, the stomatal octant empties, and most periods come out as code 3 with the whole flux assigned to respiration, which is the expected result.

### Carbonyl sulfide (experimental)

Leaves take carbonyl sulfide up through their stomata and, unlike carbon dioxide, do not respire it back. That makes the stomatal component of COS a second, independent estimate of canopy photosynthesis. Soil, however, can either take COS up or give it off, and a senescent canopy may give it off as well.

With **carbon dioxide octants** (the default), the sorting is independent of COS:

- `cos_stomatal_cec` is the canopy's stomatal uptake, and is expected to be negative. Where `cec_sign_cos` is 1, it came out as emission: check the quality code and the flux's random error first, since noise is the usual cause; a run of such periods in autumn may reflect a senescent canopy.
- `cos_nonstomatal_cec` is the ground's exchange plus canopy exchange that is not through stomata. It can have **either sign**: negative where the soil takes COS up, positive where the soil or a senescent canopy gives it off. A senescent canopy respires rather than photosynthesizes, which raises *c'*, so its emission is sorted into this component.
- `r_cos_cec` is positive when ground and canopy both take COS up, and negative when the ground gives it off while the canopy takes it up. Values near -1 are rejected as singular.
- **At night**, the stomatal octant is nearly empty because there is no photosynthesis to draw carbon dioxide down, so periods fall back to code 3 and the whole COS flux is assigned to the non-stomatal component. Nocturnal uptake through incompletely closed stomata is therefore counted as ground exchange. Treat night-time `cos_nonstomatal_cec` as an upper bound on soil exchange.

With **carbonyl sulfide octants** (experimental), an updraft that lost COS counts as stomatal. This holds only where the ground is a net COS source or negligible: soil uptake carried in moist updrafts is then counted as stomatal and inflates the canopy's uptake. Where the soil gives COS off, COS and carbon dioxide octants sort the same parcels. Run a carbon dioxide–octant row beside a COS-octant row: where their stomatal components agree, soil uptake is negligible; where the COS-octant stomatal component is clearly more negative, the soil is taking COS up.

To turn the stomatal COS flux into gross primary productivity, scale it by the leaf relative uptake (LRU):

<p align="center">GPP ≈ −<code>cos_stomatal_cec</code> × (CO<sub>2</sub> / COS) / LRU</p>

With the COS flux in pmol m<sup>-2</sup> s<sup>-1</sup>, CO<sub>2</sub> in µmol mol<sup>-1</sup> and COS in pmol mol<sup>-1</sup>, GPP comes out in µmol m<sup>-2</sup> s<sup>-1</sup>. LRU varies with light and species; values around 1.6 are commonly used. Comparing the result with `P_cec` from the same pairing is a useful check, since both come from the same octants.

### Other gases (experimental)

Any other gas, such as methane or nitrous oxide, can be split in the same octants. The octants say which air passed through photosynthesizing leaves; they say nothing about how that gas is exchanged. Read `<gas>_stomatal_cec` as the part *carried by stomatal air* and `<gas>_nonstomatal_cec` as the part carried by the rest, not as a statement that the gas passed through stomata.

## Assumptions and limitations

CEC relies on similarity in the turbulent transport of the paired stomatal components and of the paired non-stomatal components. Consider the following limitations when interpreting the results:

- **Conditional sample size:** The two ejection classes must contain enough samples to represent both kinds of transport. In the method described by Zahn et al. (2022), the two classes together must contain at least 20% of all samples. If either class contains less than 5%, the flux is assigned entirely to the other component.
- **Small net flux:** Partitioning becomes unstable when the two components are both substantial but nearly balance, so that the total approaches zero and *r* approaches -1. This affects carbon dioxide, and carbonyl sulfide where the soil emits it. Component estimates should be scrutinized or avoided under these conditions, although ET partitioning can remain usable.
- **Source coupling:** Respiration and evaporation must occur simultaneously and be spatially collocated for their shared air-parcel signature to be detected. Dense canopies or weak turbulence can decouple below-canopy sources from an above-canopy system.
- **Measurement height:** Sensors should be close enough to the canopy to retain distinct ground and plant signatures. Measurements taken too far above the canopy may be too thoroughly mixed for robust conditional sampling.
- **Intercepted water:** Evaporation of intercepted water from leaves or branches while photosynthesis is occurring can be classified as transpiration. Periods following precipitation should therefore be interpreted separately or excluded when interception is important.
- **Condensation:** Negative water vapor fluxes, such as during dew formation, do not meet the assumed upward directions of evaporation and transpiration and are reported with code 5.
- **Two analyzers:** A pairing whose water and octant gas sit on different analyzers builds its octants from two series with different time lags and spectral responses. It still runs, with a warning, but is a weaker measurement.
- **Gases beyond water and carbon dioxide:** Partitioning them, and sorting by carbonyl sulfide octants, goes beyond what Zahn et al. (2022) tested, and is marked experimental. Read these results alongside a published partition, not instead of one.

CEC results are method-dependent estimates rather than independent measurements of the component fluxes. Site characteristics, atmospheric conditions, data quality, and the placement of the eddy covariance system should all be considered during interpretation.
