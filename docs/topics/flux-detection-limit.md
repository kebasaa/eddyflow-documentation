# Flux detection limit

EddyFlow can estimate, for each flux averaging period, a *detection limit*: the smallest flux magnitude that can be distinguished from the analytical and measurement noise inherent to the instrumentation, given the averaging period used. Fluxes with an absolute value below the detection limit cannot be reliably distinguished from zero and should be interpreted with caution, even if their computed random uncertainty is otherwise acceptable.

The detection limit is calculated following the method described by [Wienhold et al. (1994)](references.md#Wienhold1994).

## Detection limit vs. random uncertainty

The detection limit is conceptually related to, but distinct from, the [random uncertainty estimation](random-uncertainty-estimation.md) methods (Mann and Lenschow, 1994; Finkelstein and Sims, 2001; Billesbach, 2011; Lenschow et al., 2000) also available in EddyFlow:

- **Random uncertainty** starts from a computed, non-zero flux value and asks: how much sampling error is associated with this particular estimate, given the turbulence statistics of the averaging period? It is expressed as an absolute uncertainty on the flux itself, and it scales with the actual variability of the vertical wind and scalar time series during that period.
- **Detection limit** instead asks a prior question, independent of what flux was actually computed: given the analytical/measurement noise of the instrument and the length of the averaging period, how small could a flux be and still be resolvable at all? It follows from the noise characteristics of the raw high-frequency signal (e.g. gas analyzer electronic and analytical noise) rather than from the correlation structure of a specific computed flux.

In practice, this means a flux can have a small random uncertainty (i.e. it appears to be a precise estimate) while still falling below the detection limit, if the underlying signal is dominated by instrument noise rather than by a real correlated flux signal. The two diagnostics therefore address different questions and are best used together: random uncertainty characterizes the precision of a given non-zero flux estimate, while the detection limit characterizes the noise floor below which any flux, regardless of its computed value, cannot be considered meaningfully different from zero.

## Method

**Exact UI label:** Wienhold et al. (1994), in the **Method** selector of the Flux Detection Limit dialog. Project-file keys: `detlim_meth` (0 = None, 1 = Wienhold et al. (1994)), `detlim_offset_s` (default 100 s) and `detlim_window_s` (default 50 s).

The cross-covariance of the vertical wind with a scalar carries the flux in a peak near the transport lag and nothing but noise far away from it. The method of [Wienhold et al. (1994)](references.md#Wienhold1994) therefore takes the scatter of the cross-covariance function away from the peak as a noise floor on the covariance: a flux smaller than it cannot be distinguished from zero.

Procedure, for each period and each gas:

1. Take the lag that was actually used for the gas, whichever time-lag method chose it (it may be zero if no lag is compensated, or negative for an open-path analyser).
2. Place two windows of lags, one before and one after that lag, each centred at a distance equal to the **Window offset** from it (100 s by default) and each **Window width** wide (50 s by default).
3. In each window, calculate the cross-covariance of w and the gas at every lag and take the standard deviation of these values.
4. The detection limit is the mean of the two standard deviations. If only one window yields a result (the early window may fall outside a short record), that one is used alone. A window needs at least three valid lags.

Two windows are used because an offset that clears the peak on one side may still lie inside it on the other if the cross-covariance is asymmetric. Longer averaging periods and lower-noise instruments reduce the resulting limit, since more samples and a cleaner signal make a true flux easier to distinguish from noise.

Because the limit depends on the noise of the measured series rather than on the covariance realised in a given period, it can be computed for every gas, independently of whether a flux was detected. It is not computed if the acquisition frequency is unknown, and gas columns that are not measured are left missing.

## Enabling the calculation

The detection limit is switched off by default (`detlim_meth` 0): the **Method** selector in the Flux Detection Limit dialog reads *None* until you choose a method. Switching it on changes no flux. With *None*, the output columns still exist but carry the error code. See the [Flux Detection Limit Settings dialog](flux-detection-limit-settings.md) reference for the available options and their parameters.

## Reported values

The limit is reported per gas in **covariance units**, as `<gas>_detlim` in the [full output file](output-files-full-output.md#top) and as `<GAS>_DETLIM` in the FLUXNET output.

It is deliberately not scaled to a flux. What the limit qualifies is the covariance, and the flux has been through the spectral correction while the limit has not, so the two are not directly comparable without accounting for that correction.

## Use elsewhere in EddyFlow

Besides being reported as a diagnostic alongside flux results, the detection limit can be used as one of two selectable noise floors for conditional lag borrowing (`tlag_borrow_meth`, noise floor `tlag_borrow_noise=0`, labelled "The flux detection limit"): when a gas's own covariance maximum does not clear the chosen number of detection limits (`tlag_borrow_snr`, default 3), EddyFlow can borrow the time lag detected for a better-behaved gas measured on the same analyser ([Nemitz et al., 2018](references.md#Nemitz2018)). That feature needs the detection limit switched on: the engine refuses the setting otherwise. See [Raw processing options](raw-processing-options.md#conditional-lag-borrowing), [Detecting and Compensating Time Lags](time-lag-detect-correct.md) and the [PWB time lag optimization settings dialog](pwb-time-lag-settings.md) for details.

!!! note

    The detection limit is a diagnostic value for a given averaging period and gas, not a filter automatically applied to the flux itself; use it, together with the random uncertainty and the quality flags, to judge whether a given flux value is meaningful.
