# Flux quality flags for micrometeorological tests

See [Quality check](selecting-advanced-options.md#Quality) for more information.

Quality flags are calculated for all fluxes (sensible and latent heat, momentum and gas fluxes). The final flags provided on output files are based on a combination of partial flags calculated as a result of two tests, widely adopted and thoroughly described in literature (see [Foken et al., 2004](references.md#Foken2); [Foken and Wichura, 1996](references.md#Foken); [Göckede et al., 2008](references.md#Gockede)).

The two tests are known as the *steady state test* and the *developed turbulent conditions* test. For details on the two methods refer to the cited literature. In EddyFlow, each test provides a flag ranging from 1 (best) to 9 (poorest). The two flags are then combined into a unique flag, depending on the selected flagging policy:

- Mauder and Foken 2004: policy described in the documentation of the TK2 Eddy Covariance software that also constituted the standard of the CarboEurope IP project and is widely adopted. Here, the combined flag attains the value "0" for best quality fluxes, "1" for fluxes suitable for general analysis such as annual budgets and "2" for fluxes that should be discarded from the results dataset.
- Foken 2003: A system based on 9 quality grades. "0" is best, "9" is worst. The system of [Mauder and Foken (2004)](references.md#Mauder) and of [Göckede et al. (2006)](references.md#Gockede2) are based on a rearrangement of this system.
- [Göckede et al., 2006](references.md#Gockede2): A system based on 5 quality grades. "0" is best, "5" is worst.
- Vitale et al. (2020) (0-1-2 severity system): a two-tier severity flag built from a wider set of tests. "0" is ok, "1" is moderate and "2" is severe. See the section below.

## Vitale et al. (2020) (0-1-2 severity system)

**Exact UI label:** Vitale et al. (2020) (0-1-2 severity system), the fourth entry of the **Flagging policy** combo of the **Quality check** option on the Processing Options page. Project-file key: `qc_meth=4`. Method after [Vitale et al. (2020)](references.md#Vitale2020).

**What it does.** Each flux (momentum, sensible heat and every gas) receives a flag of 0 (ok), 1 (moderate evidence of a problem) or 2 (severe evidence). Several tests are evaluated for the flux and the variables that make it up; the flag is 2 if any test is in its severe range, otherwise 1 if any is in its moderate range, otherwise 0. If the flux itself is missing, the flag is missing. Choose it when you want the flag to reflect raw-signal problems as well as the stationarity and developed-turbulence tests, for example to follow the data cleaning of the paper.

**Tests and thresholds.**

| Test | Moderate (flag 1) | Severe (flag 2) |
| --- | --- | --- |
| Integral turbulence characteristics (ITC) deviation, using the deviation of w for all fluxes | deviation above 30 % and up to 100 % | deviation above 100 % |
| Nonstationarity ratio of [Mahrt (1998)](references.md#Mahrt1998), for the flux's own variable | above 2 and up to 3 | above 3 |
| KID (see [Kurtosis index of differences (KID)](despiking-raw-statistical-screening.md#kurtosis-index-of-differences-kid)) of each variable | above 30 and up to 50 | above 50 |
| AL1 | above 0.5 and up to 0.75 | 0.5 or below |
| DDI | 150 x f to below 300 x f samples (f = acquisition frequency in Hz, so as many samples as 150 s to 300 s of data) | 300 x f samples or more |
| HF5 and HF10 | HF5 above 2 % of the samples of a 30-minute period, or HF10 above 0.5 % | HF5 above 4 %, or HF10 above 1 % |
| HD5 and HD10 | the same limits as HF5 and HF10 | the same limits as HF5 and HF10 |
| DIP (p-value) | 0.01 to 0.05 | below 0.01 |

The variables checked are u, v and w for momentum flux, the sonic temperature and w for sensible heat, and the gas and w for a gas flux. KID, AL1, DDI, HF, HD and DIP are evaluated on each of these variables. The percentage limits for HF and HD are fractions of the number of samples in 30 minutes at the acquisition frequency. For momentum flux, the DIP test is applied asymmetrically to u and v, as in the original procedure: the severe DIP test includes u and w but not v, and the moderate DIP test includes v and w but not u.

!!! warning

    AL1, DDI, HF, HD and DIP are available only if **Extra raw-signal diagnostics (RFlux)** (`test_rf`) is enabled. Without it, the system uses the ITC deviation, the Mahrt nonstationarity ratio and KID only. CCF is not used by this system.

!!! warning

    The wider test set is evaluated only on projects that do not hand quality flagging over to the flux computation and correction (FCC) step. This is the case when the project uses only the two built-in analytic spectral correction methods. For any other spectral correction method, which is the more common situation, FCC calculates the flags from the quantities in the intermediate results file, and the Vitale et al. (2020) flag then runs on the ITC deviation alone (the 30 % and 100 % limits above). Check the spectral correction method before relying on the additional tests.

**Differences from the original procedure.** The low-signal-resolution test and the physical-range filter of the original cleaning procedure are not part of this flag, and its wind-sector exclusion is not part of this flag. The checks of ITC for momentum flux use the deviation of w, not the larger of u* and w used by the other policies.
