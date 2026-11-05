# Low-pass filtering correction

See [High frequency spectral correction](selecting-advanced-options.md#high-frequency-spectral-correction) for more information.

Six low-pass filtering correction procedures are available in EddyFlow, implementing the [4 steps](calculate-spectral-correction-factors.md) in different ways. The methods are named after the corresponding reference publication. The method by [Moncrieff et al. (1997)](references.md#Moncrieff) is referred to as purely analytic, for it makes use of mathematical formulations to model flux spectral properties and to describe flux attenuations due to the instrument setup. The method by [Horst (1997)](references.md#horst1997) is analytic in nature, but it is parameterized using *in situ* information. The method by [Ibrom et al. (2007)](references.md#Ibrom), instead, is mostly based on *in situ* determinations. The method by [Eugster and Senn (1995)](references.md#Eugster1995) is analytic as well, but describes the damping of each gas measurement by a single time constant that you provide.

The methods are briefly described below. Please refer to the original papers for more in depth information.

## Spectral corrections after Eugster and Senn (1995)

[Eugster and Senn (1995)](references.md#Eugster1995) developed this correction for NO<sub>2</sub> fluxes measured with a chemiluminescence analyser behind a 5 m sampling tube. It relies only on the similarity of scalar cospectra, so it applies to any gas whose measurement is damped at high frequencies, and EddyFlow applies it to every gas.

The damping is described by analogy with an inductance *L* in an alternating-current circuit, which acts as a first-order low-pass filter. At natural frequency *f*, the cospectrum of the vertical wind with the measured gas concentration is damped by

$$
Co_{w,c_{meas}}(f) = \frac{1}{1+4\pi^2 f^2 L^2}\,Co_{w,c}(f)
$$

*L* is a time constant in seconds. It lumps together every source of damping of the gas signal: the flow in the sampling tube, any reaction or measurement cell, and the response of the analyser. The measurement height, wind speed and stability enter through the undamped cospectrum, a model after [Kaimal et al. (1972)](references.md#Kaimal) with coefficients adjusted by Eugster and Senn (their Eqs. 26-28).

Integrating the damped cospectrum gives the measurable fraction ξ of the flux, and the spectral correction factor is 1/ξ. Here *z* is the measurement height above the zero-plane displacement, \(\bar{u}\) the mean wind speed and ζ = *z*/*L*<sub>MO</sub> the stability parameter.

- Unstable and neutral stratification (ζ ≤ 0). The integral has no closed form, so Eugster and Senn fitted one to its numerical solution (Eq. 32):

    $$
    \xi = 0.725\,\arctan\left[1.24\,\ln\left(\frac{z}{\bar{u}L}+1\right)+0.21\right]
    $$

    The fit tends to 1.14 rather than 1 as *L* goes to zero, so EddyFlow caps ξ at 1.

- Stable stratification (0 < ζ ≤ 2). The integral is solved analytically after rounding one exponent of the cospectral model from 2.1 to 2 (Eq. 33):

    $$
    \xi = \frac{3}{\sqrt{6}}\,\frac{z}{\bar{u}}\,\frac{\sqrt{6}\,z/\bar{u}-4\pi L n_0}{3\,(z/\bar{u})^2-8\pi^2 L^2 n_0^2},
    \qquad n_0 = 0.23\,(1+6.4\,\zeta)^{3/4}
    $$

    The numerator and the denominator share the root \(z/\bar{u} = 4\pi L n_0/\sqrt{6}\), where the expression reads 0/0. EddyFlow evaluates the equivalent form with that factor cancelled, which is defined everywhere:

    $$
    \xi = \frac{z/\bar{u}}{z/\bar{u} + 4\pi L n_0/\sqrt{6}}
    $$

Both equations were fitted for −2 ≤ ζ ≤ 2. The unstable fit does not depend on ζ, so it is used for any ζ ≤ 0; above 2, ζ is held at 2. When **Iterate the correction** is selected, ζ is the one the iteration converges on.

For example, at \(z/\bar{u}\) = 1 s and *L* = 0.35 s the correction factor in unstable conditions is 1.274 (Eugster and Senn, Table III). For their LMA-3 analyser with a 6 mm, 5 m teflon tube, *L* was 0.30-0.35 s, and the correction factors ranged from 1.05 to 1.31.

**Discarded fluxes.** Eugster and Senn advise against using a flux of which less than 40 % was measurable. When ξ < 0.4 (a correction factor above 2.5), EddyFlow sets that gas's flux to the error value for that averaging period, and for the water vapor record also the evapotranspiration and latent heat flux. The correction factor itself is still reported, so the output shows why the flux is missing. The other gases are not affected: the discard is applied after every WPL term has used the water vapor flux.

**Periods without stability.** In a period without z/L, for example when the sensible heat flux is missing, no correction factor exists. The flux of an open-path gas is then written uncorrected, and only its spectral correction factor column shows the error code; the flux of a closed-path gas in the same period is written as missing. While this method is selected, the interface shows a warning icon with this explanation next to the method menu.

**The time constant *L*.** *L* is set separately for each gas, in the list that appears under the method menu when the method is selected (`gas_<i>_es_tau` in the project file). A gas left at **Analyser response time** uses the response time τ of its analyser from the metadata, which usually covers the analyser alone and not the tube. A value of 0 means no high-frequency damping. *L* is the time constant of the same first-order filter whose cut-off frequency *f*<sub>c</sub> an *in situ* spectral assessment fits (see [Ibrom et al. (2007)](#spectral-corrections-after-ibrom-et-al-2007)), so \(L = 1/(2\pi f_c)\) converts one into the other. Eugster and Senn determined *L* by fitting the damped model cospectrum to measured cospectra of the gas flux.

**Other fluxes and the low frequency range.** The method corrects gas fluxes only; momentum and sensible heat fluxes are corrected as with [Moncrieff et al. (1997)](#spectral-corrections-after-moncrieff-et-al-1997). When the high-pass filtering correction is selected, its factor is multiplied into each gas's correction factor, as for the other analytic methods.

The method is fully analytic: it needs no spectral assessment, runs in the first step of the engine, and can be applied to a dataset of any length. In the FLUXNET output, `SPECTRAL_CORRECTION_METHOD` is 7.

## Spectral corrections after Moncrieff et al. (1997)

In this method, true cospectra estimation (Step 1) is performed by using analytical cospectra formulations, again according to Eqs. 12-18 in Moncrieff et al. (1997). Step 2 is performed by specifying a low-pass transfer function (LPTF), which depends on the EC system characteristics. In the implemented method, the LPTF is specified by the superimposition of a set of transfer functions describing individual sources of high-frequency losses. Refer to Appendix A of Moncrieff et al. (1997) for the full description of the individual transfer functions. Such transfer functions depend on the instrument setup (through the instruments' path lengths, acquisition frequencies, separations etc.) but also on atmospheric conditions (because some quantities are defined as a function of the average wind speed), thus they must be recalculated for each flux averaging period.

In Step 3, flux attenuation in the high frequency end is estimated by applying the calculated LPTF to the estimated true flux cospectrum. Considering that the flux is given by the integration of the cospectrum over the whole frequency range, a low-pass spectral correction factor (LPSCF) can be calculated in Step 4 as:

$$
LPSCF = \frac{\int_0^{f_{\max}} CO_F(f)\,df}{\int_0^{f_{\max}} CO_F(f)\cdot LPTF(f)\,df} \tag{6-77}
$$

More accurately, when the method by Moncrieff et al. (1997) is selected for the low-pass filtering correction, a band-pass transfer function (BPTF) is calculated by multiplication of the HPTF and the LPTF. This BPTF is then applied to the analytic cospectra, to derive a Band Pass Spectral Correction (BPSCF) factor according to:

$$
BPSCF = \frac{\int_0^{f_{\max}} CO_F(f)\,df}{\int_0^{f_{\max}} CO_F(f)\cdot BPTF(f)\,df} \tag{6-78}
$$

The fractional flux loss ΔF/F is given by:

$$
\frac{\Delta F}{F_{true}} = \frac{F_{true}-F_{meas}}{F_{true}} = \frac{\int_0^{f_{\max}} CO_F(f)\,df-\int_0^{f_{\max}} CO_F(f)\cdot BPTF(f)\,df}{\int_0^{f_{\max}} CO_F(f)\,df} = 1-\frac{1}{SCF} \tag{6-79}
$$

where Ftrue is the "true" flux (not affected by spectral attenuations) and Fmeas is the measured, or uncorrected flux.

## Spectral corrections after Massman (2000, 2001)

The method described by [Massman (2000)](references.md#Massman2000) and refined in [Massman (2001)](references.md#Massman2001) is based on the work of [Moore (1986)](references.md#Moore1986) and [Horst (1997)](references.md#horst1997) and provides a simple correction formula based on the description of individual sources of flux losses as first-order filters and on the analytical formulation of cospectra by Horst (1997). The application of the method requires the calculation of the time constants associated to the first-order filters that describe the physical phenomenon, and whose analytical expression are detailed in Massman (2000, Table 1). The actual correction formulas are detailed in Massman (2001, Table 1), which refined Table 2 in the previous paper.

Note that the correction contains a modifier (last term in the second equation of Table 1 in Massman, 2001) for gas instruments with a time response of <0.3 seconds. The time response of the gas instruments is calculated on-the-fly by EddyFlow as part of the method, so the modifier is applied only if appropriate.

All parameters needed in the correction are available to or are calculated by EddyFlow, so there is no need of user's input to apply the method, with only one exception for closed-path gas analyzers: the "tube parameter" (Λ), that quantifies the attenuation of a gas in a tube flow and that is a function of the gas itself and of the tube Reynolds number. This parameter is calculated by EddyFlow via a linear interpolation of the values provided in [Massman (1991, Table 1)](references.md#Massman1991), starting from the actual Reynolds number calculated for the current sampling line (i.e., starting from the provided tube geometry and flow rate). Table 1 in Massman (1991) details the value of Λ for CO2, H2O, CH4, N2O and O3, so the correction can only be applied for those gases.

In summary Massman's correction is applicable to all open-path systems and to closed-path systems limited to measurements and fluxes of CO2, H2O, CH4, N2O and O3.

## Spectral corrections after Horst (1997)

This method is also based on an analytic formulation for the high frequency spectral losses and of the flux cospectra. However, here the integrals are solved analytically to derive a simple equation for the flux attenuation (Eq. 11 in Horst, 1997):

$$
LPSCF^{-1} = \frac{F_{meas}}{T_{true}} = \frac{1}{1+(2\pi\cdot n_m \tau_c \bar{u}/z)^a} \tag{6-80}
$$

where τc is the time constant of the filter implied by the EC system, α is a stability dependent constant, z is the measured height above the canopy, \(\bar{u}\) is the averaging wind speed at that height and nm is the (normalized) frequency at which the cospectrum attains its maximum (peak frequency), \(n=f\cdot z/\bar{u}\) . The time constant τc is linked to the transfer function cut-off frequency fc (the frequency at which the function reduces the power by a factor of 2) by the relation: \(2\pi\tau_c=1/f_c\) . The original paper provides parameterizations for α and nm, while the average wind speed is a standard result provided by EddyFlow. The time constant, however, is assessed in EddyFlow using the procedure described in the following section. In particular, for water vapor fluxes measured with closed path systems, the time constant is assessed as a function of relative humidity, as described hereafter.

## Spectral corrections after Ibrom et al. (2007)

This method is specifically suited for correcting water vapor fluxes measured with closed path systems, where relative humidity (RH) was recognized to play a non-negligible role in determining H2O signal attenuation and therefore flux underestimation, specifically in the high frequency range. However, with the proper adjustments made in EddyFlow, the method can also be used for passive gases insensitive to RH, such as CO2, CH4 and others, as well as for open path analyzers.

In the first step, assuming spectral similarity ([De Ligne et al., 2010](references.md#DeLigne2010); [Massman, 2000](references.md#Massman2000)), sonic temperature spectra (STs), considered as unaffected by spectral attenuations at high frequencies and after application of an opportune normalization, are used as a proxy for the unattenuated gas concentration spectra.

The estimation of system filtering characteristics (Step 2) is based on the *in situ* determination of the system cut-off frequency, assuming that the Eddy Covariance system acts on the true gas spectra (S) as a low-pass filter, in such a way that measured spectra (Sm) are attenuated at the high frequency end. Mathematically, this effect is described with a first-order recursive, infinite impulse response (IIR) filter. The discrete Fourier transform (HIIR) of the amplitude of such filter is well approximated by the Lorentzian:

$$
H_{IIR}(f|f_c) = \frac{S_m(f)}{S(f)} = \frac{1}{1+(f/f_c)^2} \tag{6-81}
$$

where f (Hz) is the natural frequency and fc (Hz) is the transfer function cut-off frequency. The latter is proportional to the inverse of the filter time constant (τc, s), \(f^{-1}_c=2\pi\tau_c\), and provides a quantification of amplitude attenuation of fluctuations. This filter shape was proven suitable for describing the filtering properties of EC systems featuring very long (50 m, [Hollinger et al., 1999](references.md#Hollinger1999); [Ibrom et al., 2007](references.md#Ibrom)) and long (7m, [Mammarella et al., 2009](references.md#Mammarella2009)) sampling lines.

!!! note

    Following Ibrom et al. (2007), cut-off frequencies are assessed by fitting the IIR function (with fc being the fitting parameter) to the ratio of ensemble gas spectra to ensemble temperature. EddyFlow uses all "high quality" spectra available in the dataset to calculate such ensemble spectra. The criteria for selecting high quality spectra described in [QA/QC of spectra and cospectra](ensemble-averages.md#top).

For H2O measured by closed path systems, in order to uncover the increasing attenuation as RH increases, cut-off frequencies must be determined for different RH regimes. As suggested by Ibrom et al., EddyFlow determines fc for nine classes in the range 5% < RH < 95% and fits an exponential function to the resulting RH/fc pairs:

$$
f_c(RH)=\exp(E_1\cdot RH^2+E_2\cdot RH+E_3) \tag{6-82}
$$

where E1, E2, and E3 are regression parameters.

For open path systems, where a dependency on RH is not expected, the procedure is applied in a slightly different way. By an algorithmic point of view, EddyFlow still calculates an fc for each RH class, but then it averages these values and analytically parameterizes the above equation by setting E1 and E2 to zero and E3 to the natural logarithm of the average fc. This way, the above relation between the cut-off frequency and RH can also safely be used also for open path systems, basically providing the same cut-off frequency for each RH.

For passive gases, instead, a unique cut-off frequency is assessed for the whole dataset, without consideration for RH, for neither open nor closed path systems.

Once cut-off frequencies have been assessed, the low-pass spectral correction factor (Step 4) is calculated using the parameterization:

$$
LFSCF = \frac{d_1 U}{d_2+f_c}+1 \tag{6-83}
$$

where U is the average wind speed and d1 and d2 are site-specific parameters to be determined using collected turbulence data. The actual procedure, which makes use of "degraded temperature time series," is described in detail in the original paper. EddyFlow fits one pair for unstable and one for stable conditions. Where the fit for the stability of an averaging period failed, no Ibrom correction factor exists for it, and the gas is corrected with the analytic method of [Moncrieff et al. (1997)](#spectral-corrections-after-moncrieff-et-al-1997) instead, as is any gas whose transfer function could not be assessed in situ. The same applies to a period in which a gas has no cut-off frequency, for example a hygrometer in a period without a relative humidity value to predict its cut-off frequency from, and it applies to the methods of [Horst (1997)](#spectral-corrections-after-horst-1997) and [Fratini et al. (2012)](#spectral-corrections-after-fratini-et-al-2012) as well. At the end of the run, the log lists every averaging period corrected analytically instead of in situ, one line per gas, with the reason (no cut-off frequency or failed fit) and the timestamps.

This spectral correction scheme only deals with flux attenuations induced by attenuation of the scalar spectra. Other sources of flux underestimation to be considered are intrinsic to the instrument deployment. Among them, relevant flux losses might come from the physical separation between the anemometer and the gas analyzer sampling volumes. While streamwise sensor displacement can be accounted for by compensating scalar time lags (assuming Taylor's hypothesis of frozen turbulence), we suggest applying a further correction factor to account for any crosswind and/or vertical displacement, following the procedure proposed by [Horst and Lenschow](references.md#horst1997) (2009, Eqs. 16–18 and 28–30): These are multiplicative factors, that are applied after fluxes have been partially corrected with the method proposed here. Find more details [here](#Correcti).

The method of Ibrom et al. (2007) is deemed applicable for a vast range of EC setups, spanning open-path to closed-path setups deployed in rough forest canopies. However, due to the need for a relatively large dataset for the assessment of spectral attenuations (Steps 1-3), we suggest using this method when at least 1-2 months of raw data are available from an EC setup that did not undergo major modifications, such as replacement of sampling line components or significant displacement of the sensors relative to each other.

## Spectral corrections after Fratini et al. (2012)

In this method, the first three steps are identical to those described [above](#spectral-corrections-after-ibrom-et-al-2007) for the method of [Ibrom et al. (2007)](references.md#Ibrom). The calculation of spectral correction factors (Step 4) is performed in different ways for "small" and "large" fluxes, where the threshold between small and large fluxes is set in the GUI (it is taken to be the "Minimum, unstable" values under **Spectral and cospectra QA/QC** in **Advanced Settings > Spectral analysis**).

For small fluxes the method of [Ibrom et al. (2007)](references.md#Ibrom) is applied, i.e., the low-pass correction factor is calculated using the model:

$$
LFSCF = \frac{d_1 U}{d_2+f_c}+1 \tag{6-84}
$$

However, refer to section 2.3 and Appendix A in [Fratini et al. (2012)](references.md#Fratini2012) for subtle differences in the parameterization of the model and how they improve it.

For large fluxes, refining and simplifying the approach described by [Hollinger et al. (1999)](references.md#Hollinger1999), low-pass spectral correction factors (LPSCF), for each flux averaging interval are calculated using the following equation:

$$
LPSCF = \frac{\int_{f_{\min}}^{f_{\max}} CO_H(f)\,df}{\int_{f_{\min}}^{f_{\max}} (f)\,H_{IIR(f|f_c)}\,df} \tag{6-85}
$$

where COH is the current sensible heat (H, W m-2) cospectrum. The value of the cut-off frequency in the denominator is calculated from:

$$
f_c(RH)=\exp(E_1 RH^2+E_2 RH+E_3) \tag{6-86}
$$

as in [Ibrom et al. (2007)](references.md#Ibrom), using the current value of RH.

The same model is used for every gas in an averaging period for which no full cospectrum of sensible heat is available (for example a gap in the full cospectra folder), since the direct method has nothing to work from. The momentum and sensible heat fluxes keep their own correction factors in such a period. A gas whose fit of the model failed for the period's stability, or whose transfer function could not be fitted at all, is corrected with the analytic method of [Moncrieff et al. (1997)](#spectral-corrections-after-moncrieff-et-al-1997) instead, as with [Ibrom et al. (2007)](#spectral-corrections-after-ibrom-et-al-2007).

Similar to the method of [Ibrom et al. (2007)](references.md#Ibrom), this method only corrects flux attenuations induced by attenuation of the scalar spectra. Potential further losses due to instrument separation can be corrected following the method of [Horst and Lenschow (2009)](references.md#horst2009) as described [elsewhere](#Correcti) (See [Correction for spectral losses due to physical instrument separation](#Correcti)

In addition, cospectra of sensible heat used in this method as a reference for gas flux cospectra, can be preliminary corrected for the (normally small) attenuations induced by the anemometer's limited response time and finite averaging volume, as well as for the high-pass filtering effects due to the finite flux averaging interval and dependent on the detrending method (See [High-pass filtering correction](high-pass-filtering.md#top)).

The method of [Fratini et al. (2012)](references.md#Fratini2012) is deemed applicable for a vast range of EC setups, from open-path systems over rough forests canopies to closed-path setups deployed close to smooth surfaces. However, due to the need for a relatively large dataset for the assessment of spectral attenuations (Steps 1-3), we suggest using this method when at least 1-2 months of raw data are available from an EC setup that did not undergo major modifications such as replacement of sampling line components, or significant displacement of the sensors relative to each other. In any case, we recommend using this method for correcting H2O and latent heat fluxes from closed path systems, specifically if deployed low over a relatively smooth surface, as if could be the case in agricultural or oceanic applications.

## Correction for spectral losses due to physical instrument separation

Being designed to correct spectral losses in closed-path systems (specifically for water vapor), the methods of [Ibrom et al. (2007)](references.md#Ibrom) and [Fratini et al. (2012)](references.md#Fratini2012) do not natively account for losses due to spatial separation of the instruments (anemometer and gas analyzer), because this source of spectral losses is minor and can be safely neglected when compared to losses in the sampling lines. For open-path systems, however, spectral losses due to instrument separations are relatively more important (especially for systems placed low over smooth surfaces). EddyFlow allows you to account for these losses by applying the correction method proposed by [Horst and Lenschow (2009)](references.md#horst2009), when the methods of [Ibrom et al. (2007)](references.md#Ibrom) and [Fratini et al. (2012)](references.md#Fratini2012) are selected. [Horst and Lenschow (2009)](references.md#horst2009) describe 3 correction terms to account for along-wind, crosswind and vertical separations. Note that losses for any along-wind separation are largely compensated by the procedure of time lag compensation, if this is applied.

Thus, the method is available in two versions:

- Along-wind, crosswind and vertical: suggested when the time lag compensation procedure is not applied.
- Only crosswind and vertical: suggested when the time lag compensation procedure is applied.

The correction procedure is based on the following formulation for the dependency of the flux (F(r)) as a function of the distance between the instruments (r), Eq. 13 in the original paper:

$$
F(r)=F_0\exp(-k_m r) \tag{6-87}
$$

where F0 is the unattenuated flux for r = 0, and km = 2πnm/z is the wavenumber at the peak of the wavenumber-weighted cospectrum, kCo(k), nm = fm z / U, fm is the frequency at the peak of the cospectrum, and U is the wind speed.

This formulation is then specified in the along-wind, crosswind, and vertical separations. Please refer to [Horst and Lenschow (2009)](references.md#horst2009) for further details.

!!! note

    When the methods of [Horst (1997)](references.md#horst1997) or [Ibrom et al. (2007)](references.md#Ibrom) are selected for the low-pass filtering correction, the "band-pass" spectral correction is applied by first correcting for the high-pass filtering effects (multiplication of uncorrected fluxes by HPSCF) and then multiplying by LPSCF. Rigorously speaking, this procedure is not correct because according to the definition of the band pass correction factor, the multiplication with the LPTF and the HPTF are not commutative with the integral operator. However, the error introduced by this procedure is deemed negligible in most occasions.

## Cospectral model for the analytic correction

Step 1 of every correction (the reference cospectrum, see [Calculating Spectral correction factors](calculate-spectral-correction-factors.md#top)) uses an analytic cospectrum. The project setting `cosp_model` (interface: **Cospectral model**, in *High frequency range*) selects which curve is used:

| Value | Label | Notes |
| --- | --- | --- |
| 0 | Moncrieff et al. (1997) - the default | Stable and unstable branches; the curve used by all earlier versions |
| 1 | Kaimal et al. (1972) | Kansas cospectrum, with its own stable and unstable branches |
| 2 | Sakai et al. (2001) - rough surfaces | single form, no stability dependence |
| 3 | Su et al. (2004) - forest, non-flat terrain | single form, no stability dependence |
| 4 | Moraes et al. (2008) | single form, no stability dependence |
| 5 | Kristensen et al. (1997) | single form, broad with a long low-frequency tail |

The model is a modifier of the method chosen, not a method of its own. It is used wherever a transfer function is integrated against a cospectrum: the methods of [Moncrieff et al. (1997)](references.md#Moncrieff), [Horst (1997)](references.md#horst1997), [Ibrom et al. (2007)](references.md#Ibrom) and [Fratini et al. (2012)](references.md#Fratini2012), and the case in which only the [high-pass correction](high-pass-filtering.md#top) is requested. The correction factor is a ratio of the integral of the cospectrum to the integral of the cospectrum multiplied by the transfer function, so only the *shape* of the curve matters and any constant multiplying it divides out. For this reason the normalisation constants of the published curves are not reproduced.

On the analytic test data set, the six models gave gas correction factors between 1.017 and 1.056, against 1.034 with the default: about four percent of the correction, or a few tenths of a percent of the flux. The effect is therefore small compared with the choice of method, but it is systematic for a given site.

The **Reynolds stress** always keeps the momentum cospectrum of Moncrieff et al. (1997). Models 2 to 5 are scalar cospectra with no momentum form, and combining a scalar model with an unrelated momentum curve for some options and not others would be worse than not offering the choice; on the test data set the stress correction was identical for all six.

Models 2 to 5 have no dependence on stability, so they are applied unchanged at every z/L. In stable stratification the cospectral peak moves toward higher frequency; a neutral-form curve then puts too little flux at high frequency and **understates** the high-frequency loss. Use the stability-dependent curves (0 or 1) for sites with frequent stable conditions. The cospectral model has no influence where the correction comes from measured cospectra instead of a model.

## Iterating the correction

Three quantities depend on each other: the analytic cospectrum is evaluated at the stability parameter z/L; z/L is computed from the corrected sensible heat flux; and the corrected flux is what the spectral correction produces. In a single pass, the correction is computed at the stability of the uncorrected flux, which the run then goes on to revise.

With **Iterate the correction** (`corr_iter_meth`) the correction and the flux levels are recomputed, using at each pass the z/L produced by the previous pass, until the loop ends. Each pass starts from the same raw covariances, so **nothing compounds**: what changes between passes is only the z/L at which the cospectrum is evaluated. Likewise, each pass recomputes u* from the uncorrected (Level 0) u* with that pass's correction factor, so u*, the Obukhov length, z/L, the footprint and the turbulence test carry the factor of one pass, not the product of all of them. The oxygen correction of krypton and Lyman-α hygrometers is applied once per averaging period, before the passes. The loop ends after `corr_iter_max` passes (default 4), or earlier when the largest change of any gas flux between two passes is below `corr_iter_tol` percent (default 0, which means that all passes are run). The output column `corr_iter_dev` reports that largest change, in percent, between the last two passes, for the worst gas of the period. It is written only when the loop runs.

The effect is largest in strongly non-neutral conditions. On a 48-period forest test the loop changed fluxes by hundredths of a percent (latent heat +0.023 %, N2O +0.038 %, COS -0.022 %, sensible heat practically none), with a median `corr_iter_dev` of 0 % and a worst period of 0.35 %. A 1 % tolerance stopped at the second pass and came within 0.02 % of four passes. With the option off, results are bit-identical to earlier versions.

## In situ assessment at more than one acquisition rate

The in situ methods of Horst (1997), Ibrom et al. (2007) and Fratini et al. (2012) depend on a spectral assessment: ensemble spectra, a high-frequency noise floor, a transfer-function fit and a check of the fitted cut-off against the Nyquist frequency. All of these depend on the acquisition rate. If the rate of a gas is not constant over the assessment period (the file rate changes, or the analyser's own rate changes while the file rate does not) the assessment is carried out separately for each rate of that gas, each time only up to that rate's Nyquist frequency, and each period is corrected with the result for its own rate. The Ibrom et al. (2007) correction-factor model, derived from w'T', is fitted for each file rate. A rate without a usable result takes the next faster usable rate of the same gas (and, failing that, a slower one, and failing that the analytic method), and a gas never takes another gas's result. See [Mixed acquisition rates](mixed-acquisition-rates.md#spectral-assessment-per-acquisition-rate).

## Cut-off frequency and the Nyquist check

A fitted cut-off frequency is accepted only if its **magnitude** is below the Nyquist frequency of the gas it belongs to (half of its effective acquisition rate); above it the data could not have shown the attenuation. This applies to every gas and to the relative-humidity fit of water vapour. The magnitude is tested because the IIR model contains the cut-off only squared, so the fit may land on either sign; a gas with no attenuation it can resolve used to give a cut-off of about -250 Hz, which was accepted and acted as an in situ correction of about 1. A gas that fails the check is corrected with the analytic method (as is any other unfitted gas), which changes results in single-rate projects wherever this happened. See [Mixed acquisition rates](mixed-acquisition-rates.md#cut-off-frequency-versus-each-gass-own-nyquist-frequency).

For the method of Fratini et al. (2012), each period's full cospectrum is sized from its own full-cospectra file; before engine version 8.1.1 it was sized from the first file of the run, which gave wrong integrals for shorter or longer periods.
