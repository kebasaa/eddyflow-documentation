# High-pass filtering correction

See [Low frequency spectral correction](selecting-advanced-options.md#Low) for more information.

In EddyFlow, high-pass filtering correction is applied (if requested) following [Moncrieff et al. (2004)](references.md#Moncrieff). True flux cospectra estimation (Step 1) is performed by using analytical cospectra formulations, according to Eqs. 12-18 in [Moncrieff et al. (1997)](references.md#Moncrieff2), a modification of the Kaimal formulation ([Kaimal, 1972](references.md#Kaimal)). Cospectra are expressed as a function of the natural frequency COf(f), and depending primarily of the considered flux (momentum, sensible heat or gas flux), on atmospheric stratification, wind speed and the measurement height over the canopy. For this reason, cospectra must be recalculated for each averaging period.

In Step 2, an analytical formulation is used of the transfer function that describes the effect of the high-pass filtering procedure (HPTF, high-pass transfer function). The shape of the HPTF is a function of the selected detrending method (block averaging, linear detrending, running mean or exponential running mean), and the corresponding time constant. HPTF formulations are summarized in Table 2.2 of Moncrieff et al. (2004).

In Step 3, flux attenuation in the low frequency end is estimated by "applying" the calculated HPTF to the modeled flux cospectrum. When it is done in the frequency domain, "applying" simply means a frequency-wise multiplication. Considering that a flux is proportional to the integral of the corresponding cospectrum over the whole frequency range, a high-pass spectral correction factor (HPSCF) can be calculated in Step 4 as:

6‑76
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1012.svg)

where fmax is the highest frequency, corresponding to the smallest eddies contributing to the true flux.
