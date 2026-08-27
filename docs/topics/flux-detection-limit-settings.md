# Flux Detection Limit Settings dialog

Under: Advanced Settings > Processing Options > Other options

Activating **Flux Detection Limit** causes the **Flux Detection Limit Settings** button to activate. Click on it to access the flux detection limit configuration dialog and configure the calculation method described in [Flux detection limit](flux-detection-limit.md).

## Detection limit method

- **Calculate flux detection limit:** Enables or disables detection limit calculation. When disabled, no detection limit is calculated or reported, and the detection limit cannot be selected as the noise floor for [conditional lag borrowing](pwb-time-lag-settings.md).
- **Detection limit method:** Selects the method used to estimate the detection limit. Currently, EddyFlow implements the method of [Wienhold et al. (1994)](references.md#Wienhold1994), which derives the detection limit from the analytical noise characteristics of the measured time series and the length of the flux averaging period.

!!! note

    The flux detection limit is a diagnostic value reported alongside flux results; enabling this option does not by itself alter or filter the computed fluxes. To use the detection limit as the noise floor for EddyUH-compatible conditional lag borrowing, select it as the **Borrowing noise floor** option in the [PWB time lag optimization settings dialog](pwb-time-lag-settings.md).
