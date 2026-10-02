# Processing options

The **Advanced Settings** page provides a variety of options that make it possible to process the eddy covariance data with customized parameters.

!!! note

    The default settings in this section correspond with the settings used by Express Mode, meaning that you can process a dataset in Advanced Mode without altering these settings, and still compute reasonable results for most datasets.

![](../assets/Adv_Settings_PO.png)

The **Processing Options** tab includes the following settings. Click any of the links below for more information.

## Raw data processing

- [Wind speed measurement offsets](raw-processing-options.md#wind-speed-measurement-offsets)
- [Fix 'w-boost' bug (WindMaster and WindMaster Pro only)](raw-processing-options.md#fix-w-boost-bug-windmaster-and-windmaster-pro-only)
- [Angle of attack correction for wind components](raw-processing-options.md#angle-of-attack-correction-for-wind-components)
- [Metek USA-1 head correction](raw-processing-options.md#metek-usa-1-head-correction)
- [Inclinometer tilt correction](raw-processing-options.md#inclinometer-tilt-correction)
- [Axis rotation for tilt correction](raw-processing-options.md#axis-rotation-for-tilt-correction)
- [Detrending turbulent fluctuations](raw-processing-options.md#detrending-turbulent-fluctuations)
- [Time lag optimization settings](raw-processing-options.md#time-lag-optimization-settings)
- [Subtract the cross-covariance baseline](raw-processing-options.md#subtract-the-cross-covariance-baseline)
- [Conditional lag borrowing](raw-processing-options.md#conditional-lag-borrowing) (borrow a tube-mate's lag below the detection limit, detection limits to clear, judged against, borrow from)

## Compensation for density fluctuations

- [Compensation for density fluctuations (WPL terms)](raw-processing-options.md#compensation-for-density-fluctuations-wpl-terms)
- Remove the spectroscopic effect of water vapour, and also correct the water channel (see [Compensation for density fluctuations](raw-processing-options.md#compensation-for-density-fluctuations-wpl-terms))
- [Add instrument sensible heat components (LI-7500)](selecting-advanced-options.md#Add)

## Other options

- [Conditional Eddy Covariance](conditional-eddy-covariance.md#top) ([CEC settings dialog](cec-settings.md#top))
- [Quality check - flagging policy](raw-processing-options.md#quality-check---flagging-policy)
- [Footprint estimation](raw-processing-options.md#footprint-estimation)
- [Parallelise the planar fit and time lag pre-passes](raw-processing-options.md#parallelise-the-planar-fit-and-time-lag-pre-passes)

!!! note

    As of engine v8.1.0, spectral correction fitting can use any of several Kaimal-type cospectral models, rather than a single fixed formulation; see [Calculating spectra, cospectra, and ogives](calculate-spectra-cospectra-and-ogives.md) for details.
