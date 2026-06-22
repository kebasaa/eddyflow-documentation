---
title: "Spectral Corrections"
source_url: "https://www.licor.com/support/EddyPro/topics/spectral-corrections.html"
---
# Spectral corrections

![](../assets/Adv_Settings_SC.png)

Spectral corrections are needed to correct flux estimates for low and high frequency losses due to the instrument setup, intrinsic sampling limits of the instruments, and some data processing choices. For a detailed description, see [Spectral corrections](advanced-settings-spectral-corrections.md#top).

## Low frequency range

** Analytic correction of high-pass filtering effects:** Check this option to apply a correction for flux spectral losses in the low frequency range, due to the finite averaging time and dependent on the detrending method selected. The correction is implemented after [Moncrieff et al. (2004)](references.md#Moncrieff2).

## High frequency range

### Correction of low-pass filtering effects

** Method:** Check this option to apply a correction for flux spectral losses in the high frequency range, and select a method. For open path systems and for closed-path systems with very short and heated sampling lines, all methods are similarly valid. The methods by Ibrom et al. (2007) and Fratini et al. (2012) are the most appropriate for non-heated and/or long sampling lines. See [Low-pass filtering correction](low-pass-filtering.md#top).

- ** Moncrieff et al. (1997) **: This method models all major sources of flux attenuation by means of a mathematical formulation. The use of this method is suggested for open path EC systems or for closed path systems if the sampling line is very short and heated. This method may seriously underestimate the attenuation (and hence the correction) - notably for water vapor - when the sampling line of a closed-path system is long and/or not heated, because of the dependency of attenuation of H2O on relative humidity.
- ** Massman (**** 2000 **, 2001 **):** This method provides a simple analytical expression for the spectral correction factors. The use of this method is suggested for open path EC systems or for closed path systems if the sampling line is short and heated. This method may seriously underestimate the attenuation (and hence the correction) for water vapor, when the sampling line is long and/or not heated, because of the dependency of attenuation of H2O on relative humidity. For closed-path systems, this method is only applicable to CO2, H2O, CH4, N2O and O3 fluxes.
- ** Horst (1997) ****:** Correction method based on an analytical formulation of the spectral correction factor that requires an in-situ assessment of the system's cut-off frequency. Provide the settings in the *Assessment of high-frequency attenuation* to specify how to perform the assessment.
- ** Ibrom et al., 2007 ****:** Correction method based on an analytical formulation of the spectral correction factors, that requires an in-situ assessment of the system's cut-off frequencies, separately for each instrument and gas, and as a function of relative humidity for water vapor. Provide the settings in the *Assessment of high-frequency attenuation* to specify how to perform the assessment. This method is recommended in most cases, notably for closed-path systems placed high over rough canopies.
- ** Fratini et al., 2012 ****:** Correction method based on the combination of a direct approach (similar to Hollinger et al., 2009) and the analytical formulation of Ibrom et al., 2007. It requires an in-situ assessment of the system's cut-off frequencies, separately for each instrument and gas, and as a function of relative humidity for water vapor. It also requires full length co-spectra of measured sensible heat. This method is recommended in most cases, notably for closed-path systems placed low over smooth surfaces.

## Assessment of high-frequency attenuation

** Binned spectra files not available:** Select this option if you have not computed "Binned spectra and cospectra files" for the current dataset in a previous run of EddyFlow. Note that the binned (co)spectra files do not need to correspond exactly to the current dataset, rather they need to be representative of it. Binned spectra are used to quantify spectral attenuations, thus they must have been collected in conditions comparable to those of the current dataset (e.g., same EC system and similar canopy heights, measurement height, instruments spatial separations, etc.). At least one month worth of spectra files is needed for a robust spectral attenuation assessment. If you select this option, the option "All binned spectra and cospectra" in the Output Files page will be automatically selected and the check box will be deactivated.

** Binned spectra files available:** Select this option if you already obtained "Binned spectra and cospectra files" for the current dataset (in a previous run of EddyFlow). Note that such binned (co)spectra files do not need to correspond exactly to the current dataset, rather they need to be representative of it. Binned spectra are used here for quantification of spectral attenuations, thus they must have been collected in conditions comparable to those of the current dataset (e.g., same EC system and similar canopy heights, measurement height, instruments spatial separations, etc.). At least one month worth of spectra files is needed for a robust spectral attenuation assessment. If you select this option, the option "All binned spectra and cospectra" in the Output Files page will be automatically deselected.

- ** Start:** Starting date of the time period to be used for assessment of the cut-off frequencies and/or calculation of ensemble-averaged (co)spectra. The longer the time span, the more accurate the assessment and the ensemble averages will be.
- ** End:** Ending date of the time period to be used for assessment of the cut-off frequencies and/or calculation of ensemble-averaged (co)spectra. The longer the time span, the more accurate the assessment will be.

## Fratini et al. (2012) method settings

** Full w/T cospectra files not available:** Select this option if you do not have ** Full cospectra of w/T** for the current dataset (from a previous run of EddyFlow). Note that existing cospectra files need to correspond exactly to the current dataset. Full cospectra of w/T (sensible heat) are used for the definition of the spectral correction factor for each flux with the method of [Fratini et al. (2012](references.md#Fratini2012)). If you select this option, the option ** Full length cospectra w/Ts ** in the Output Files page will be automatically selected and deactivated.
