---
title: "Calculating Instrument Separations"
source_url: "https://www.licor.com/support/EddyPro/topics/calculate-instrument-separation.html"
---
# Calculating relative instrument separations

See [Selecting Advanced Options](selecting-advanced-options.md#Correcti) for guidance with this setting.

EddyFlow can handle raw files containing data from multiple anemometers and multiple gas analyzers, with a maximum of 5 different instruments. The separation between any pair of instruments – notably between any anemometer and any gas analyzer – is calculated by EddyFlow by evaluating distances in a [Cartesian coordinate system](sensor-separation.md). The first anemometer described in the .metadata file serves as the origin of such system and absolute separations for all other instruments (including other anemometers) are provided as a northward, eastward and vertical distances from the reference anemometer.

If, at processing time, you select a master anemometer other than the reference one, EddyFlow will automatically calculate northward, eastward, and vertical relative separations of any gas analyzer from the selected anemometer, by means of simple differences of absolute separations. Then, the horizontal relative separation is evaluated from the northward and eastward separations. Horizontal and vertical separations are needed to estimate spectral losses according to [Moncrieff at al. (1997)](references.md#Moncrieff). In addition, the three northward, eastward, and vertical relative separations are needed in a spectral correction method based on [Horst and Lenschow, 2009](references.md#horst2009).
