# Selecting advanced processing options

In the Advanced Mode, EddyFlow provides several options for many processing steps. It also provides many optional output files. Here we provide suggestions about which processing options are suitable under certain circumstances. While we want to stress that there is no general consensus on the best choice for any given situation, and that often alternative options bring similar results, there are situations in which a better choice can be identified unambiguously.

## Wind speed measurement offsets

This information is specific to each anemometer. You may find it in your anemometer calibration certificate (note that this is unit-specific information), or you may assess the offsets on your own, e.g., by placing the anemometer in a closed box (zero wind conditions) and taking an average of the recorded wind speeds over an extended period of time. If you do have this information, just enter it and EddyFlow will subtract these offsets from the wind components prior to any other operation.

## Fix 'w-boost' bug (WindMaster and WindMaster Pro only)

Gill WindMaster™ and WindMaster™ Pro anemometers produced between 2006 and 2015 and identified by a firmware version of the form 2329.x.y with x <700 are affected by a bug such that the vertical wind speed is underestimated. If you think your anemometer might fit the above criteria, you should enable this option. EddyFlow will apply the fix only if the data are eligible according to the criteria. For more details, please see [W-boost Bug Correction for WindMaster/Pro](w-boost-correction.md#W-boost)

## Angle of attack correction for wind components (Gill anemometers only)

The Angle of Attack correction, also known as head correction or flow distortion correction, is currently available in EddyFlow only for post-mounted Gill Instruments sonic anemometers with the same geometry as the R3 (including the R2, WindMaster™ and WindMaster™ Pro). Please see [Angle of attack correction](angle-of-attack-correction.md#top) for details on the applicability of the available methods to different anemometer models and firmware versions.

## Axis rotation for tilt correction

Traditionally, anemometer tilt correction was compensated using either the double-rotation or triple-rotation schemes. Nowadays, *the triple-rotation scheme is no longer recommended* (e.g., Marc Aubinet, personal communication), but it is available in EddyFlow for backward-compatibility purposes.

The *double-rotation method* is recommended when the site is characterized by substantial homogeneity, flatness and isotropy. Under these conditions, often found on grassland sites, for example, it is safe to assume that local wind streamlines are parallel to the surface, and the double rotation scheme is a robust method to compensate the vertical misalignment of the anemometer.

Also, the *double-rotation method* is suggested when canopy height and roughness changes quickly, such as during the growing season in a crop field. In situations characterized by a complex or sloping topography or strong canopy dishomogeneity, the *planar fit method* is the preferred choice. EddyFlow provides two implementations of the planar fit method. The one labeled *Planar fit* is the traditional one (e.g., Wiczak et al. 2001).

The second one, labeled *Planar Fit with no velocity bias* is a different implementation proposed by van Dijk et al. (2003). The latter method is based on the observation that the coefficient *b0* that is included in the first one is not a good estimator of the anemometer bias on the measurement of the vertical wind component. Thus, the authors propose a modified version, in which any bias of the anemometer is intended as preliminary compensation, from which it follows the constraint that coefficient *b0* must be zero (implying that if average *u* and *v* are zero, average *w* is also zero). Choosing either implementation is up to you. We recommend reading the relevant literature to make an informed decision. Also, the number of wind sectors to use depends on the topography at the site and on the wind regimes.

In summary, here are our recommendations:

1. For flat, horizontal and uniform/isotropic and extended fetches, or for sites with fast changing canopy structure, use the "double rotation" method.
2. In all other conditions use either implementation of the planar fit method.
3. When the planar fit is used, adjust the number of wind sectors according to the topography of the site, the structure of the canopy, and the wind regimes.

## Turbulent fluctuations

No obvious recommendation can be made here. As a general observation, using a detrending method (either *linear detrending* or one of the *running mean* implementations) becomes more important with increasing length of the flux averaging interval, to prevent long-term trends not related to turbulence (e.g., at sunrise and sunset) from turning into artificial flux contributions. The block average method, while retaining the largest amount of low frequency content (thus including possible spurious effects of trends), is the only method that obeys the Reynolds decomposition rule, on which the eddy covariance formulation is based. If you select a long flux averaging interval (1 hour, 2 hours, etc), selecting a detrending method with the proper time constant is probably the best choice, to avoid strong overestimation of fluxes induced by relevant non-turbulent trends turning into flux contributions.

** Note:** Selecting the option to perform low frequency range spectral corrections will partially compensate the differences induced by different detrending methods.

## Time lag compensation

Time lags should be always compensated, the only exception being the case of an open path analyzer located very close to an anemometer or overlapping with it (however, this configuration is not recommended due to the important flow distortion effects that result). *Constant* time lags means that the software always uses the same value, which is the nominal one entered for each variable and stored in the metadata file, or the one automatically calculated by EddyFlow if the nominal is left to zero. A constant time lag could be used when measuring with a closed path gas analyzer, using a flow controller to impose a constant flow rate in the tube and when measuring only passive gases (e.g., no water vapor), or also water vapor if the humidity in the sampling line is constantly kept very low, e.g., by means of an active heating system. For open path systems with detectable (>10-20 cm) distance between the sampling volume of the gas analyzer and of the anemometer, a constant time lag is not recommended, because the actual time lag will depend on the wind direction. Using a constant time lag results in a faster program execution.

With the *Covariance Maximization* option, the circular correlation technique is used to detect the time lag within a plausible window defined by the minimum and maximum time lags selected for each variable. With the *Covariance maximization with default* option, the same procedure is applied, however, if a maximum is not attained within the window (i.e., the covariance maximum is found at either endpoint of the time lag window), then the nominal value is used. If the time lag window (min-max) is well defined, the *Covariance maximization with default* method is probably the best option. However, if the time lag window is not properly defined (i.e., it is too narrow), the consequence of using this method can be flux underestimation. The simple *Covariance Maximization* is safer in these conditions, but in turn it may lead to flux overestimations when the time lag window is too broad and fluxes are small.

Both options, however, are unsuitable for water vapor in typical closed path setups. In this case, the *Automatic time lag optimization* option is by far the most appropriate, as default time lags as well as plausibility windows are optimized as a function of relative humidity. Selecting this option, time lags for all other gases will also be optimized (with no consideration of relative humidity) by EddyFlow. The downside of using this option is a longer program execution time.

## Compensation of density fluctuations

Native measurement of most gas analyzers is gas density, i.e., absolute number of molecules in a known volume of air, that needs to be transformed into a mixing ratio measurement (i.e., mass of gas per mass of air). The air density is used in this transformation. However, air density fluctuates on account of temperature and pressure fluctuations and depending on fluctuations in content of trace gases, notably water vapor. Such fluctuations need to be compensated in order to get a proper mixing ratio measurement, no matter if you are using an open or a closed path instrument.

However, the compensation strategy differs for the two different kinds of instruments. For open path systems, Webb et al. (1980, henceforth WPL) defined an *a posteriori* formulation to correct preliminary flux estimates. This formulation has been proven through theoretical and experimental validations. Thus, whenever open path analyzers are used, we recommend selecting *Webb et al. 1980 (open-path) / Ibrom et al. 2007 (closed-path)*. For closed path systems, instead, the correction can be applied *a posteriori*, using a revision of the WPL formulation specified by Ibrom et al. (2007b) (select the same option suggested for open path in this case), or *a priori*, by converting raw, high-frequency measurements from molar densities to mixing ratios (select the option *Use/convert to mixing ratio if possible (Burba et al. 2012)*. For closed path systems the two methods attain identical results, as demonstrated by Ibrom et al. (2007b) and Burba et al. (2012).

The main difference between the two options for closed path systems is that the *a priori* solution can only be applied if (a) raw data are already expressed as mixing ratios (e.g., LI-7200) or (b) raw data are expressed as molar densities and all necessary high frequency measurements are available to perform the point-by-point conversion (i.e., temperature, pressure and water vapor concentration inside the instrument cell). If any of these measurements are missing, the *a priori* method cannot be applied. On the other hand, the *a posteriori* method can be applied even if some data are missing, although in this case the density fluctuations will not be fully compensated.

** Note:** The *a posteriori* formulation implemented in EddyFlow differs from the one provided in Ibrom et al. (2007b) because it also includes the temperature and pressure terms neglected in that paper. This allows the method to be applied for closed path systems featuring a short sampling line, where it is not safe to assume effective attenuation of ambient temperature and pressure fluctuations.

** Note:** If the *a priori* method is selected but any necessary raw data are missing for any given flux averaging period, EddyFlow automatically switches to the *a posteriori* method.

In summary, here are our recommendations:

1. For open path eddy covariance systems, always select the option *Webb et al. 1980 (open-path) / Ibrom et al. 2007 (closed-path)*.
2. For closed path eddy covariance systems where raw data are available as accurate fast mixing ratios (e.g. LI-7200), always select the option *Use/convert to mixing ratio, if possible (Burba et al. 2012)*.
3. For closed path eddy covariance systems where raw data are available as accurate fast mole fractions and water vapor mole fractions are also available in the raw files, always select the option *Use/convert to mixing ratio, if possible (Burba et al. 2012)*.
4. For closed path eddy covariance systems where raw data are available as molar densities and water vapor mole fractions, and fast cell temperature and pressure are also available in the raw files, select either *Use/convert to mixing ratio, if possible (Burba et al. 2012)* or *Webb et al. 1980 (open-path) / Ibrom et al. 2007 (closed-path)*.
5. For closed path eddy covariance systems where raw data are available as molar densities and water vapor mole fractions, and fast cell temperature and pressure are also available in the raw files, select either *Use/convert to mixing ratio, if possible (Burba et al. 2012)* or *Webb et al. 1980 (open-path) / Ibrom et al. 2007 (closed-path)*.
6. For closed path eddy covariance systems where raw data are available as molar densities, but either water vapor mole fractions or fast cell temperature or fast cell pressure is missing in the raw files, select *Webb et al. 1980 (open-path) / Ibrom et al. 2007 (closed-path)*.

## Add instrument sensible heat components (LI-7500)

Select this option if your concentration measurements were performed with an open path LI-7500 instrument, or with an LI-7500A/RS used in the ** summer ** configuration and your data were collected in a very cold environment. This correction becomes increasingly important as the typical temperature at a site gets lower. You can customize the regression parameters if specific experiments have been conducted to optimize the correction for your instrument unit and system configuration. Otherwise, we suggest using default parameters as retrievable with the *Restore values as from Burba et al. (2008)*.

## Tapering window

Tapering is a data conditioning procedure necessary before the Fourier transform of a finite, non-periodic time series can be taken. Several tampering windows are available. Kaimal and Kristensen (1991) suggested the selection of the *Hamming* window in the context of environmental turbulence.

** Note:** The differences introduced by different windows are minor in the calculated spectra, while there is no effect on fluxes, which are calculated before applying the tapering procedure.

## Quality check

The different flagging systems available are based on the results of the same quality tests, namely the steady state test and the well-developed turbulence test (e.g., Foken et al., 2004). The two tests provide individual flags (that can be output separately by selecting the option *Details of steady state and developed turbulence tests* in the ** Output Files ** page), which can be combined in different ways. The option *Mauder and Foken (2004) (0-1-2 system)* provides the flag "0" for high quality fluxes, "1" for intermediate quality fluxes and "2" for poor quality fluxes. This system is suitable for selecting flux results complying with international practices (e.g., FLUXNET). The other 2 systems provide finer flux flagging for more in depth analysis. Thus, the choice depends on your intentions.

** Note:** This option has no impact on calculated fluxes.

## Footprint estimation

Three one dimensional (crosswind-integrated) footprint estimation methods are available, which can provide rather different results. The methods of Kormann and Meixner (2001) and Hsieh et al., (2000) provide closer results to each other, compared to the method of Kljun et al. (2004). However, this is partially a consequence of the similarities in the formulation and starting assumptions of the two methods compared to the third one. We do not endorse either method. Read the corresponding literature to select the most appropriate method according to your site conditions.

## Low frequency spectral correction

We suggest applying this correction in all cases.

## High frequency spectral correction

We suggest applying one of the high frequency correction methods in any case. Here we summarize our recommendations on which method to select in different conditions:

1. Open path systems: any method is valid, however, the methods of *Moncrieff et al. (1997) – Fully analytic* and *Massman (2000, 2001) - Fully analytic* allow faster data processing and can be applied to datasets of any length (even just 1 raw file), because the corrections do not rely on the *in situ* assessment of the EC system filtering properties.
2. Closed path systems with very short (e.g., 50 cm) and/or heated and insulated sampling lines (to keep relative humidity very low) and without fine-mesh inlet filters (e.g., 1 μm mesh): in these conditions any method is valid. Similar to case (1), the methods of *Moncrieff et al. (1997) – Fully analytic* and *Massman (2000, 2001) - Fully analytic* provide faster data processing and can be applied to datasets of any length. The other three methods potentially provide a better representation of attenuations induced by the EC system and are thus more suited, but they require a dataset large enough (e.g., 1 month) for the assessment of the system cut-off frequency.
3. Closed path systems with longer sampling lines (> 1m) or featuring fine mesh inlet filters, but still heated and insulated (to keep relative humidity very low). In these cases, the methods *Horst (1997) – Analytic with in situ parameterization*, *Ibrom et al. (2007) – in situ/analytic* and *Fratini et al. (2012) – in situ/analytic* are more suitable because the other two methods do not account for the effects of inlet filters and potentially underestimate attenuations induced by the passage in the sampling line.
4. Closed path systems with non-heated/insulated sampling lines of any length, with or without inlet filters: if water vapor is of interest, in these conditions we suggest applying a correction of *Fratini et al. (2012) – in situ/analytic* or *Ibrom et al. (2007) – in situ/analytic* because these are designed to account for effects of relative humidity on water vapor in the sampling line. If water vapor is not of interest, the method *Horst (1997) – Analytic with in situ parameterization* is also appropriate.

## Correction for instrument separations

This additional spectra correction component is only available when the method of Ibrom et al. (2007) is selected. The reason is that the other two high frequency correction methods available intrinsically account for the instrument separation. The method of Ibrom et al. (2007) is mostly aimed at correcting for the attenuation of power spectra in closed path systems. Normally, the inlet of the sampling line of a closed path instrument is placed so close to the sampling volume of the anemometer, that one may consider the "instrument separation" not influential. However, for the sake of generality and because in EddyFlow the method can be used also for open path systems, the option is provided to correct for the instrument separations, according to the method proposed by Horst and Lenschow (2009). This method is available in two configurations:

1. If you compensate time lags through a method that uses the covariance maximization procedure, this implicitly takes care of the along-wind instruments separation, so you may select the option *Horst and Lenschow (2009), only crosswind and vertical*.
2. In all other cases or in any case if the instruments are separated by a relevant distance (depending on the height above the ground) select the option *Horst and Lenschow (2009), along-wind, crosswind and vertical*.
