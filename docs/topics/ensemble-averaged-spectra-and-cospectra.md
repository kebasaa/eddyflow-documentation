---
title: "Ensemble Averaged Spectra and Cospectra"
source_url: "https://www.licor.com/support/EddyPro/topics/ensemble-averaged-spectra-and-cospectra.html"
---
# Ensemble averaged spectra and cospectra

EddyFlow can calculate averaged spectra and cospectra. However, because these quantities serve different purposes, the procedures for getting spectra and cospectra are different; also, these quantities are screened, sorted and averaged in different ways. So, let's have a look at what EddyFlow does, why it does so, and what is available to you after the run.

## Ensemble averaged spectra of passive scalars

Ensemble averaged spectra of CO2, CH4 and a 4th passive gas are created when the corresponding raw data are available and if the spectral correction method of [Horst (1997)](references.md#horst1997) or [Ibrom et al. (2007a)](references.md#Ibrom) was selected. Those correction methods are based on an in-situ determination of the EC system transfer function, which in EddyFlow is performed as described in Ibrom et al. (2007), evaluating the underestimation of gas concentration variance via a comparison of the average spectrum of the gas under consideration, to that of (sonic) temperature, taken as a reference. The procedure involves the selection of "high-quality" spectra for both gases and temperature, performed on the basis of:

- The value of concerned fluxes
- The value of skewness and kurtosis of the concerned time series
- Exclusion based on outranged spectral values

For this procedure, EddyFlow uses binned spectra. This is the reason why, when one of these spectral correction methods is selected, the option "All binned spectra and cospectra" in the Output Files page is checked and deactivated: those methods requires those outputs. Once spectra have been selected as just described, they are averaged to get the results stored in the output file containing the identifier ` passive_gases_ensemble_spectra ` in its name. Refer to the output file descriptions for more details on the content of this output file.

## Ensemble averaged spectra of water vapor

Water vapor requires a different treatment with respect to passive gases, because in closed-path systems its attenuation is strongly dependent on relative humidity (and secondarily on temperature); for this reason, in addition to the screening procedure described above for passive gases, EddyFlow sorts water vapor spectra into a user-defined number of relative humidity classes, to assess attenuation of H2O variance as a function of RH. Thus, you find ensemble averaged water vapor spectra in a separate output, identified by ` h2o_ensemble_spectra ` in the file name. Refer to the output file descriptions for more details on the content of this output file.

## Ensemble averaged cospectra sorted by time of the day

Although not directly used for any calculation, EddyFlow also calculates ensemble averaged cospectra of main fluxes (i.e., based on time series of w and gas concentrations/densities or temperature). In the output file identified by "ensemble_cospectra_by_time", all available binned cospectra are sorted in 3-hour groups (from 00:00 to 03:00, from 03:00 to 06:00 and so on) so as to provide a "daily course" of average cospectral shapes. Before being considered for ensemble averaging, cospectra are screened for quality according to the following "soft" criteria:

- Sensible heat flux is greater than 5 W m-2 (for all fluxes)
- Latent heat flux is greater than 3 W m-2 (for H2O);
- Absolute value of CO2 flux is greater than 2 μmol m-2 s-1 (for CO2);
- Absolute value of CH4 flux is greater than 10-3 μmol m-2 s-1 (for CH4);

** Note:** These cospectra are presented as function of the natural frequency, extending in the range defined by the inverse of the flux averaging interval to half the data acquisition sampling frequency.

## Ensemble averaged cospectra sorted by stability regime

EddyFlow sorts and averages cospectra according to the atmospheric stability regime, defined by the value of the Monin-Obukhov length (L). Ensemble averaged cospectra are provided for unstable (-650 < L < 0) and stable (0 < L < 1000) stratifications. Before being considered for ensemble averaging, cospectra are screened for quality. Cospectra corresponding to stable stratifications are filtered using the same "soft" criteria described above, while cospectra corresponding to unstable stratifications are filtered using the flux thresholds entered by the user in the spectral correction configuration page (default values are used if the spectral correction page is not configured; default values are visible in the interface). In addition, EddyFlow fits Massman's model to the ensemble of individual cospectra.

6‑27
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation960.svg)

where n (Hz) is the natural frequency, f = (z-d)* n/U is the normalized frequency and A0, fp and μ are regression parameters. To perform this step, individual cospectra are expressed as a function of the normalized frequency. The overall normalized frequency range is defined *a priori* in EddyFlow and extends from 1/4 Hz up to 200 Hz. This is a wide range, which implies that often empty frequency bins are found in the output file, corresponding to normalized frequency ranges where no actual cospectral values were found. Finally, in the same output file, identified by the string ` ensemble_cospectra_by_stability ` in the name, "ideal" Kaimal cospectra are also found. For the stable regime, this is only a function of the normalized frequency. However, for the stable range, ideal cospectra are also a function of z/L. Thus EddyFlow outputs Kaimal cospectra corresponding to two extremely stable conditions, namely z/L = 0.01 (near neutral stratification) and z/L = 10 (strongly stable stratification).
