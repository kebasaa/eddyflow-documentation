# QA/QC of spectra and cospectra

Ensemble averaged spectra and cospectra are calculated by EddyFlow, used in some implementations (e.g., spectral corrections) and, if requested, are provided as an output for user analysis. To calculate ensemble averages, EddyFlow uses "individual" spectra and cospectra calculated from all available raw time series. However, a quality screening is applied to these individual (co)spectra to determine if they should enter into the calculation of the ensemble average. In fact, (co)spectra quality may be poor in several respects:

- Overall (co)spectral shape may depart too much from expectation in case of very low signal (co)variance (e.g. instrument noise may be overly dominating), or in case of spikes in the underlying time series.
- (Co)spectra may present spikes or other anomalies due to problems occurring in the underlying time series (for example, discontinuities, dropouts, etc.)

To avoid bad (co)spectra to contaminating ensemble averages, EddyFlow disregards (co)spectra according to the following rules, that can be customized in the Spectra and Cospectra QA/QC section of the Spectral Analysis and Correction page:

- (Co)spectra corresponding to too-low fluxes are ignored. Minimum fluxes can be set in EddyFlow's GUI and can be specified differently for stable and unstable stratifications. Note that the stable/unstable distinction applies primarily to the calculation of stability sorted ensemble averaged cospectra. For selecting spectra in general, EddyFlow uses the thresholds set for the unstable case, while for selecting cospectra for time-sorted ensemble averages EddyFlow uses the thresholds set for the stable case. The rationale here is that minimum fluxes set for the unstable case should be larger and provide a higher quality selection: this stricter selection is necessary for the assessment of the low-pass filtering effect, which is done using ensemble spectra. On the contrary, for time-sorted cospectra EddyFlow uses the milder filtering provided by the stable thresholds because, using "unstable" thresholds, obtaining ensemble spectra during night-time would be virtually impossible. Note that thresholds are intended as absolute values. In addition, the GUI also allows entering "Maximum" fluxes. This option is provided to allow you to discard (co)spectra related to periods that, for any reason, lead to flux 'spikes'. For example, in a forest ecosystem one may want to discard (co)spectra of CO2, if CO2 flux attains a value of, say, -500 μmol m-2 s-1.
- If instructed through the checkbox "Filter (co)spectra according to Vickers and Mahrt (1997) test results", EddyFlow will disregard (co)spectra for which the corresponding time series were flagged by the Vickers and Mahrt tests. Note however, that only the following four tests are taken into account to this purpose: (1) number of spikes; (2) drop-outs; (3) skewness & kurtosis; and (4) discontinuities. This is because the problems highlighted by these tests are more likely to create artifacts in (co)spectral shapes.
- If instructed, EddyFlow will disregard (co)spectra for which the corresponding time series were flagged for 'low quality'—and optionally also those flagged for 'moderate quality' — by the Foken's micrometeorological tests. The selection of 'low quality' or 'low and moderate quality' is done via the dedicated checkboxes. The interdependence between (co)spectra and fluxes/flag results is described in the following table:

| If.. | ..is.. | ..EddyFlow disregards.. |
| --- | --- | --- |
| u* | Below threshold | All spectra and cospectra |
| H | below threshold | All spectra and cospectra |
| LE | below threshold | H2O spectrum and H2O/w cospectrum |
| CO2 flux | below threshold | CO2 spectrum and CO2/w cospectrum |
| CH4 flux | below threshold | CH4 spectrum and CH4/w cospectrum |
| 4th gas flux | below threshold | 4th gas spectrum and 4th gas/w cospectrum |
| W | flagged by V&M | w spectrum, all cospectra |
| U | flagged by V&M | u spectrum, u/w cospectrum |
| V | flagged by V&M | v spectrum, v/w cospectrum |
| Ts | flagged by V&M | Ts spectrum, Ts/w cospectrum |
| CO2 | flagged by V&M | CO2 spectrum, CO2/w cospectrum |
| H2O | flagged by V&M | H2O spectrum, H2O/w cospectrum |
| CH4 | flagged by V&M | CH4 spectrum, CH4/w cospectrum |
| 4th gas | flagged by V&M | 4th gas spectrum,4th gas/w cospectrum |
| Tau | flagged by Foken | All spectra and cospectra |
| H | flagged by Foken | All spectra and cospectra |
| CO2 flux | flagged by Foken | CO2 spectrum and CO2/w cospectrum |
| H2O flux | flagged by Foken | H2O spectrum and H2O/w cospectrum |
| CH4 flux | flagged by Foken | CH4 spectrum and CH4/w cospectrum |
| 4th gas flux | flagged by Foken | 4th gas spectrum and 4th gas/w cospectrum |

In addition to these explicit and customizable quality criteria, there is another set of (co)spectra selection criteria that are hard-coded in EddyFlow and not exposed to customization. These are as follows:

- If a binned (co)spectrum, normalized by the corresponding (co)variance and multiplied by natural frequency, attains at least one value larger than 10, the whole (co)spectrum is disregarded. Note that, in strict theoretical terms, such (co)spectra normalized this way shall not attain any value larger than 1. However, in order to accommodate potential numerical imprecisions, a more generous value of 10 is used here.
- If a binned (co)spectrum, normalized by the corresponding (co)variance but not normalized with respect to frequency, attains at least one value larger than 104, the whole (co)spectrum is disregarded.
- Gas binned spectra (but not cospectra) are disregarded if, for the same period, sonic (or fast) temperature spectrum is disregarded. This is done because sonic/fast temperature spectra and gas spectra are used to assess spectral attenuations by means of calculating an experimental transfer function given by the ratio of gas to temperature spectra. Due to specificities of the method, it is necessary to keep gas and temperature spectra in synch.
