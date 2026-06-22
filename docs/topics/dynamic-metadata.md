---
title: "Time-varying (Dynamic) Metadata"
source_url: "https://www.licor.com/support/EddyPro/topics/dynamic-metadata.html"
---
# Time-varying (dynamic) metadata

Data processing and flux calculation with EddyFlow is based not only on raw data, but also on the metadata describing the site characteristics, the eddy covariance station setup and the raw data files themselves.

Metadata may vary along the dataset. For example, think about the growing canopy of an agricultural field, which may also imply an adjustment of the measurement height of the instruments. Maintenance and movement of instruments may imply a different relative positioning and orientation of the instruments. Also, instruments can be added or changed during the data collection, or parameters such as the acquisition frequency and the duration of the raw file, can change. All these possible changes must be taken into account for proper data processing and flux computation and correction. The ideal way to do that is to collect raw data in the original publisher's .ghg format. .ghg files embed the metadata inside each raw file so, if the data logging software is updated with the current meta-information during data acquisition (and that's by far the most suitable moment for doing that!), all raw files will embed the correct metadata, and EddyFlow will be able to correctly process them without any further intervention from you.

However, if you collected raw files in a format other than .ghg, or if you didn't update the data logging software with the proper meta-information during acquisition of your .ghg dataset, EddyFlow provides you with the possibility of taking time-varying metadata into account. This will require a little effort on your part, to create a dynamic metadata file prior to using EddyFlow. The dynamic metadata file is a comma separated text file featuring a header with the names of the contained variables, and a sequence of records starting with a timestamp, followed by the actual values.

Using the dynamic metadata does not imply that the ".metadata" file must not be created. Indeed, the ".metadata" file is used to initialize all the necessary metadata. On the contrary, the dynamic metadata file needs to contain only the parameters that undergo at least one modification along the dataset. Table 1 lists all metadata that can be provided in a dynamic metadata file, including the standardized variables names—indispensable for correctly interpreting the file content – and a short description of the variable meaning.

The associations between the data in the metadata file and the corresponding flux averaging periods is based on matching time stamps. The timestamp must be provided as date and time. EddyFlow will attempt to match all available timestamp information. If, for the current flux averaging period, there is no matching dynamic metadata contained in the file, EddyFlow will use the closest preceding one. This means that you don't need to create a file that contains metadata for all flux averaging periods. Basically, you need to create a new metadata line each time a modification occurs for any metadata parameter.

As an example, imagine a dataset that starts on the 1st of January, with the CO2 analyzer placed 20 cm at the North of the anemometer. On the 15th of February, at 10:30AM, the analyzer is moved and placed 30 cm eastward of the anemometer. The acquisition ends at the end of February and this was the only notable modification that occurred during the two months. Valid metadata in this situation would read:

` date,time,co2_irga_northward_separation,co2_irga_eastward_separation `

` 2011-01-01,01:00,20.0,0.0 `

` 2011-02-15,10:30,0.0,30.0 `

where the first line is the header containing standardized labels (see the following table). The second line indicates that, starting January 1st, 2011 at 1:00AM, the CO2 analyzer is placed 20 cm northward of the master anemometer, and 0 cm eastward. These settings will bypass any different information provided in the alternative, "master" (and static) metadata file.

The third line says that, starting February 15th, 2011 at 10:30AM, the CO2 analyzer was moved, and is now aligned with the master anemometer in the South-North direction, but displaced 30 cm eastward.

| Variable | Label | Units/Format/Values | Description and notes |
| --- | --- | --- | --- |
| Date | date | yyyy-mm-dd | Year, month, and day of the current data. |
| Time | time | HH:MM | Hour and minute of the current data. The minute must correspond to the end of the period the metadata refer to. |
| File length | file_length | minutes | The duration in minutes of the raw files. |
| Acquisition frequency | acquisition_frequency | Hz | Frequency of acquisition of raw data from gas analyzer(s) and anemometer(s) |
| Canopy height | canopy_height | m | Height of the canopy |
| Displacement height | displacement_height | m | Displacement height |
| Roughness length | roughness_length | m | Roughness length |
| Manufacturer of the master anemometer | master_sonic_manufacturer | variable† | See list of supported manufacturers. |
| Model of the master anemometer | master_sonic_model | variable‡ | See list of supported models and how to compose the name. |
| Height of the master anemometer | master_sonic_height | m | This height also defines the "measurement height" used in calculations. |
| Format of wind data | master_sonic_wformat | 'uvw''polar_w''axis' | The 'axis' option (wind components aligned with paths of the transducers pairs) applies only to Gill anemometers. |
| North alignment for wind data | master_sonic_wref | 'spar''axis' | Only applies to Gill anemometers (learn more...). |
| North misalignment for wind data | master_sonic_north_offset | deg from North | Any misalignment between "anemometer North" and geographic North, in degrees from North (positive if measured eastward). |
| Manufacturer of gas analyzer for XXX | xxx_irga_manufacturer | variable* | See list of supported manufacturers. |
| Model of gas analyzer for XXX | xxx_irga_model | variable ** | See list of supported manufacturers. |
| Northward separation of XXX analyzer from master anemometer | xxx_irga_northward_separation | cm | Positive if gas analyzer or sample inlet is placed North of anemometer. |
| Eastward separation of XXX analyzer from master anemometer | xxx_irga_eastward_separation | cm | Positive if gas analyzer or sample inlet is placed East of the master anemometer. |
| Vertical separation of XXX analyzer from master anemometer | xxx_irga_vertical_separation | cm | Positive if gas analyzer or sample inlet is placed higher than anemometer |
| Length of the tube of the sampling line for XXX analyzer | xxx_irga_tube_length | cm | Only applicable to closed/enclosed path gas analyzers. |
| Diameter of the tube of the sampling line for XXX analyzer | xxx_irga_tube_diameter | mm | Only applicable to closed/enclosed path gas analyzers. |
| Flow rate in the sampling line of XXX analyzer | xxx_irga_flowrate | lit min-1 | Only applicable to closed/enclosed path gas analyzers. |
| Extinction coefficient in water | xxx_irga_kw | m3 g-1 cm-1 | Only applicable to Krypton/Lyman-α hygrometers./ |
| Extinction coefficient in oxygen | xxx_irga_ko | m3 g-1 cm-1 | Only applicable to Krypton/Lyman-α hygrometers. |
| XXX analyzer longitudinal path length | xxx_irga_vpath_length | m | Path length of the gas analyzer in the main direction (direction between source and sensor). |
| XXX analyzer transversal path length | xxx_irga_hpath_length | m | Path length of the gas analyzer in the cross direction. |
| XXX analyzer time response | xxx_irga_tau | m | Analyzer's time response as provided by the manufacturer. |

†Supported Anemometer Manufacturers:

| Manufacturer | Label |
| --- | --- |
| Gill Instruments, Ltd. | gill |
| Campbell Scientific®, Inc. | csi |
| Metek GmbH | metek |
| R. M. Young | young |
| Others | other_sonic |

‡Supported Anemometer Models:

| Model | Label |
| --- | --- |
| Gill R2 | r2 |
| Gill R3-50 | r3_50 |
| Gill R3-100 | r3_100 |
| Gill R3A-100 | r3a_100 |
| Gill HS-50 | hs_50 |
| Gill HS-100 | hs_100 |
| Gill WindMaster® | wm |
| Gill WindMaster Pro | wmpro |
| Metek USA-1 | usa1_standard |
| Metek USA-1 fast | usa1_fast |
| Campbell® Scientific CSAT3 | csat3 |
| Campbell® Scientific CSAT3B | csat3b |
| R. M. Young | 81000 |
| R. M. Young | 81000V |
| R. M. Young | 81000RE |
| R. M. Young | 81000VRE |
| Others | generic_sonic |

*Supported Gas Analyzer Manufacturers:

| Manufacturer | Label |
| --- | --- |
| the original publisher | the original publisher |
| others | other |

*Supported Gas Analyzer Models:

| Model | Label |
| --- | --- |
| the original publisher LI-6262 | li6262 |
| the original publisher LI-7000 | li7000 |
| LI-7500 | li7500 |
| LI-7500A | li7500a |
| LI-7500RS | li7500rs |
| LI-7500DS | li7500ds |
| LI-7200RS | li7200rs |
| LI-7200 | li7200 |
| LI-7700 | li7700 |
| Generic Open Path | generic_open_path |
| Generic Closed Path | generic_closed_path |
| Open Path Krypton Hygrometer | open_path_krypton |
| Close Path Krypton Hygrometer | closed_path_krypton |

The model label must be created by adding an "instrument order number" to the labels listed above. Imagine creating two lists of instruments, one for anemometers and one for gas analyzers. The first instrument of the list that you describe takes the number 1, and the label becomes "instrumentlabel_1". The second takes number 2, and so on. Note that in the dynamic metadata file (different from the alternative metadata file) you can only describe 1 anemometer. This feature is needed to provide maximum flexibility. As an example, think about the following suite of measurements and corresponding instruments:

- Wind and temperature from a Gill R3A-100
- CO2 concentration from an LI-7500RS
- H2O concentration from a different LI-7500RS
- CH4 concentration from an LI-7700

In this case, you can provide dynamic metadata for 4 different instruments, and the instrument model label will take the following values:

- master_sonic_model = r3a_100_1
- co2_irga _model = li7500_1
- h2o_irga_model = li7500_2
- ch4_irga_model = li7700_3

with the advantage the instruments for CO2 and H2O, although of the same model, are differentiated by EddyFlow thanks to the attached number.
