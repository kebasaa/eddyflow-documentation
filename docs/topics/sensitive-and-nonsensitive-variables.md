# Sensitive and non-sensitive variables

In the Metadata File Editor, you can choose to ** Ignore ** a variable, specify if it is ** Numeric ** or not, and specify the ** Variable ** type. Ignore simply tells EddyFlow to ignore the field in processing. Select "yes" for variables that are not needed. This will speed up processing. For numeric variables, select yes to instruct EddyFlow to treat it as a number. For Variable, choose the measurement type from the list.

*** Sensitive variables ** are recognized by the software and used for flux computation.* These variables can be selected from the drop-down list under ** Variables ** in ** Raw File Description ** tab of the Metadata File Editor.

| Name | Symbol | Description |
| --- | --- | --- |
| u wind component | u | Wind component along the anemometer x axis |
| v wind component | v | Wind component along anemometer y axis |
| w wind component | w | Wind component along anemometer z axis |
| horizontal wind intensity | ρ | Intensity of wind vector with respect to anemometer horizontal plane |
| wind direction | θ | Wind direction with respect to anemometer North |
| sonic temperature | Ts | Sonic temperature measured by the anemometer |
| speed of sound | sos | Speed of sound measured by the anemometer |
| CO2 mole fraction | χco2 | Mole CO2 per mole of wet air |
| CO2 mixing ratio | rco2 | Mole CO2 per mole of dry air |
| CO2 molar density | dco2 | Mole CO2 per cubic meter |
| H2O mole fraction | χh2o | Mole H2O per mole of wet air |
| H2O mixing ratio | rh2o | Mole H2O per mole of dry air |
| H2O molar density | dh2o | Mole H2O per cubic meter |
| CH4 mole fraction | χch4 | Mole CH4 per mole of wet air |
| CH4 mixing ratio | rch4 | Mole CH4 per mole of dry air |
| CH4 molar density | dch4 | Mole CH4 per cubic meter |
| 4th gas mole fraction | χpg | Mole gas per mole wet air |
| 4th gas mixing ratio | rpg | Mole gas per mole of dry air |
| 4th gas molar density | dpg | Mole gas per cubic meter |
| cell temperature in | Tin | Temperature at the inlet of the LI-7200 cell |
| cell temperature out | Tout | Temperature at the outlet of the LI-7200 cell |
| cell temperature | Tcell | Average cell temperature of any closed/enclosed gas analyzer (LI-7200, LI-7000, LI-6262) |
| ambient temperature | Ta | Temperature of ambient air as measured, for example, by an open-path analyzer (e.g., LI-7500 x) |
| ambient pressure | Pa | Pressure of ambient air as measured, for example, by an open-path analyzer (e.g., LI-7500 x) |
| LI-7500 diagnostic | - | Diagnostic flag output by the LI-7500 x. It is an integer value obtained as a combination of several binary flags. |
| LI-7200 diagnostic | - | Diagnostic flag output by the LI-7200/RS. It is an integer value obtained as a combination of several binary flags. |
| LI-7700 diagnostic | - | Diagnostic flag output by the LI-7700. It is an integer value obtained as a combination of several binary flags. |
| Anemometer diagnostics | - | Diagnostic flag output by the anemometer |

** Note:** Along with CO2, H2O, and CH4, EddyFlow can process a 4th gas that can be selected from among those listed in the drop-down list, or be completely customized (see the section on processing a generic passive scalar variable).

Diagnostic flags output at high frequency from the original publisher instruments are integer values that represent the combination of several binary flags, each providing information about the status of specific instrument components (refer to the respective instruction manuals for more information on these flags). If raw files contain such a flag for one or more instruments, you can select them in the ** Basic Settings ** page. EddyFlow will decipher them and provide you with the sum of the flagged samples in each raw file, which can help you to detect instrument failures and filter results for quality. The only exception is the AGC value, for which EddyFlow provides you the period-wise mean value, rather than the sum.

*** Non-sensitive variables ** are all those not used for flux computation.* EddyFlow preserves these variables for a dedicated processing routine, which includes despiking, tilt correction, detrending, time lag compensation and calculation of main statistics (mean values, variances, covariances, skewness and kurtosis). These variables include:

- Variables with a name explicitly entered in the ** Variables ** text box;
- All sensitive variables that are not selected for flux computation in the current processing project. For example, in a raw file there can be more than only CO2 concentration measurements, from the same or from different instruments. However, only one CO2 measurement can be used at a time to calculate fluxes. The others are treated as non-sensitive variables.

Furthermore, as the data files can contain unused columns (to be ignored), EddyFlow provides two options to declare useless variables. Selecting "ignore" or "not numeric" from the drop-down list will cause EddyFlow to ignore the current column. The "not numeric" variable name is used to instruct EddyFlow to skip the column as text. This is advisable because inherent limitations in file import capabilities of FORTRAN require files containing text columns to be read differently than purely numeric tables. This slows down the import process considerably. Selecting "not numeric" for columns containing text will enable the software to import data more quickly.
