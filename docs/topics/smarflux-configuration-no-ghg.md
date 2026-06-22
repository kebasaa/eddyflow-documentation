---
title: "Using Advanced Settings on the SmartFlux System"
source_url: "https://www.licor.com/support/EddyPro/topics/smarflux-configuration-no-ghg.html"
---
# Using planar fit, in situ spectral corrections and timelag optimization in SmartFlux

In order to use planar-fit, *in situ* spectral corrections or timelag optimization in the SmartFlux System, EddyFlow needs to access the respective "planar_fit", "spectral_assessment" and "timelag_optimization" files, hereafter referred to as "additional configuration files". These files contain summaries of calculations performed on relatively large datasets ([Table 2‑3](#Dataset)) and that also apply to data to be collected in the future.

For example, you can use three months of data to calculate a spectral assessment, and then use this spectral assessment that is summarized in a short text file, to correct fluxes calculated from data collected after those three months, if the system configuration didn't change to such an extent that the spectral assessment is no longer representative. Similar considerations apply to the planar fit and the timelag optimization procedures. Refer to EddyFlow documentation for more details on when and how to use these three advanced procedures.

The additional configuration files are created by EddyFlow (3.0 and above), when used in the standard desktop mode. If you have been running your EC system (the EC system in which you intend to use the SmartFlux System) for some time, you may have already created one or more of these files, or you may have a `.ghg ` dataset suitable for creating them, if the corresponding implementation is deemed necessary to calculate accurate fluxes (again, refer to EddyFlow documentation to learn more about when it is suggested to use these options). If you do not have previously-collected `.ghg ` files, then you will need to run the system for a suitable amount of time (for example using SmartFlux in Express mode), then use EddyFlow in desktop mode to create the additional configuration files, and then load them onto the SmartFlux System as explained below.

| EddyFlow Advanced Setting | Recommended Dataset |
| --- | --- |
| Planar Fit Settings | 2 weeks minimum; < 2 months |
| Time Lag Optimization | 1 to 2 months or more |
| Spectral Corrections, Assessment of high frequency attenuation | 1 month or more |

Thus, assuming that you have a sufficiently long .ghg dataset ([Table 2‑3](#Dataset)), the procedure to correctly configure the SmartFlux System to use planar-fit, in-situ spectral corrections or timelag optimization is illustrated here, using the in-situ spectral corrections as an example. Analogous procedures shall be followed for the planar-fit or the timelag optimization.

1. Open EddyFlow (5.0 or above recommended) in normal desktop mode and complete the ** Project Creation ** and ** Basic Settings ** pages as usual (refer to EddyFlow documentation if needed).
2. In the ** Advanced Settings > Spectral Corrections **, configure ** Corrections for low-pass filtering effects ** to use one of the *in situ* methods, i.e. Horst (1997), Ibrom et al. (2007) or Fratini et al. (2012). In the same page, customize the settings to instruct EddyFlow to use the dataset of your choice and to filter data appropriately, so as to obtain a sound assessment of spectral attenuations. Click ** Run ** and when this is completed, locate the spectral assessment file (it contains the string "spectral_assessment" in the file name) in the subdirectory \\spectral_analysis that you will find inside the selected Output folder. This is the file that you will use for the SmartFlux System.
3. Open EddyFlow (5.0 or above) in SmartFlux Setup Mode.
4. Configure everything as explained in the previous sections. In the ** Advanced Settings > Spectral Corrections **, configure ** Corrections for low-pass filtering effects ** to use one of the *in situ* methods among Horst (1997) and Ibrom et al. (2007) (the method of Fratini et al. (2012) is currently not usable in the SmartFlux System). In the ** Spectral assessment file available ** entry, select the spectral assessment file created earlier. Then proceed normally and when done, click on the ** Create File ** button to create the bundle with a `.smartflux ` extension, as explained above.

An analogous procedure can be used to create and use the planar fit and the timelag optimization configuration files.
