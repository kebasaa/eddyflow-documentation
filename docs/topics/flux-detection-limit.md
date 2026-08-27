# Flux detection limit

EddyFlow can estimate, for each flux averaging period, a *detection limit*: the smallest flux magnitude that can be distinguished from the analytical and measurement noise inherent to the instrumentation, given the averaging period used. Fluxes with an absolute value below the detection limit cannot be reliably distinguished from zero and should be interpreted with caution, even if their computed random uncertainty is otherwise acceptable.

The detection limit is calculated following the method described by [Wienhold et al. (1994)](references.md#Wienhold1994).

## Detection limit vs. random uncertainty

The detection limit is conceptually related to, but distinct from, the [random uncertainty estimation](random-uncertainty-estimation.md) methods (Mann and Lenschow, 1994; Finkelstein and Sims, 2001) also available in EddyFlow:

- **Random uncertainty** starts from a computed, non-zero flux value and asks: how much sampling error is associated with this particular estimate, given the turbulence statistics of the averaging period? It is expressed as an absolute uncertainty on the flux itself, and it scales with the actual variability of the vertical wind and scalar time series during that period.
- **Detection limit** instead asks a prior question, independent of what flux was actually computed: given the analytical/measurement noise of the instrument and the length of the averaging period, how small could a flux be and still be resolvable at all? It follows from the noise characteristics of the raw high-frequency signal (e.g. gas analyzer electronic and analytical noise) rather than from the correlation structure of a specific computed flux.

In practice, this means a flux can have a small random uncertainty (i.e. it appears to be a precise estimate) while still falling below the detection limit, if the underlying signal is dominated by instrument noise rather than by a real correlated flux signal. The two diagnostics therefore address different questions and are best used together: random uncertainty characterizes the precision of a given non-zero flux estimate, while the detection limit characterizes the noise floor below which any flux, regardless of its computed value, cannot be considered meaningfully different from zero.

## Method

The method of [Wienhold et al. (1994)](references.md#Wienhold1994) estimates the detection limit from the high-frequency noise characteristics of the scalar (or, for momentum, the wind) time series involved in the covariance calculation, combined with the length of the flux averaging period. Conceptually, the approach separates the true atmospheric signal from the analytical noise floor of the measurement, and propagates that noise floor through the covariance calculation to obtain the smallest covariance-based flux that noise alone could produce over the given averaging time. Longer averaging periods and lower-noise instrumentation both reduce the resulting detection limit, since more samples and a cleaner underlying signal make it easier to distinguish a true flux from noise.

Because the detection limit depends on the noise properties of the measured time series rather than on the specific covariance realized during a given period, it can be computed independently for each gas or scalar processed by EddyFlow, and independently of whether a "real" flux was actually detected in that period.

## Enabling the calculation

The detection limit is switched off by default: the **Method** selector in the Flux Detection Limit dialog reads *None* until you choose a method. See the [Flux Detection Limit Settings dialog](flux-detection-limit-settings.md) reference for the available options and their parameters.

## Reported values

The limit is reported per gas in **covariance units**, as `<gas>_detlim` in the [full output file](output-files-full-output.md#top) and as `<GAS>_DETLIM` in the FLUXNET output.

It is deliberately not scaled to a flux. What the limit qualifies is the covariance, and the flux has been through the spectral correction while the limit has not, so the two are not directly comparable without accounting for that correction.

## Use elsewhere in EddyFlow

Besides being reported as a diagnostic alongside flux results, the detection limit is also used internally as one of two selectable noise floors for the EddyUH-compatible conditional lag-borrowing feature of the pre-whitening block-bootstrap (PWB) time lag optimization method: when a gas's own covariance-based time lag estimate does not clear the chosen noise floor, EddyFlow can borrow the time lag detected for a better-behaved gas measured on the same intake tube. See [Detecting and Compensating Time Lags](time-lag-detect-correct.md) and the [PWB time lag optimization settings dialog](pwb-time-lag-settings.md) for details.

!!! note

    The detection limit is a diagnostic value for a given averaging period and gas, not a filter automatically applied to the flux itself; use it, together with the random uncertainty and the quality flags, to judge whether a given flux value is meaningful.
