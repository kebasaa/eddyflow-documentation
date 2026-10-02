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

Project-file keys `tilt_sensor_meth`, `tilt_sensor_v_g`, `tilt_lpf_s`, `tilt_arm_x`, `tilt_arm_y`, `tilt_arm_z`; interface entry **Inclinometer tilt correction (fast inclination channels)** (see [Advanced settings: processing options](raw-processing-options.md#inclinometer-tilt-correction)). **Off by default.**

**Idea.** Double rotation, triple rotation and planar fit all remove only the *mean* tilt evaluated over the flux averaging period; none of them can correct a tilt that changes *within* that period, for example the wind-induced swinging of a mast. An inclinometer logged at the sonic anemometer's own sample rate resolves the tilt sample by sample, so each raw wind sample can be corrected for its own instantaneous tilt instead of a single period-average angle. The correction is applied to the raw wind before any of the rotation methods described above.

**Procedure.**

1. Read the inclinometer channels from the raw data. They are ordinary extra columns named `theta`, `phi` and `psi`, declared in the **Raw File Description**. A channel that is absent contributes a zero angle; if none is found the correction is skipped and the log says so.
2. Convert each voltage to an angle, angle = -asin(V / `tilt_sensor_v_g`), with `tilt_sensor_v_g` the sensitivity in volts per g (default 4). A reading beyond full scale is clamped to plus or minus 90 degrees.
3. Optionally smooth each angle series with a centred running mean of `tilt_lpf_s` seconds (default 0 = no smoothing).
4. **Position** (`tilt_sensor_meth` = 1): rotate each wind vector by the angles of that sample.
5. **Position and swinging** (`tilt_sensor_meth` = 2): in addition, add a term for the motion of the sonic head about the mast pivot, built from the lever arm (`tilt_arm_x/y/z`, metres, default -1.5 on each axis) and the time derivatives of the angles.

**Assumptions and limitations.**

- The channels hold the inclinometer's output **voltage**, not an angle. A wrong sensitivity gives a wrong angle in proportion.
- The third angle, `psi`, is read and discarded (treated as zero); the correction is a two-angle correction even with three channels declared.
- The swinging term is a single scalar added equally to u, v and w, not the vector velocity of a point on a rotating body. The units are right (radians per second times metres is metres per second), so it is easy to overlook. No choice of lever arm turns a scalar into a vector; the lever-arm default is a starting point, not a measurement of your mast, and a wrong arm adds a velocity that is not there. If you want the physical correction, use **Position** only.
- Smoothing the angle is not smoothing the wind. A window long compared with the swinging period removes the sway the correction is meant to catch.
- The correction reaches the **flux computation only**. The planar-fit and time-lag pre-passes run before the angle columns exist, so the planar fit is fitted to winds this correction has not touched. The effect is second order, because the correction targets variation within a period, not the mean.
- It assumes a series already in the sonic's true frame, and is applied before any axis rotation.

This correction is disabled by default; if left off, EddyFlow behaves exactly as described in the rest of this page.

## Metek USA-1 head correction

Project-file keys `head_corr_meth`, `head_corr_dir`; interface entry **Metek USA-1 head correction (three-dimensional flow distortion)** (see [Advanced settings: processing options](raw-processing-options.md#metek-usa-1-head-correction)). **Off by default.**

**Idea.** The transducers and supporting structure of a Metek USA-1 deflect the flow before the sonic measures it, by an amount that depends on the direction the wind comes from. Metek measured this in a wind tunnel and published three tables of Fourier coefficients over elevation angle, one each for wind speed, azimuth and elevation, evaluated at three, six and nine times the azimuth.

**Procedure.**

1. Read the three tables `phicorr.dat`, `ucorr.dat` and `alphacorr.dat` from the directory `head_corr_dir`, once per run. Each has twenty rows, one per elevation from -50 to +45 degrees in steps of five, giving the elevation and then the coefficients C0, C3, S3, C6, S6, C9 and S9.
2. For `head_corr_meth` = 2 (data already carrying Metek's online two-dimensional correction), first undo that correction with the closed form Metek publishes for it. For `head_corr_meth` = 1 (raw data) this step is omitted. Applying the three-dimensional correction on top of an un-undone two-dimensional one would count the horizontal part twice.
3. For each sample, interpolate the tables at the sample's elevation and evaluate the speed, azimuth and elevation corrections at the sample's azimuth, then apply them to the wind vector.

The correction runs on the raw wind, sample by sample, before the inclinometer correction and before any rotation, in all three raw-data passes of the processing run (so, unlike the inclinometer correction, the pre-passes see the corrected wind).

**Assumptions and limitations.**

- The three table files are Metek GmbH's measurements and are **not distributed** with EddyFlow. You must supply your own copy and point `head_corr_dir` at its directory. If any of the three is missing, or a table has fewer than twenty rows, the correction is **declined for the whole run** and the run log says so, rather than correcting some periods and not others. The fluxes then come out as if it had never been switched on.
- The tables were measured on one-inner-bar USA-1 models. Nothing in the metadata distinguishes the variants, so the match is not checked.
- Choosing the wrong **Applies to** entry costs a percent or so of the horizontal wind.
- The correction compensates the instrument's own head only; it does not replace the angle-of-attack correction used for Gill sonic anemometers (see [Angle of attack correction](angle-of-attack-correction.md#top)) and is unrelated to the flow-distortion correction applied by anemometer firmware (see [Head or flow distortion correction](flow-distortion-correction.md#top)).

This correction is disabled by default.
