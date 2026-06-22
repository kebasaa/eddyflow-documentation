# Low-pass filtering correction

See [High frequency spectral correction](selecting-advanced-options.md#High) for more information.

Three low-pass filtering correction procedures are available in EddyFlow, implementing the [4 steps](calculate-spectral-correction-factors.md) in different ways. The methods are named after the corresponding reference publication. The method by [Moncrieff et al. (1997)](references.md#Moncrieff2) is referred to as purely analytic, for it makes use of mathematical formulations to model flux spectral properties and to describe flux attenuations due to the instrument setup. The method by [Horst (1997)](references.md#horst1997) is analytic in nature, but it is parameterized using *in situ* information. The method by [Ibrom et al. (2007)](references.md#Ibrom), instead, is mostly based on *in situ* determinations.

The three methods are briefly described below. Please refer to the original papers for more in depth information.

## Spectral corrections after Moncrieff et al. (1997)

In this method, true cospectra estimation (Step 1) is performed by using analytical cospectra formulations, again according to Eqs. 12-18 in Moncrieff et al. (1997). Step 2 is performed by specifying a low-pass transfer function (LPTF), which depends on the EC system characteristics. In the implemented method, the LPTF is specified by the superimposition of a set of transfer functions describing individual sources of high-frequency losses. Refer to Appendix A of Moncrieff et al. (1997) for the full description of the individual transfer functions. Such transfer functions depend on the instrument setup (through the instruments' path lengths, acquisition frequencies, separations etc.) but also on atmospheric conditions (because some quantities are defined as a function of the average wind speed), thus they must be recalculated for each flux averaging period.

In Step 3, flux attenuation in the high frequency end is estimated by applying the calculated LPTF to the estimated true flux cospectrum. Considering that the flux is given by the integration of the cospectrum over the whole frequency range, a low-pass spectral correction factor (LPSCF) can be calculated in Step 4 as:

6‑77
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1013.svg)

More accurately, when the method by Moncrieff et al. (1997) is selected for the low-pass filtering correction, a band-pass transfer function (BPTF) is calculated by multiplication of the HPTF and the LPTF. This BPTF is then applied to the analytic cospectra, to derive a Band Pass Spectral Correction (BPSCF) factor according to:

6‑78
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1014.svg)

The fractional flux loss ΔF/F is given by:

6‑79
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1015.svg)

where Ftrue is the "true" flux (not affected by spectral attenuations) and Fmeas is the measured, or uncorrected flux.

## Spectral corrections after Massman (2000, 2001)

The method described by [Massman (2000)](references.md#Massman2000) and refined in [Massman (2001)](references.md#Massman2001) is based on the work of [Moore (1986)](references.md#Moore1986) and [Horst (1997)](references.md#horst1997) and provides a simple correction formula based on the description of individual sources of flux losses as first-order filters and on the analytical formulation of cospectra by Horst (1997). The application of the method requires the calculation of the time constants associated to the first-order filters that describe the physical phenomenon, and whose analytical expression are detailed in Massman (2000, Table 1). The actual correction formulas are detailed in Massman (2001, Table 1), which refined Table 2 in the previous paper.

Note that the correction contains a modifier (last term in the second equation of Table 1 in Massman, 2001) for gas instruments with a time response of <0.3 seconds. The time response of the gas instruments is calculated on-the-fly by EddyFlow as part of the method, so the modifier is applied only if appropriate.

All parameters needed in the correction are available to or are calculated by EddyFlow, so there is no need of user's input to apply the method, with only one exception for closed-path gas analyzers: the "tube parameter" (Λ), that quantifies the attenuation of a gas in a tube flow and that is a function of the gas itself and of the tube Reynolds number. This parameter is calculated by EddyFlow via a linear interpolation of the values provided in [Massman (1991, Table 1)](references.md#Massman1991), starting from the actual Reynolds number calculated for the current sampling line (i.e., starting from the provided tube geometry and flow rate). Table 1 in Massman (1991) details the value of Λ for CO2, H2O, CH4, N2O and O3, so the correction can only be applied for those gases.

In summary Massman's correction is applicable to all open-path systems and to closed-path systems limited to measurements and fluxes of CO2, H2O, CH4, N2O and O3.

## Spectral corrections after Horst (1997)

This method is also based on an analytic formulation for the high frequency spectral losses and of the flux cospectra. However, here the integrals are solved analytically to derive a simple equation for the flux attenuation (Eq. 11 in Horst, 1997):

6‑80
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1016.svg)

where τc is the time constant of the filter implied by the EC system, α is a stability dependent constant, z is the measured height above the canopy, ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1017.svg) is the averaging wind speed at that height and nm is the (normalized) frequency at which the cospectrum attains its maximum (peak frequency), ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1018.svg) . The time constant τc is linked to the transfer function cut-off frequency fc (the frequency at which the function reduces the power by a factor of 2) by the relation: ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1019.svg) . The original paper provides parameterizations for α and nm, while the average wind speed is a standard result provided by EddyFlow. The time constant, however, is assessed in EddyFlow using the procedure described in the following section. In particular, for water vapor fluxes measured with closed path systems, the time constant is assessed as a function of relative humidity, as described hereafter.

## Spectral corrections after Ibrom et al. (2007)

This method is specifically suited for correcting water vapor fluxes measured with closed path systems, where relative humidity (RH) was recognized to play a non-negligible role in determining H2O signal attenuation and therefore flux underestimation, specifically in the high frequency range. However, with the proper adjustments made in EddyFlow, the method can also be used for passive gases insensitive to RH, such as CO2, CH4 and others, as well as for open path analyzers.

In the first step, assuming spectral similarity ([De Ligne et al., 2010](references.md#DeLigne2010); [Massman, 2000](references.md#Massman2000)), sonic temperature spectra (STs), considered as unaffected by spectral attenuations at high frequencies and after application of an opportune normalization, are used as a proxy for the unattenuated gas concentration spectra.

The estimation of system filtering characteristics (Step 2) is based on the *in situ* determination of the system cut-off frequency, assuming that the Eddy Covariance system acts on the true gas spectra (S) as a low-pass filter, in such a way that measured spectra (Sm) are attenuated at the high frequency end. Mathematically, this effect is described with a first-order recursive, infinite impulse response (IIR) filter. The discrete Fourier transform (HIIR) of the amplitude of such filter is well approximated by the Lorentzian:

6‑81
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1020.svg)

where f (Hz) is the natural frequency and fc (Hz) is the transfer function cut-off frequency. The latter is proportional to the inverse of the filter time constant (τc, s), ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1021.svg), and provides a quantification of amplitude attenuation of fluctuations. This filter shape was proven suitable for describing the filtering properties of EC systems featuring very long (50 m, [Hollinger et al., 1999](references.md#Hollinger1999); [Ibrom et al., 2007](references.md#Ibrom)) and long (7m, [Mammarella et al., 2009](references.md#Mammarella2009)) sampling lines.

** Note:** Following Ibrom et al. (2007), cut-off frequencies are assessed by fitting the IIR function (with fc being the fitting parameter) to the ratio of ensemble gas spectra to ensemble temperature. EddyFlow uses all "high quality" spectra available in the dataset to calculate such ensemble spectra. The criteria for selecting high quality spectra described in [QA/QC of spectra and cospectra](ensemble-averages.md#top).

For H2O measured by closed path systems, in order to uncover the increasing attenuation as RH increases, cut-off frequencies must be determined for different RH regimes. As suggested by Ibrom et al., EddyFlow determines fc for nine classes in the range 5% < RH < 95% and fits an exponential function to the resulting RH/fc pairs:

6‑82
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1022.svg)

where E1, E2, and E3 are regression parameters.

For open path systems, where a dependency on RH is not expected, the procedure is applied in a slightly different way. By an algorithmic point of view, EddyFlow still calculates an fc for each RH class, but then it averages these values and analytically parameterizes the above equation by setting E1 and E2 to zero and E3 to the natural logarithm of the average fc. This way, the above relation between the cut-off frequency and RH can also safely be used also for open path systems, basically providing the same cut-off frequency for each RH.

For passive gases, instead, a unique cut-off frequency is assessed for the whole dataset, without consideration for RH, for neither open nor closed path systems.

Once cut-off frequencies have been assessed, the low-pass spectral correction factor (Step 4) is calculated using the parameterization:

6‑83
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1023.svg)

where U is the average wind speed and d1 and d2 are site-specific parameters to be determined using collected turbulence data. The actual procedure, which makes use of "degraded temperature time series," is described in detail in the original paper.

This spectral correction scheme only deals with flux attenuations induced by attenuation of the scalar spectra. Other sources of flux underestimation to be considered are intrinsic to the instrument deployment. Among them, relevant flux losses might come from the physical separation between the anemometer and the gas analyzer sampling volumes. While streamwise sensor displacement can be accounted for by compensating scalar time lags (assuming Taylor's hypothesis of frozen turbulence), we suggest applying a further correction factor to account for any crosswind and/or vertical displacement, following the procedure proposed by [Horst and Lenschow](references.md#horst1997) (2009, Eqs. 16–18 and 28–30): These are multiplicative factors, that are applied after fluxes have been partially corrected with the method proposed here. Find more details [here](#Correcti).

The method of Ibrom et al. (2007) is deemed applicable for a vast range of EC setups, spanning open-path to closed-path setups deployed in rough forest canopies. However, due to the need for a relatively large dataset for the assessment of spectral attenuations (Steps 1-3), we suggest using this method when at least 1-2 months of raw data are available from an EC setup that did not undergo major modifications, such as replacement of sampling line components or significant displacement of the sensors relative to each other.

## Spectral corrections after Fratini et al. (2012)

In this method, the first three steps are identical to those described [here](#) for the method of [Ibrom et al. (2007)](references.md#Ibrom). The calculation of spectral correction factors (Step 4) is performed in different ways for "small" and "large" fluxes, where the threshold between small and large fluxes is set in the GUI (it is taken to be the "Minimum, unstable" values under ** Spectral and cospectra QA/QC** in ** Advanced Settings > Spectral analysis **).

For small fluxes the method of [Ibrom et al. (2007)](references.md#Ibrom) is applied, i.e., the low-pass correction factor is calculated using the model:

6‑84
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1024.svg)

However, refer to section 2.3 and Appendix A in [Fratini et al. (2012)](references.md#Fratini2012) for subtle differences in the parameterization of the model and how they improve it.

For large fluxes, refining and simplifying the approach described by [Hollinger et al. (1999)](references.md#Hollinger1999), low-pass spectral correction factors (LPSCF), for each flux averaging interval are calculated using the following equation:

6‑85
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1025.svg)

where COH is the current sensible heat (H, W m-2) cospectrum. The value of the cut-off frequency in the denominator is calculated from:

6‑86
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1026.svg)

as in [Ibrom et al. (2007)](references.md#Ibrom), using the current value of RH.

Similar to the method of [Ibrom et al. (2007)](references.md#Ibrom), this method only corrects flux attenuations induced by attenuation of the scalar spectra. Potential further losses due to instrument separation can be corrected following the method of [Horst and Lenschow (2009)](references.md#horst2009) as described [elsewhere](#Correcti) (See [Correction for spectral losses due to physical instrument separation](#Correcti)

In addition, cospectra of sensible heat used in this method as a reference for gas flux cospectra, can be preliminary corrected for the (normally small) attenuations induced by the anemometer's limited response time and finite averaging volume, as well as for the high-pass filtering effects due to the finite flux averaging interval and dependent on the detrending method (See [High-pass filtering correction](high-pass-filtering.md#top)).

The method of [Fratini et al. (2012)](references.md#Fratini2012) is deemed applicable for a vast range of EC setups, from open-path systems over rough forests canopies to closed-path setups deployed close to smooth surfaces. However, due to the need for a relatively large dataset for the assessment of spectral attenuations (Steps 1-3), we suggest using this method when at least 1-2 months of raw data are available from an EC setup that did not undergo major modifications such as replacement of sampling line components, or significant displacement of the sensors relative to each other. In any case, we recommend using this method for correcting H2O and latent heat fluxes from closed path systems, specifically if deployed low over a relatively smooth surface, as if could be the case in agricultural or oceanic applications.

## Correction for spectral losses due to physical instrument separation

Being designed to correct spectral losses in closed-path systems (specifically for water vapor), the methods of [Ibrom et al. (2007)](references.md#Ibrom) and [Fratini et al. (2012)](references.md#Fratini2012) do not natively account for losses due to spatial separation of the instruments (anemometer and gas analyzer), because this source of spectral losses is minor and can be safely neglected when compared to losses in the sampling lines. For open-path systems, however, spectral losses due to instrument separations are relatively more important (especially for systems placed low over smooth surfaces). EddyFlow allows you to account for these losses by applying the correction method proposed by [Horst and Lenschow (2009)](references.md#horst2009), when the methods of [Ibrom et al. (2007)](references.md#Ibrom) and [Fratini et al. (2012)](references.md#Fratini2012) are selected. [Horst and Lenschow (2009)](references.md#horst2009) describe 3 correction terms to account for along-wind, crosswind and vertical separations. Note that losses for any along-wind separation are largely compensated by the procedure of time lag compensation, if this is applied.

Thus, the method is available in two versions:

- Along-wind, crosswind and vertical: suggested when the time lag compensation procedure is not applied.
- Only crosswind and vertical: suggested when the time lag compensation procedure is applied.

The correction procedure is based on the following formulation for the dependency of the flux (F(r)) as a function of the distance between the instruments (r), Eq. 13 in the original paper:

6‑87
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1027.svg)

where F0 is the unattenuated flux for r = 0, and km = 2Ï€nm/z is the wavenumber at the peak of the wavenumber-weighted cospectrum, kCo(k), nm = fm z / U, fm is the frequency at the peak of the cospectrum, and U is the wind speed.

This formulation is then specified in the along-wind, crosswind, and vertical separations. Please refer to [Horst and Lenschow (2009)](references.md#horst2009) for further details.

** Note:** When the methods of [Horst (1997)](references.md#horst1997) or [Ibrom et al. (2007)](references.md#horst1997) are selected for the low-pass filtering correction, the "band-pass" spectral correction is applied by first correcting for the high-pass filtering effects (multiplication of uncorrected fluxes by HPSCF) and then multiplying by LPSCF. Rigorously speaking, this procedure is not correct because according to the definition of the band pass correction factor, the multiplication with the LPTF and the HPTF are not commutative with the integral operator. However, the error introduced by this procedure is deemed negligible in most occasions.
