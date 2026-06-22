---
title: "Sonic Firmware Version"
source_url: "https://www.licor.com/support/EddyPro/topics/sonic-anemometer-firmware-version.html"
---
# Entering the sonic anemometer firmware version

## Why is the firmware version important?

Currently, the firmware version number is needed for Gill WindMaster™ (WM) and WindMaster™ Pro (WMP) anemometers. However, storing the anemometers' firmware version in the metadata is recommended for good record keeping as well as for potential future use in EddyFlow.

Certain WM and WMP anemometers—identified by means of the firmware version—require a special handling of the Angle of Attack correction. When processing data using EddyFlow in Express Mode (on a personal computer or with the Original SmartFlux System or SmartFlux 2 and 3 Systems), EddyFlow does not apply any Angle of Attack correction, but does apply the so-called 'w-boost' correction to WM and WMP data if necessary (see [W-boost Bug Correction for WindMaster/Pro](w-boost-correction.md#W-boost)).

When, in Advanced Mode, the user selects an Angle of Attack method among those available, EddyFlow determines how it should be applied to the current dataset. This determination is based on the anemometer model and firmware version. If the selection is found to be inapplicable, EddyFlow will override the user's selection and inform about the action taken. In most scenarios, EddyFlow will simply proceed by not applying a selected Angle of Attack correction method that is not suitable for the current dataset.

** Note:** Applying the wrong Angle of Attack correction method can cause an under- or overestimation of the fluxes by up to 20%.

## Finding the anemometer's firmware version

The firmware version number can be retrieved using Windows® application software and a personal computer. Connect the sonic anemometer to the PC with the appropriate cable.

Alternatively, contact the manufacturer and provide the serial number of the anemometer (located on the external label). They will provide the firmware version number.

## Entering the firmware version

Gill anemometer firmware version numbers typically have three parts. The first four digits indicate the model (typically 2329, 2106, etc). The second set of numbers indicates the software version. The third set is the build number. All three sets of numbers should be entered in the version number field, separated by periods (e.g. 2329.600.01) or by hyphens (e.g. 2329-600-01).

## What if the anemometer's firmware version is not available?

If the firmware version is not available, EddyFlow will default to ** not ** applying the 'w-boost' bug correction.
