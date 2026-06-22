# Crosswind correction

In a 3-dimensional sonic anemometer, the sonic temperature (Tsi) is estimated on each of the three measurement paths. The three estimates are then averaged into a single value of sonic temperature (Ts). The crosswind correction accounts for the effect of a wind component normal to the measurement path on each estimation of the sonic temperature:

6‑6
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation913.svg)

where ![](https://www.licor.com/support/GeneratedImages/Equations/Equation914.svg) is the corrected sonic temperature and Vni is the wind component normal to the ith axis. Components Vni can be derived from actual (instantaneous) wind measurements in the anemometer's coordinate system with a simple geometrical transformation:

6‑7
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation915.svg)

Where um and vm are the measured wind components in the horizontal axes of the anemometer, and Ai, Bi, and Ci are geometrical factors for the ith axis that depend on the geometry of the anemometer. Table 1 in [Lui et al. (2001)](references.md#Liu) gives geometrical factors for the following anemometers:

- CSAT3, Campbell® Scientific, Inc.
- R2, R3, R3A, HS by Gill Instruments
- USA-1 by Metek

** Note:** The correction is already applied in the firmware of some anemometers (e.g., the CSAT3). In these cases, applying the correction in EddyFlow will result in double accounting.

We recommend that you verify the settings in the instructions for your anemometer. Use the correction in EddyFlow according to the following scenarios.

- *The correction is not implemented in the firmware.* In this case we suggest checking this option and let EddyFlow perform the correction;
- *The correction is implemented in the firmware and it is not possible to turn it off.* In this case you should clear this option in EddyFlow to avoid double accounting;
- *The correction is available in the firmware as an option.* In this case, you can decide to apply either the native correction or the EddyFlow correction.
