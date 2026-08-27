# PWB time lag optimization settings dialog

Under: Advanced Settings > Processing Options > Time lags compensation > PWB Time Lag Optimization Settings

Selecting the **Pre-whitening block-bootstrap** time lag compensation method will cause the **PWB Time Lag Optimization Settings...** button to activate. Click on it to access the PWB configuration dialogue and enter the following settings:

## Bootstrap settings

- **Number of bootstrap resamples:** Set the number of block-bootstrap resamples EddyFlow generates for each flux averaging interval to build the distribution of plausible time lags. A higher number produces a smoother, more stable distribution and a more reliable lag estimate and HDI, at the cost of longer program execution.
- **Block length:** Length, in seconds, of the contiguous blocks used to resample the pre-whitened time series. The block length should be long enough to preserve the short-range dependence structure of the turbulent signal, but short enough to allow a sufficient number of blocks to be drawn from a single flux averaging interval.
- **Minimum valid data fraction:** Minimum fraction of valid (non-gapped, non-flagged) high-frequency data required within a flux averaging interval for PWB to attempt a lag estimate. If the valid data fraction falls below this threshold, the period is treated as if no lag could be determined, and the **Maximum carry-over** policy applies.
- **HDI threshold:** Maximum acceptable width, in seconds, of the highest-density interval around the bootstrap lag estimate. If the HDI is wider than this threshold, the estimate is considered too uncertain to use directly, and the **Maximum carry-over** policy applies instead.
- **Random seed:** Seed used to initialize the random number generator that drives block resampling. Setting a fixed seed makes PWB results exactly reproducible across runs on the same dataset; leave at the default to let EddyFlow pick a seed automatically.

## Carry-over and detection timing

- **Maximum carry-over:** Maximum number of hours over which a previous, well-determined time lag estimate may be carried forward and reused for flux averaging periods where PWB could not produce an acceptable estimate (e.g., because of insufficient valid data or too wide an HDI). Setting this too high risks applying a stale lag to a period where conditions have since changed; setting it too low increases the chance of falling back to a nominal or nearest-plausible lag for many periods in sequence.
- **Detect before WPL correction:** When enabled, PWB lag detection is performed on concentration data prior to the compensation of density fluctuations (WPL terms). Leave disabled to run detection after WPL correction has been applied.
- **Detect on raw data:** When enabled, PWB lag detection is performed directly on raw, unprocessed high-frequency data rather than on the despiked/detrended series used elsewhere in raw data processing. This can be useful for diagnostic purposes, but is not recommended for routine processing.

## Conditional lag borrowing

These settings implement EddyUH-compatible conditional lag borrowing between gases sharing the same intake tube (e.g., a closed-path system where CO2 and CH4 are drawn through a single sampling line).

- **Borrowing noise floor:** The noise floor that a gas's own covariance-based lag estimate is judged against to decide whether it is reliable enough to keep. If the covariance associated with a gas's detected lag does not clear this noise floor, the gas is considered a candidate for lag borrowing.
- **Borrowing donor gas:** The gas whose time lag is borrowed by another gas on the same intake tube when that gas's own estimate fails the noise-floor test above. For example, on a shared tube, a noisy CH4 (or N2O) channel can be configured to borrow the lag detected for a co-located, higher signal-to-noise CO2 channel.

!!! note

    Conditional lag borrowing only applies to gases explicitly configured as sharing an intake tube with the chosen donor gas. It has no effect on gases measured through independent sampling lines or on open path instruments.

!!! note

    PWB is available starting with EddyFlow engine v7.2.1 (GUI v7.2.1 and later, 2026-06), and is based on [Vitale et al. (2024)](references.md#Vitale2024).
