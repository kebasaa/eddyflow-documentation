---
title: "'w-boost' Bug Correction"
source_url: "https://www.licor.com/support/EddyPro/topics/w-boost-correction.html"
---
# W-boost Bug Correction for WindMaster/Pro

In February 2016, Gill Instruments published [Technical Key Note](http://gillinstruments.com/data/manuals/KN1509_WindMaster_WBug_info.pdf) KN1509v3 describing a bug in the computation of the vertical wind component (w) in the firmware of Gill WindMaster/Pro (WM and WMP) anemometers produced between 2006 and 2015. The bug is such that vertical wind speed is underestimated by a factor of 1.166 for positive values and 1.289 for negative values.

## Identifying affected anemometers

In the Technical Note, Gill Instruments explains that affected anemometers are identified by matching three criteria:

- Model is WM or WMP
- Production date is between 2006 and 2015
- Firmware version (command 'D2') is in the form: 2329.x.y with x<700

Therefore, starting from version 6.2.0, EddyFlow offers a new option in the Advanced Settings page to correct data for this bug. Simply select the checkbox ** Fix 'w-boost' bug (Gill WM and WMP only) ** to instruct EddyFlow to apply the correction. In order to determine whether the 'w-boost' correction is actually applicable, EddyFlow looks at the firmware version entered for the sonic anemometer in the metadata file (see [Entering the sonic anemometer firmware version](sonic-anemometer-firmware-version.md#top)) and applies the following rules:

- If the sonic anemometer model is WM or WMP, the firmware version is in the form [2329.x.y with x<700] and the option Fix 'w-boost' bug is selected, then EddyFlow will apply the multipliers 1.166 (w > 0) and 1.289 (w < 0) at the raw data level, before any other operation.
- In any other conditions, EddyFlow will not apply the 'w boost' bug fix. These include:The anemometer model is other than WM or WMPThe firmware version is not provided or, if provided, is not in the form [2329.x.y with x<700]The option ** Fix 'w-boost' bug ** is not selected

## Handling the 'w-boost' bug fix in combination with the angle of attack for WindMaster and WindMaster Pro

The Angle of Attack correction proposed by Nakai and Shimoyama (2012) for the WM and the WMP was derived by using units affected by the 'w-boost' bug. This means the correction is applicable 'as is' only to WM and WMP units affected by the 'w-boost bug' (see [Identifying affected anemometers](#w-boost_criteria)).

The 'w-boost bug' correction and an Angle of Attack correction cannot both be applied to the same anemometer. Our current recommendation is to select ** Fix 'w-boost' bug **. When ** Fix 'w-boost' bug ** is selected, EddyFlow does not apply an angle-of-attack correction, even if an Angle of Attack correction is selected or the ** Select automatically ** option is selected.

In Express Mode and by default in SmartFlux, EddyFlow does not apply any Angle of Attack correction, but it does apply the 'w-boost bug' correction to eligible data (see [Identifying affected anemometers](#w-boost_criteria)).
