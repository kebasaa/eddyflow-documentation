# Axis rotation for tilt correction

See [Axis rotation for tilt correction](selecting-advanced-options.md#Axis) for more information.

Tilt correction algorithms have been developed to correct wind statistics for any misalignment of the sonic anemometer with respect to the local wind streamlines. In particular, this implies that stresses and fluxes evaluated perpendicular to the local streamlines are affected by spurious contributions from the variance of along-streamlines components. Based mostly on [Wilczak et al. (2001)](references.md#Wilczak), EddyFlow supports three options for addressing anemometer tilting: the double rotation, triple rotation, and the planar fit method. Furthermore, the planar fit method is implemented in two different versions, as detailed in the following section.

## Double rotation method

With this method, the anemometer tilt is compensated by rotating raw wind components to nullify the average cross-stream and vertical wind components, evaluated on the time period defined by the flux averaging length. The rationale is that cross and perpendicular wind components average to zero during such time periods. In the first rotation, the measured wind vector um≡(um,vm,wm) is rotated about the z axis into a temporary vector utmp, using a rotation angle θ such that the average crosswind wind component vanishes (![](https://www.licor.com/support/GeneratedImages/Equations/Equation916.svg) =0).

6‑8
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation917.svg)

The first rotation equations are:

6‑9
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation918.svg)
                                                              

                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation919.svg)
                                                              

                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation920.svg)

The second rotation is performed about the new y-axis, using the angle Ï• that nullifies wtmp:

6‑10
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation921.svg)

The second rotation equations are:

6‑11
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation922.svg)
                                                              

                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation923.svg)
                                                              

                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation924.svg)

The rotated vector **u** rot![](https://www.licor.com/support/GeneratedImages/Equations/Equation925.svg) (urot, vrot, wrot) has zero v and w components, while its u component holds the value of the mean wind speed over the flux averaging interval.

!!! note

    In EddyFlow rotation angles are evaluated using average wind components, but the rotation is applied sample-wise. That is, after the rotation the wind dataset is modified.

## Triple rotation method

The "triple rotation" method involves the first two rotations as described in 2.9.1 and a third rotation around the new x axis, where the roll rotation angle ψ is defined to nullify the cross-stream stress component ![](https://www.licor.com/support/GeneratedImages/Equations/Equation926.svg):

6‑12
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation927.svg)

The third rotation equations are:

6‑13
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation928.svg)
                                                              

                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation929.svg)
                                                              

                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation930.svg)

Where ![](https://www.licor.com/support/GeneratedImages/Equations/Equation931.svg) is the triple rotated wind vector.

## The "traditional" planar fit method

The planar fit method ([Wilczak et al., 2001](references.md#Wilczak)) is based on the assessment of the anemometer tilt with respect to long-term local streamlines. This method is deemed more suitable in case of complex or sloping topography, when the mean vertical wind component or cross-stream stresses might actually differ from zero ([Lee et al., 2004](references.md#Lee)). In the planar fit method, the tilting is assessed by fitting a plane to the actual measurements of the average vertical wind component ![](https://www.licor.com/support/GeneratedImages/Equations/Equation932.svg), as a function of the horizontal components, ![](https://www.licor.com/support/GeneratedImages/Equations/Equation933.svg) and ![](https://www.licor.com/support/GeneratedImages/Equations/Equation934.svg) . The rationale is that if the anemometer is tilted with respect to the local streamlines, a certain amount of the horizontal wind speed will be found in the measured vertical component, and ![](https://www.licor.com/support/GeneratedImages/Equations/Equation935.svg) will show a certain proportionality to (a linear combination of) ![](https://www.licor.com/support/GeneratedImages/Equations/Equation936.svg) and ![](https://www.licor.com/support/GeneratedImages/Equations/Equation937.svg):

6‑14
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation938.svg)

The fitting procedure involves a bilinear regression to determine the fitting parameters b0, b1 and b2. The two (partial) planar fit rotation angles are then defined so as to place the z axis perpendicular to the plane of the local streamlines and thus to nullify the long-term mean of the individual ![](https://www.licor.com/support/GeneratedImages/Equations/Equation939.svg) values:

6‑15
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation940.svg)

where the rotation matrix Mpf is defined as:

6‑16
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation941.svg)

and angles α and β are linked to the fitting plane coefficients by:

6‑17
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation942.svg)
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation943.svg)

6‑18
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation944.svg)
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation945.svg)

Equations 42-44 in [Wilczak et al., (2001)](references.md#Wilczak) provide a different formulation for the elements mij, valid also for large tilt angles. This is the formulation implemented in EddyFlow.

A third rotation, similar to the first rotation in [the Double Rotation Method](#Double), will align the wind vector with the main wind direction.

6‑19
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation946.svg)
                                                              

                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation947.svg)
                                                              

                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation948.svg)

with ![](https://www.licor.com/support/GeneratedImages/Equations/Equation949.svg) .

The planar fit method can be applied "sector-wise". In EddyFlow you can define a number of (equally wide) wind sectors. The calculations will then be performed for each sector independently, and the appropriate rotation matrix will be applied, depending on the current wind direction.

## Planar fit with no velocity bias

After verifying that the coefficient b0 is not a proper estimator of the anemometer bias in the measurement of vertical wind component as suggested by [Wiczak et al (2001)](references.md#Wilczak), [van Dijk et al. (2004)](references.md#vanDijk) proposed a revision of the method, which assumes that any bias in the measurement of w is already accounted for in the anemometer calibration and thus that the fitting plane passes through the origin (b0=0). Under these hypotheses the planar fit method reduces to

6‑20
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation950.svg)

with the same relationships between b1 and b2 and the tilt angles as with the original planar fit. Both planar fit methods are available in EddyFlow, with customizable planar fit settings, sectors, and more.

## Inclinometer tilt correction

**Off by default.** Double rotation, triple rotation, and planar fit all remove only the *mean* tilt evaluated over the flux averaging period; none of them can correct for tilt that changes *within* that period, for example due to wind-induced swinging of the anemometer mount. EddyFlow can optionally apply an **inclinometer tilt correction** (engine setting `tilt_sensor_meth`) before any of the rotation methods described above, using tilt-angle measurements from an inclinometer logged at the sonic anemometer's own sample rate. Because the inclinometer resolves tilt sample by sample, each raw wind sample is corrected for its own instantaneous tilt, rather than for a single period-average angle.

Settings for this correction include:

- **`tilt_sensor_v_g`**: the inclinometer's volts-per-g calibration factor, used to convert the logged voltage signal into a tilt angle.
- **`tilt_lpf_s`**: an optional low-pass filter time constant (seconds) used to smooth the raw angle series before it is applied.
- **`tilt_arm_x`**, **`tilt_arm_y`**, **`tilt_arm_z`**: the lever arm, in the sonic's own coordinate system, from the pivot point to the inclinometer's sensor head; required for the "swinging" mode, in which the inclinometer does not sit exactly at the pivot and its measured tilt must be corrected for its own motion about that pivot.

This correction is disabled by default; if left off, EddyFlow behaves exactly as described in the rest of this page.

## Metek USA-1 head correction

**Off by default.** For datasets collected with a Metek USA-1 anemometer, EddyFlow can optionally apply a **head correction** (engine setting `head_corr_meth`) that compensates for flow distortion caused by the instrument's own transducers and supporting structure, ahead of the rotation methods described on this page. The correction is based on Metek's own wind-tunnel calibration tables for the USA-1 head. These tables are Metek GmbH's proprietary data and are not distributed with EddyFlow: to use this correction, the user must supply a copy of the required table files and point EddyFlow to the directory containing them via the `head_corr_dir` setting. If any of the required files are missing from that directory, the head correction is skipped for the entire run.

This correction is disabled by default.
