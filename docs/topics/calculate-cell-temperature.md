---
title: "Calculating Cell Temperature"
source_url: "https://www.licor.com/support/EddyPro/topics/calculate-cell-temperature.html"
---
# Calculating cell temperature (closed path systems only)

The LI-7200 Enclosed CO2/H2O Analyzer features two fast measurements of the cell temperature: one at the inlet (Tin) and one at the outlet (Tout) of the cell. It computes the average cell temperature (Tcell) with a weighted average of these two fast measurements as:

6‑1
                                                            ![Tcell=0.8*Tout+0.2*Tin](https://www.licor.com/support/GeneratedImages/Equations/Equation908.svg)

You can select either or all of the three temperatures as outputs, which are stored in the raw files.

When the data are processed, however, Tin and Tout are used to compute Tcell sample by sample, if the latter is not available. Thus, before any other processing step, EddyFlow does the following:

- If Tcell is available, does nothing. In this case, EddyFlow will ignore columns of Tin and Tout (if present in the raw files and selected for processing);
- If Tcell is not available:If Tin and Tout are both available, calculate Tcell sample-by-sample using the weighted average equation above;If Tin is available and Tout is not, sets Tcell=Tin;If Tout is available and Tin is not, sets Tcell=Tout;
- If Tcell, Tin and Tout are not available, Tcell is not defined. In this case, average cell temperature will be set equal to average sonic temperature (corrected for humidity effects).
