---
title: "What's New"
source_url: "https://www.licor.com/support/EddyPro/topics/whats-new.html"
---
# What's new in this version

## .9 (current version; 2022-01-27)

Engine:

- Fix: Additional updates to usage of dynamic metadata.
- Fix: Writing of FLUXNET output in RP when "not_enough_data" (i.e., only biomet to be written).

GUI

- Fix: Output format not reset when restoring advanced default values.

## .8 (2021-11-22)

Updated end-user license agreement (EULA) privacy policy.

## .7 (2021-04-16)

Engine:

- Refine: Improved detection of Spectral Assessment file when running in embedded mode (SmartFlux).
- Refine: Add variable CP (specific heat at constant pressure) to FLUXNET output.
- Fix: Fix usage of dynamic metadata "file_length" and "ac_freq".
- Fix: Harmonize Full Output and FLUXNET output for footprint model selection.
- Fix: Implementation of Horst and Leschow 2009 now use Eq. 16 instead of Eq. 13. Thanks M. Aubinet for the notification!
- Fix: Eliminated spurious Potential Radiation offset.
- Fix: Reporting QC flags in the FLUXNET output when using FCC executable.
- Fix: Header error with custom variables when using FCC executable.
- Fix: Reading full cospectra files when using the Fratini et al. 2012 spectral correction method.
- Fix: Planar fit settings when planar fit fails for a sector.

GUI:

- Fix: Magnetic declination retrieval from NOAA.
- Fix: Timelag optimization dialog not reloading correctly settings for maximum values of searching windows.
- Change: Added handling of "SWIN", "SW_IN", and "LW_IN" biomet variables.
- Change: Changed checkbox label for spike removal in advanced settings for statistical analysis.

## .6 (2019-12-18)

Engine:

- Fix: ET unit in the standard output changed from [mm] to [mm/h].

GUI

- Fix: Issue using Metek Classic A anemometer.
- Fix: Loss of random uncertainty values while importing project files from past versions.
- Fix: Improved look and feel on macOS Mojave.
- Fix: Corrected 404 on video tutorials link.
- Change: Scrolling behavior of metadata editor tables.
- Change: Restyle tables.
- Change: Removed obsolete forum links.

## .4 (2019-06-25)

Engine

- Add: Data filtering tool to eliminate raw records corresponding to instantaneous wind directions from specified sectors (under ** Basic Settings > Select Items for Flux Computation > Wind Filter **).
- Add: New output file conforming to FLUXNET and AmeriFlux's FP-In Standards for labels, units, and format. FLUXNET output features a large amount of new output variables, including many intermediate results, statistics on all high-frequency variables, covariances between all high-frequency variables, biomet mean values and metadata, as well as results of new implementations.
- Add: Stationarity test after Mahrt (1998).
- Add: Random Uncertainty estimation method after Mahrt (1998).
- Add: QC test named KID (Kurtosis Index on Differenced variable) test (Vitale et al., in preparation).
- Add: Test to identify period of repeated data and drop-outs (Vitale et al., in preparation).
- Add: new supported anemometers: Metek uSonic-3 Class A MP and Metek uSonic-3 Cage MP.
- Add: Computation of wind direction variance.
- Add: ET is now treated as a first-class flux (results only available in FLUXNET output).
- Refine: Improve computation of statistical moments which is now fully robust to the presence of missing data.
- Refine: More accurate computation of mean wind direction.
- Refine: Potential Radiation is now computed using timestamp of END of period instead of START.
- Remove: Obsolete GHG-Europe and AmeriFlux outputs.
- Refine: Changed sign (+/-) of Tau reported in data outputs from negative to positive to conform with network standards.
- Refine: The footprint computation will no longer automatically switch between models when the selected footprint model cannot be applied.
- Refine: Reduced the number of significant digits recorded in processed data. Reduces size of output files.

GUI

- Add: Fluxnet output settings.
- Add: Visual tool for wind directions filtering settings to specify up to 16 sectors.
- Add: Random uncertainty estimation method after Mahrt (1998).
- Add: New supported anemometers: Metek uSonic-3 Class A MP and Metek uSonic-3 Cage MP.
- Change: Move random uncertainty settings from [RawProcess_RandomUncertainty_Settings] to [Project] managing backward compatibility.
- Remove: Obsolete GHG-Europe and AmeriFlux outputs.
- Remove: Previous data results setting.

## Version 6.2.2 (2018-05-20)

Engine

- Add: Support for RM Young 81000V, 81000RE, and 81000VRE anemometers.

GUI

- Add: Support for RM Young 81000V, 81000RE, and 81000VRE anemometers.
- Add: References to Tovi software.
- Fix: Raw File Settings persistence.
- Fix: Local help not showing.

## Version 6.2.1 (2017-10-09)

Engine

- Add: Support for new LI-7500DS instruments.

GUI

- Add: Support for new LI-7500DS instruments.
- Fix: Magnetic declination retrieval from NOAA.

## Version 6.2.0 (2016-08-23)

Engine

- Add: New supported variable "anemometer_diagnostic". If selected, it filters anemometer data if the diagnostic value is different from zero.
- Add: Now biomet variables that are provided without positional qualifiers are by default given a "null qualifier" in the form of _0_0_n, with n progressing from 1. This applies now also to external biomet files, which means that users no longer need to assign 'fake' positional qualifiers to variables.
- Add: Support of Gill WindMaster and WindMaster Pro "w-boost" correction, necessary to fix firmware bug for firmware versions: [2329.x.y with x<700].
- Refine: AoA correction policy. Now Nakai et al. 2006 is applied only to R3 family and R2. Nakai and Shimoyama 2012 is applied to WindMaster and WindMaster Pro. The combination of "w-boost" and AoA correction for the WindMaster/Pro is handled automatically by EddyFlow. Effectively, the user has the options of (1) applying or not the w-boost correction alone for WindMaster/Pro; (2) applying or not Nakai's AoA corrections. However, EddyFlow controls that both corrections are applicable to the current anemometer and overrides user's settings (and outputs corresponding warnings) if necessary.
- Refine: Now planar fit settings are not read if planar-fit file is used. The useless reading operation did not cause any problems.
- Refine: Changed "time lag" into "time-lag" everywhere.
- Fix: Shut down BA/ZOH correction, which is currently implemented but not exposed via the GUI.
- Fix: Kelvin/Celsius conversion factor harmonized everywhere (273.15 instead of some occurring 273.16)
- Fix: Now biomet data is not read in during planar fit (which was never useful anyway) and this fixes an array allocation issue that was causing a crash when both planar fit and biomet data were used.
- Fix: Eliminate 'allocatable' property for TempFact in drift_correction.f90, which is, however, not yet enabled and therefore it was causing no issues.
- Fix: Missing time-lag optimization file when requested caused tilt correction method to be set to non-existent value and thus default to no correction.
- Fix: Flags for absolute limits are now correctly calculated. Flags for this test obtained so far are unreliable.
- Fix: Output of full (co)spectra. The bug was such that there was a misalignment of one data point between frequencies and associated (co)spectra values. The bug did not affect calculation and output of binned cospectra, nor usage of full cospectra in spectral corrections.
- Fix: Now files with timestamps referring to end of the dataset are processed correctly. The bug did not allow processing them in rather unusual (but not impossible) situations, such as when files shorter than the flux averaging interval were processed.
- Fix: Handle inconsistent selection of embedded biomet data and non-GHG file type. This pair of inconsistent settings is not possible with the GUI, only with manual editing of the .eddypro file.
- Fix: Definitions of ** Hamming and Hann ** windows were mistakenly inverted. Now they are correct. The difference between the two windows is minimal and resulting binned (co)spectra are thus only minimally affected, and only at the low frequency end.

GUI

- Fix: Make non blocking a zero flow rate gas analyzer description.
- Fix: Make sure that an ignored variable in the metadata raw file description table has almost all the fields disabled.
- Fix: toolbar with no labels in initial maximized state.
- Fix: inconsistent value of the "data set available" date on the "detect range" dialog that shows when running in advanced mode.
- Refine: Make sure that on Mac it is possible to load any kind of external biomet files.
- Refine: Remove italic from anemometer firmware version.
- Refine: Trim spaces reading variables in external biomet files.
- Add: Set the Angle of Attack checkbox default setting to disabled.
- Add: "Build Continuous Dataset" to the Minimal Advanced Output Settings (the current default).
- Add: some textual hints in the metadata tables.
- Add: Accept Gill WindMaster/Pro two or three fields firmware versions.
- Add: Change max plausibility range from 12 to 20 sigma as per user request.
- Add: Enable drag and drop tips on Windows.
- Add: the registered trademark symbol to the main window title.
- Add: ** Master Anemometer Flags ** combo in Basic Settings page.
- Add: support for Campbell CSAT-3B.
- Add: Raise variable flags decimals from 4 to 10 digits.
- Add: Make anemometer firmware version mandatory for Gill WindMaster/Pro.
- Add: checkbox for Gill's w-boost bug.

## Version 6.1.0 (2015-12-14)

Version 6.1.0 is a minor update with bug fixes and refinements.

** Engine bugs fixed **

- FLUXNET biomet output file now contains biomet results also when fast EC data are not available (similar to standard biomet output file). Also fixed initialization, so that if biomet data are not available, FLUXNET biomet output file reports -9999.
- Detection of EndIndex in the list of binned spectra files when a subperiod is selected, which coincides with the period covered by available spectra files. The bug caused EddyFlow to not create ensemble averaged spectra/cospectra, nor to perform the spectral assessment.
- SplitCount function, that caused biomet files not to be properly read (and engine to crash) when only one biomet variable is present in the external biomet files, besides the timestamp(s).

** Engine refinements **

- Added support for new LI-7500RS and LI-7200RS instruments.
- Introduced a mechanism to allow user to ask EddyFlow to select the most appropriate Angle of Attack (AoA) correction method, based on sonic anemometer model and firmware version. User can also force a selection or disable the correction completely.

** GUI refinements **

- Added support for new LI-7500RS and LI-7200RS instruments.
- Added automatic selection for the AoA correction method.
- Set the default AoA correction method to automatic selection.
- Added embedded software version (firmware) field in the anemometer description table in the metadata editor.
- Enabled embedded software version (firmware) field for any gas analyzer and changed it to a free text form.
- Allowed project file opening with double-click on Mac.

** GUI bugs fixed **

- Spectral file assessment load button not working properly.
- Essential file path not properly preserved during a run on Windows.

## Version 6.0.0 (2015-08-01)

Version 6 is a major release with a number of new features and improvements that enhance the utility of the software for web applications.

** New Features **

- Mac OS 10.10 version

** Engine bugs fixed **

- Improved retrieval of dynamic meta data.
- Missing array allocation reported by Sebastien Lafont (INRA, France). Thanks for reporting this issue!
- Bug that caused processing to stop under some temperature measurement configurations.

** Engine refinements **

- Criteria for (co)spectra filtering are now explicitly set by the user.
- Settings for (co)spectra filtering are now independent from the selection of the spectral correction method and are the same for ensemble averaging, model fit and discrimination between model and direct method in spectral correction after Fratini et al. (2012).
- Improved support for biomet data.
- Biomet data time is derived from the file, rather than the file name.
- Improved automatic testing of file names.
- Improved subperiod handling. Now, when both 'Select a sub-period' in Basic Settings and 'Build continuous dataset' in Outputs are selected, all output files will span the selected time period regardless of the period covered by raw data files.
- Improved alignment of biomet data and flux results. Now biomet output and full output always span the same time period. However, alignment row-by-row is guaranteed only when option 'Build continuous dataset' is selected. Otherwise, alignment will depend on data availability.
- Empty spaces in labels of custom variables are replaced with underscore (_) characters.
- Improved despiking of Vickers and Mahrt (1997) against error values in raw data.
- Now WPL interface only allows selection of "on" or "off." The way it is applied is determined automatically depending on open- or closed-path analyzer, the type of concentration data, and the availability of other high-frequency data.
- Added support for longer file names and file paths.
- Test variable number, order, and units of biomet files. If they do not match between files, EddyFlow stops using biomet data.
- Improved plausibility checking of some variables, such as canopy height, altitude, and more.
- Added suffix to output file names, indicating if processing was in Express (exp) or Advanced (adv) mode.
- Added despiking method of Mauder (2013) as an alternative to the method of Vickers and Mahrt (1997).
- Ensemble averaged spectra output also includes de-noised spectra. If noise elimination was not selected, de-noised spectra are equal to the original spectra.
- Improved "Missing Sample Allowance" to include individual variables, in addition to null records.
- Linear detrending time constant set automatically to the flux averaging interval.
- GHG-Europe output now complies with new specifications of AmeriFlux and European Carbon databases. EddyFlow creates two files—eddy covariance results and biomet results. Both can be submitted directly to the databases.
- Binned (co)spectra filtering based on results of micro-meteorological tests. Users can select whether to discard (co)spectra when the corresponding period is flagged as moderate or low quality.
- More explicit start/end period selection when importing binned cospecta files.

** GUI (Graphical User Interface) additions **

- Implemented drag-and-drop capabilities in supported operating systems,
- Improved guided mode messages to indicate implausible sensor separation values and flow rates.
- Added option for "Ensemble Average Spectra" in outputs.
- New setting for (co)spectra filtering according to Mauder and Foken, 2004.
- Many other minor additions.

** GUI refinements **

- Set maximum missing samples allowed to 40%.
- Improved spectral analysis settings.
- Improved update notification regarding SmartFlux System updates.
- Additional minor improvements.

## Version 5.2.1 (2015-01-29)

Version 5.2.1 is a minor update with bug fixes and a refinement.

** Engine bug fixed **

Bug causing the engine to hang before run completion if no averaging period could be processed completely. The bug was unlikely to affect EddyFlow desktop users, but could at times show up in the SmartFlux System.

** GUI refinement **

Added ** Save ** and ** Continue ** buttons to Spectral, Planar fit and Time lag assessment files testing dialog.

** GUI bugs fixed **

- Time lag assessment file testing crash in case of missing RH classes
- Planar fit assessment file testing too restrictive
- Fourth gas molecular weight and diffusivity automatic management
- Magnetic declination retrieval from NOAA website was broken due to changes in the website response

## Version 5.2

Version 5.2 is a minor update with bug fixes, refinements, and a few new features.

** New features **

- Implementation of assessment tests for ancillary files (spectral assessment, planar fit, and timelag optimization).
- Analytic spectra correction after Massman (2000, 2001).
- Biomet data are output for periods when corresponding high-frequency data are not available or are corrupted.
- Option to run engine with command-line specified .eddypro file (full path). See help for usage (run "$eddypro_rp -h").
- eddypro_rp now edits .eddypro file, so that eddypro_fcc can be launched when eddypro_rp completes, without further interventions. This improves portability and facilitates usages from command line and automation.

** Engine bugs fixed **

- Bug that caused duplicated biomet outputs when raw biomet data are missing.
- Bug causing off-season uptake correction to switch to 'simple linear' and stick there, if radiation measurements were missing for just one half-hour.
- Management of external biomet files (1 file, files in folder, 1 minute time-step).
- Bug causing TOB1 files without header (rare case) to be deleted from the data folder, if they happened to contain less data than expected.
- Bug causing soil temperature not to be duly treated as a biomet variable.
- Call to CorrectionFactorsIbrom07 in BPCF_Fratini12. The wrong call prevented use of backup solution (Ibrom model) in periods of too-low fluxes. So, the correction was always using the direct method of Fratini et al. 2012, also in low-flux conditions.
- Functioning of metadata retriever, that got broken after refactoring for 5.0.
- Footprint model of Kormann and Meixner 2001, as implemented in 'eddypro_fcc' (no corresponding bug in 'eddypro_rp').
- Bug causing cross-wind correction to be applied to 'fast temperature' measurements, but only if those were used in conjunction with an R2 anemometer.
- Exit condition for subs importing ASCII data. Was crashing in some conditions, if a file contained more records than expected.
- Module call to m_common_global_var in RenameTmpFilesCommon. The bug was not causing problems because the same module is called by the module that was mistakenly called.
- Fixed issue that caused biomet output files to be duplicated in some circumstances.

** Engine refinements **

- Eliminated squared root operating on the transfer function H, in Fratini et al. (2012) spectral correction method. This refinement shall be made publicly available in the form of a corrigendum to the paper. Thanks a lot to Johannes Laubach for suggesting the change, demonstrating its foundation and verifying the new implementation in EddyFlow!
- Refined format of GHG-Europe output file after specifications from European Database managers.
- In timelag optimization session and in main raw data processing session, moved call to retrieve_sensor_params before time-lag estimations to have instruments properties available for refined "starting time-lags" definition.
- Moved 'normal exit instruction' in all subs importing raw data, in such a way that the exception of reaching the end of the file is caught in most (possibly all) occasions.
- Implementation of random error after Finkelstein and Sims (2001): Improved code quality and readability and improved speed in calculating the ITS.
- Revised retrieval of files in list, to safely skip files that do not comply with the raw file name format.
- Eliminated N = N - 1 at the end of sub ReadSLTEddySoft.
- Completely rewritten subroutine to import full cospectra and modified approach in FCC to get the size of cospectra from the first file instead of allocating in advance.
- Improved control over missing lines, with an additional control after statistical screening, so that period is skipped if not enough data remain after the screening, also including native missing data such as -9999.
- Improved format and function calls related to exception handling and corresponding output messages.
- Simplified ShowDailyAdvancement and introduced advancement marks on output, to allow for GUI estimates of processing time.
- Revised the text displayed when running engines with option -h.
- In "filelist_by_ext", anticipated exception handling if no files are found in folder.
- Proper setting of FileEndReached in ReadSLTEddySoft and ReadSLTEdisol.
- Adjusted algorithms to calculated default timelags, which now include "tube time", "cell time" and a "safety margin".
- Eliminated useless "+1" on both sides of a "greater than" test, in subs importing all binary files (TOB1, generic binary).
- Removed the usage of auxiliary folder ..\\mod in both RPP and FCC projects, to ease and streamline the port to other OS.
- In case of space separation in raw file with non-numeric field, defaults to considering multiple consecutive separations as only one.
- Calculation of cutoff frequencies and dependence cutoff/RH when data for very few RH classes are available.
- Moved definition of 'null' spectra from fx to common module.
- Moved function NameMatchesTemplate into src_common/dir_sub.f90 file.
- Eliminated useless "+1" on both sides of a "greater than" test, in subs importing SLT files.
- Eliminated useless output 'Verifying time series integrity' during planar fit data import.
- Corrected the spelling of subroutine ShrinkString.

** GUI bugs fixed **

- Improve information available in Run page (for example, show warnings and errors, computation time estimates, etc.).
- Improve progress bars in Run page.
- Add separation of standard variables and custom variables in the ** Metadata Editor **; ** Raw File Description **. Provide a ** Clear ** button for the ** Custom ** variables.
- Fix minor bugs.

** GUI refinements **

- Integrate Massman 2000/2001 correction.
- Implement testing of ancillary files (Spectral correction, Planar fit and Time lag optimization) at loading time.
- Add a dialog to inform about the Angle of Attack automatic selection.
- Added an 'Open output directory' button in Run page.
- Added keyboard shortcuts to navigate between pages (Alt+1...Alt+5).

## Version 5.1.1 (2014-03-14)

Version 5.1.1 is a minor update with bug fixes and refinements.

** Engine bugs fixed **

- Bug causing EddyFlow to ignore the next raw file when current file is shorter than expected.
- Bug causing 'full co-spectra' files not to be read in 'eddypro_fcc'.

## Version 5.1.0 (2014-01-29)

Version 5.1.0 is a minor update with bug fixes and refinements.

** Engine bugs fixed **

- Import of TOB1 files, now avoids copying the same TOB1 file multiple times and speeds up processing of long TOB1 files (typical use case).
- Bug that was causing storage fluxes to be identically zero in most use cases.
- File in src_common was importing module rp-related (did not cause computation issues).

** Engine refinements **

- Modified Absolute Limits Statistical test defaults as follows: Minimum sonic temperature set to -40 °C (was -20 °C).Maximum CO2 set to 900 ppm (was 600 ppm)
- Fixed ranges of accepted biomet values:Changed minimum ambient pressure to 40 kPa (was 80 kPa).Made all interval min/max closed instead of open, most importantly for RH, to include values of 0 and 100.
- Optimized the output time stamp in case of shorter-than-expected raw files.

** GUI bugs fixed **

- Improved computation progress bar to represent progress more accurately.
- Decimal digits of the 4th gas molecular values were lost in the Basic Settings page when saved.

** GUI refinements **

- Improved information available in Run page.
- Added default button selection to SmartFlux System package dialog.
- Modified absolute limits statistical tests as described above.

## Version 5.0.0 (2013-12-09)

EddyFlow Version 5.0 introduces the SmartFlux System configuration file creator.

** GUI**

- Implemented SmartFlux System bar and file package creation buttons.
- Removed "Number of files to merge" control.
- Removed "Gas analyzer height" from Metadata editor.
- Introduced "Open Sans" font.

** Engine bugs fixed **

- Bug causing crash on short raw files.
- Software not reading strings longer than 200 characters in `.eddypro ` file.
- Potential problems with timestamps in non-ISO format.
- Crash if last raw file of the dataset is not a valid one (too short, invalid header, etc.).
- Bug causing the software not to process correctly averaging intervals shorter than file length in certain circumstances.
- Use dynamic metadata files. Same variables as usual, but now full independence of processed time period from definition of dynamic metadata dates.
- Bug causing the spectral correction of Fratini et al. (2012) to virtually always use the fallback solution (model) rather than the direct method (thanks Olli Peltola and Ivan Mammarella!).
- Bug causing the spectral assessment to fail if a large number of spectra files were to be used.

** Engine refinements **

- Changed units of ET fluxes in the full output file. New units are mm+1hour-1.
- Changed Express settings. Cross-wind correction is no longer applied by default.
- Exception handling with SLT-EdiSol files if header reports implausible record length.
- Merged and simplified spectral correction code.
- Period to be processed extended to include the very last averaging interval, which was excluded from the automatic selection of start&end date performed in the GUI.
- Initialization of stats and their values when variables are missing.

** Engine new features **

- Creation of unique temp folder for allowing parallel runs.
- Possibility to process indefinitely long raw files. Possibility to process datasets for multiple years in one session.
- Smart understanding of initial timestamp in the dataset.

## Version 4.2.1 (2013-10-03)

** GUI improvement **

EddyFlow update 4.2.1 is a minor update that fixes a GUI bug related to the retrieval of declination correction for magnetic north from the U.S. National Oceanic and Atmospheric Administration (NOAA) website. The update corrects an error that occurs when the website is unavailable.

## Version 4.2 (2013-08-22)

EddyFlow update 4.2 is a minor update that includes several bug fixes and improvements to the processing engine and graphical user interface (GUI), including:

** Engine improvements **

- Fixed use of "Flags" (set in the "Basic Settings" page) for filtering out individual raw data records.
- Fixed import of SLT-EddySoft raw files featuring low-resolution data.
- Fixed formulation of tube transfer function for laminar regimes and—only in FCC—for turbulent regimes.
- Fixed problem with [references.html#Fratini2012](references.md#Fratini2012)[Fratini et al. 2012](references.md#Fratini2012) spectral correction giving NaN in cases of high fluxes.
- Fixed bug in the running mean and exponential running mean detrending algorithms.
- Fixed bug in planar fit with no velocity bias that caused rotations not to be performed.
- Fixed bug in time lag optimizer causing a crash.
- Fixed initialization of footprint results for [Kormann and Meixner (2001)](references.md#Kormann) and [Hsieh (2000)](references.md#Hsieh) models.
- Fixed labels of custom variables in full output, when created by FCC program (added "_mean" padding to each variable name).
- Fixed management of missing variables when passing from raw processing engine to FCC.
- Fixed the use of flow rate from raw data files when available, with both .ghg and non-.ghg files, if time lags are not explicitly set by user.
- Fixed bug that caused mismatch in full output headers when advanced processing settings were used.
- Fixed missing LI-7700 CH4 flux output in full output file when data is screened using LI-7700 Diagnostic Value.
- Fixed wind coordinates rotation when AXIS configuration (Gill anemometers) or R2 anemometer is selected, for Angle of Attack correction.
- Added ET (evapotranspiration flux, in mm) to full output results.
- Added optional crosswind correction of sonic temperature for Gill WindMaster™ and WindMaster™ Pro anemometers (needed for type 1352, not for types 1561 or 1590).
- Refinement: extended range of accepted ambient pressures, now the minimum value accepted by EddyFlow is 40 kPa, which replaces the former value of 80 kPa.
- Refinement: when running in Express mode, the default version of the Angle of Attack correction depends on the anemometer model (Nakai et al. 2006 for R3 and R2).
- Refinement: increased resolution of footprint results, from 5 to 1 meter, [Kormann and Meixner (2001)](references.md#Kormann) and [Hsieh (2000)](references.md#Hsieh) models.
- Refinement: support for TOB1 files with no header lines (explicit user specification of variable types 'IEEE4' or 'FP2' is needed).
- Refinement: inverted time lag compensation and tilt correction procedures.
- Refinement: stationarity test evaluated after time lag compensation and tilt correction.
- Refinement: minor modifications to QC flags to better match flag definitions according to TK3 approach (M. Mauder, personal communications).
- Refinement: resolving to the Integral Turbulence Time Scale simple definition from [Billesbach (2011)](references.md#Billesbach1) if direct calculation fails.

** GUI improvements **

- Fixed behavior of North alignment for Generic Anemometer in the Metadata Editor
- Fixed bug that caused the default Angle of Attack to override user selection when re-opening a saved project.
- Fixed flags threshold and policy persistence when re-opening a saved project.
- Fix bug that prevented overriding "Lowest noise frequency" settings.
- Fixed overwriting of the anemometer user selection on the Basic Settings page in case of multiple anemometers.
- Fixed bug that prevented undue field persistence when changing units of the input in the Metadata Editor.
- Fixed Magnetic Declination fetching not working properly due to NOAA website changes.
- Refinement: Added dialog when clearing the raw data directory.
- Refinement: Modified raw file name format displayed in the corresponding dialog.
- Refinement: Permitted negative altitudes in Metadata Editor
- Refinement: Improved Metadata Editor stability.
- Refinement: Added Gain-Offset automatic selection in the Metadata Editor.
- Refinement: Added colors to variables ignored or not numeric in the Metadata Editor.
- Refinement: Disabled unnecessary fields and set Ignore to "yes" in case of non-numeric variables in the Metadata Editor.
- Refinement: Prevented column selection bug in metadata tables that triggered first row editing.
- Refinement: Ctrl+mouse-wheel resizes the GUI main window.
- Refinement: Disabled Ctrl+F12 shortcut to launch the program.
- Refinement: Cross-wind correction checkbox is always enabled, though checked as suggestion when needed.
- Refinement: Changed Angle of Attack correction policy with Gill anemometers.
- Refinement: Increased absolute limits ranges for statistical test on gases.
- Refinement: Changed policies to update software, project and metadata file versions at saving time.
- Refinement: Custom variables created in the file description table of the Metadata Editor will be permanently available in the local computer for future uses.

## Version 4.1 (2013-01-01)

EddyFlow version 4.1 introduced 2 new major data processing options, completed a few features already drafted in version 4.0, and fixed a number of bugs found in version 4.0. The improvements in this version include:

** New features **

- Spectral correction scheme, implemented after [Fratini et al. (2012)](references.md#Fratini2012), specifically designed for closed-path systems, but applicable to any eddy covariance setup.
- New Angle of Attack correction algorithm from [Nakai and Shimoyama (2012)](references.md#NakaiandShim2012).

** Improvements **

- Use of previous results to dramatically reduce program execution time.
- Express processing uses the new Angle of Attack correction algorithm from [Nakai and Shimoyama (2012)](references.md#NakaiandShim2012) rather than the correction from [Nakai et al. (2006)](references.md#Nakai) used in previous versions.
- Support for binary SLT files containing more than 6 variables.
- External biomet data files are no longer limited to 18,000 records.
- Renamed ** Dataset Selection ** page to ** Basic Settings ** page.

** Major bug fixes **

** Automatic time lag optimization **

- ** Bug description:** The bug was under the ** Automatic time lag optimization ** procedure (Advanced Settings > Processing Options > Time lag compensation). The bug is such that time lags assessed for H2O (if this gas is treated in flux computation) are erroneously used also for CO2 or CH4. Selection of an erroneous time lag results in flux underestimations: the more the used time lag deviates from the real one, the more fluxes are underestimated.
- ** Who is affected:** Anyone who used the ** Automatic time lag optimization ** option for flux computations in a previous version of EddyFlow is likely to be affected. However, the severity of the effects depends upon the gas analyzer in use. For open-path analyzers (e.g., LI-7500A), the bias if most likely negligible, if present at all. For enclosed-path analyzers (e.g., LI-7200), the bias is probably detectable but still negligible, because time lags of H2O do not deviate dramatically from those of CO2, especially if conditions of low relative humidity (<50-60%, typically during daytime). In such analyzers, effects are further minimized if a short (< 1 m) and/or heated or insulated sampling line was used. For closed-path analyzers with sampling lines longer than 2 m, (e.g., LI-7000 or LI-6262), the effects are likely to be relevant and we thus recommend that you recalculate fluxes using EddyFlow version 4.1.
- ** Who is not affected:** All users who ran EddyFlow in Express Mode or those who did not use the ** Automatic time lag optimization **.

** Note:** We recommend using the ** Automatic time lag optimization ** procedure especially for closed-path setups featuring medium and long (>3-4 m) sampling lines. The bug that affected this option is corrected in EddyFlow 4.1.

** Calculation of average CH** 4 ** mole fractions and mixing ratios from the LI-7700 **

- ** Bug description:** The bug prevented the band-broadening correction from being applied in the calculation of average CH4 concentrations. Note that this did not affect flux calculations, as the band-broadening correction is applied to fluxes separately in EddyFlow 4.0. The effects of this bug were visible especially in conditions of very low ambient pressure with respect to normal values.

** Other bug fixes **

- Fixed bug that caused the program to crash when the number of files selected for planar fit calculations were more than the maximum allowed (3,000). The bug was fixed and this maximum value was increased to 18,000.
- Fixed bug that caused the calculation of maximum wind speed to fail in cases in which raw data records have at least one wind component set to -9999 (EddyFlow's internal error code). Most often this bug resulted in a maximum wind speed of 17318.7 m/s, that was the result of wind speed calculated from 3 wind components set to -9999. This bug had no effect on fluxes.
- Fixed bug that caused the crosswind correction of sonic temperature to be calculated erroneously for individual data records that have any wind component set to -9999. This bug resulted in implausible values for sonic temperature and thus either in fluxes set to -9999, or to extremely spiky fluxes. Note that for most anemometers the crosswind correction is applied in the firmware, so there is no need to apply it at processing time with EddyFlow.
- Fixed bug that caused the header of "full output" file to be erroneous when using the option ** Use standard output format **.
- Fixed bug that caused the night-time/daytime indication in the "full output" file to fail in some circumstances.
- Fixed a bug in the ** Random uncertainty estimate **, that caused the software to crash with an "Out of memory" error message.

** GUI changes **

- Added a general ** Restore Default Values ** button to restore all the Advanced Settings to the Express (default) Settings.
- Added constraints between fields to help fill the ** Metadata File Editor ** tables.
- Improved management of previous versions of Project and Metadata files for backward compatibility.
- Added a Software Version field in the ** Metadata File Editor ** IRGA table.
- Added an automatic ** Detect Dataset Dates ** button for the raw data files.
- Prevented wheel mouse scrolling on setting controls.
- Improved management on low resolution displays.
- Added automatic saving when exiting sub-dialog.
- Fixed opening of associated .eddypro project files when double clicking the file.
- Added button to clear the output console.
- Improved guided mode information messages.
- Fixed many minor GUI bugs.

## Version 4.0 (2012-04-25)

EddyFlow version 4.0 introduced additional computation options that were limited in the earlier releases of the software known as EddyFlow 3.0 and EddyFlow Express. This version provides a wide variety of options that make it possible to compute eddy covariance fluxes using one of many established techniques.

** New features **

- Support for biomet data (biological and meteorological data) collected from ancillary sensors.
- Ensemble spectra, cospectra, modeled spectra, and ensemble spectra based on time period.
- New Metadata Retriever tool to compile all site metadata from .ghg files into a single metadata file that can be edited or viewed.
- Planar Fit tool customization with graphical controls.
- Time Lag Optimization tool now supports automatic time lag optimization to account for time lags.
- Random Uncertainty estimation tool.

## Version 3.0.1 (not public)

** Bug fixes **

- Fixed initialization of latitude, longitude, and altitude when using dynamic metadata.
- Fixed Kljun et al. (2004) Footprint Estimation: Now uses measurement height minus displacement height to compute footprint. Previously used measurement height.
- Fixed sampling line flow-rate calculation when average flow rate from high-frequency data is used to initialize nominal, minimum and maximum time lags.
- Dialog boxes: Fixed bug that caused dialog boxes to display default settings when a project is re-opened, even if the settings had been altered previously. This presented risk that a setting could be reset to the default if a user opened a dialog box and clicked OK while the incorrect settings were displayed, and subsequently saved the project.
- Other minor bug fixes. See EddyFlow® > Help > About > Changes for more information.

## Version 3.0.0 (2012-02-06)

** New features **

- Support for additional raw data file types, including ASCII Table, TOB1, SLT (EddySoft), SLT (EdiRe), Generic binary.
- Support for the "dynamic metadata," or site parameters that change over time.
- Support for other trace gases measured by an additional gas analyzer.
- Advanced processing options:
- Fully configurable statistical tests, including:
- Comprehensive output files, including

## 3.0.0 Beta (2011-12-14)

First public release of 3.0.0 Beta. This version introduced the Advanced Options for testing.

## 2.3.0 (2011-07-20)

** Major bug fixes **

- An error occurred in the calculation of corrected fluxes if the N2O analyzer was a closed-path one, while the CH4 analyzer was open-path or CH4 was not present at all. The bug resulted in corrected fluxes of N2O equal to -9999 (that is, if your N2O fluxes are not -9999, they are not affected by this bug).
- Definition of "relative separations". No impact on calculations, only on the output metadata.
- Control on use of cell temperature (fixed re-initialization of column information).
- In statistical tests (Spike count/removal and Amplitude Resolution/Drop Out) length of implied windows modified so as to scale with the length of the averaging period.

** Improvements **

- Handling of situations where H2O readings are not available (air density, momentum flux).
- Control over peculiar situations in Fluxes23 (WPL section).
- Introduced support for TOB1 format "FP2."
- Introduced detection of very implausible values in the raw files, and their substitution with error codes.
- Error codes in raw files (-9999) are no longer modified during conversions of raw units into EddyFlow units.
- Better handling of situation when all .ghg files have invalid metadata or are corrupted.
- Better handling of the computations exit codes.

## 2.2.0 (2011-06-20)

** Bug fixes **

- Fixed bug concerning fluxes calculated from CH4 and N2O mole fraction measurements from closed path systems. The bug affected also fluxes calculated with CO2 mole fractions, if the paired H2O was measured as either molar density or mixing ratio. In all cases, the bug resulted in flux values =-9999 (that is, if your fluxes are not -9999, they are not affected by this bug).
- Fixed Altitude field zeroing in the Metadata editor.
- Changed the docking policies of the Tips dock: now it's movable and floatable top and bottom and it could also be tabbed with the Console.
- Changed the dimension policy of the Tips dock: now it's expandable.
- Fixed misspellings.
- Used native dialog for the 'Save metadata as' button.
- GUI code cleaned up.

## 2.1.4 (2011-06-02)

- Fixed incorrect filtering of CH4 vars in the Processing page, in case of Generic gas analyzer.
- Added the Change Log file viewer in the About dialog.

## 2.1.3 (2011-05-31)

- Fixed the SoS to temperature conversion.
- More detailed diagnostic on the metadata file validation at console.
- Quality flags recalculated according to Mauder and Foken (2004), which should eliminate most (possibly not all) of the -9999 in the quality flags.
- Added CHANGELOG.txt to source and installer packages.

## 2.1.2 (2011-05-18)

- Fixed problem of Access denied authorization during the processing of the data.

## 2.1.1 (2011-04-26)

- Fixed typo about the unit of measure of the Raw Data Description table (umol/mol^3, instead of umol/m^3).

## 2.1.0 (2011-04-21)

- Optimized GUI for support of low resolution screens (up to 800x600 px).
- Rearranged widgets between Project page and Processing page (ID moved to Processing).
- Added input dialog for the ID field.
- Improved look and feel of Combo box and Spin box.
- Changed policies for scrollbar and scrolling behavior into the tables.
- Changed default value in some table fields.
- Changed from QByteArrays to QString where there is the possibility of weak conversions.
- Fixed selection of "None" variables into ** Processing Page ** combo's when there are already some variables selected.
- Updated the manual.

## 2.0.0 (2011-04-05)

- First public release of EddyFlow (Express version only).
