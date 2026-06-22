# Filtering raw data records for instrument diagnostics and custom flags

Before calculating fluxes, EddyFlow® Software provides two main mechanisms for excluding raw (high-frequency) data affected by quality issues. This improves the quality and reliability of flux results. These mechanisms are based on (1) instrument diagnostic values and on (2) custom-defined flags. Both are described in the following.

## Filtering for instrument diagnostics

Instrument diagnostic are values (usually expressed as an integer number) reported along with each raw data record, providing indications about the status of the instrument at the moment of the measurement or about the quality of the measurement itself. Manufacturers usually specify which value or values indicate data of good quality and which, in turn, indicate data that should be discarded because quality cannot be assured. In order to be usable for eliminating individual raw data records, the diagnostic value must be available in the raw data file at the same output rate as the variable(s) to which it refers. Typically, a diagnostic value synthesizes several pieces of information in only one "word" and the manufacturer is responsible for documenting either how to "expand" the value into the individual pieces or how to interpret the resulting word to retain or discard data.

Currently, EddyFlow supports instrument diagnostics for all the original publisher's eddy covariance gas analyzers (LI-7500 x, LI-7200/RS, LI-7700) and for the following sonic anemometers:

- Gill Instrument's WindMaster™ (WM), WindMaster Pro (WMP), and HS-50
- Campbell® Scientific's CSAT3 and CSAT3B

Note that while gas analyzers' diagnostics only eliminate the corresponding gas concentration data, anemometer's diagnostics eliminate entire data records, because when anemometric data is not available, the corresponding concentration data becomes useless for the purpose of flux computation.

In order to use instrument diagnostics in EddyFlow, diagnostic values must be collected in the raw data files and properly described in the ** Metadata File Editor > Raw File Description **. Then, in ** Basic Settings Select > Items for Flux Computation **", the available diagnostic variables must be explicitly selected from the dedicated combo-boxes.

For all sonic anemometers listed above, EddyFlow will discard the corresponding data when appropriate, but will not report the diagnostic values in the ** Full Output File **. For all supported sonic anemometers, the diagnostic value is such that a value of "0" (zero) means "good data" to be retained, while a value different from zero means "bad data" to be discarded. The only exceptions to this rule are:

- Gill WM/WMP data records labeled with the diagnostic values '0A' and '0B' shall be retained

The following tables list diagnostic values that can be reported for each anemometer and whether the corresponding data records are kept or discarded by EddyFlow for the purpose of computing fluxes.

| Status Code | Description | Comments | EddyFlow Action |
| --- | --- | --- | --- |
| 00 | OK | When the diagnostic value is zero, data are OK | Keep the record |
| 01 | Sample Failure | Insufficient samples in the average period from Transducer Pair 1 | Discard the record |
| 02 | Sample Failure | Insufficient samples in the average period from Transducer Pair 2 | Discard the record |
| 03 | Sample Failure | Insufficient samples in the average period from Transducer Pair 3 | Discard the record |
| 04 | Sample Failure | Insufficient samples in the average period from Transducer Pairs 1 and 2 | Discard the record |
| 05 | Sample Failure | Insufficient samples in the average period from Transducer Pairs 1 and 3 | Discard the record |
| 06 | Sample Failure | Insufficient samples in the average period from Transducer Pairs 2 and 3 | Discard the record |
| 07 | Sample Failure | Insufficient samples from all Transducer Pairs | Discard the record |
| 08 | NVM Error | NVM Checksum failed | Discard the record |
| 09 | ROM Error | ROM Checksum failed | Discard the record |
| 0A | System gain at Maximum | Results OK, but marginal operation | Keep the record |
| 0B | Retries | Retries used | Keep the record |

| Status Code Bit | Value | Description | EddyFlow Action |
| --- | --- | --- | --- |
|  | 0 | No error | Keep the record |
| 0 | 1 | Transducer Pair 1 failed | Discard the record |
| 1 | 2 | Transducer Pair 2 failed | Discard the record |
| 2 | 4 | Transducer Pair 3 failed | Discard the record |
| 3 | 8 | Reserved |  |
| 4 | 16 | Memory error | Discard the record |
| 5 | 32 | PRT failed | Discard the record |

| Status Code Bit | Value | Description | Comments | EddyFlow Action |
| --- | --- | --- | --- | --- |
|  | 0 | OK | When the diagnostics value is zero, data are OK. | Keep the record |
| 12 | 4096 | Sonic signal amplitude is too low | There may be an obstruction in the anemometer path or on the transducer face. | Discard the record |
| 13 | 8192 | Sonic signal amplitude too high | An obstruction was removed from the anemometer path or the transducer face. | Discard the record |
| 14 | 16384 | Low signal | The anemometer path length may have been altered or the anemometer head is broken. | Discard the record |
| 15 | 32768 | Difference in the speed of sound between the three non-orthogonal axes is greater than 2.360 m s-1 (~4 °C @ 25 °C) | The anemometer path length may have been altered or the anemometer head is broken. | Discard the record |

| Status Code Bit | Value | Description | Comments | EddyFlow Action |
| --- | --- | --- | --- | --- |
|  | 0 | OK | When the diagnostics value is zero, data are OK. | Keep the record |
| 0 | 1 | Low amplitude | Ultrasonic signal is too small. | Discard the record |
| 1 | 2 | High amplitude | Ultrasonic signal is too large. | Discard the record |
| 2 | 4 | Tracking | The signal lock is poor | Discard the record |
| 3 | 8 | High Delta C | Difference in the speed of sound between the three non-orthogonal axes is greater than 2.360 s-1 (~4 °C @ 25 °C). | Discard the record |
| 4 | 16 | Acquiring | Indicates that the anemometer is trying to acquire the sonic signal. | Discard the record |
| 5 | 32 | Low voltage | The supply voltage to the anemometer is below 9.0 Vdc. | Discard the record |
| 6 | 64 | Trigger error | A measurement trigger has not been received for at least 1 second, or the time interval between triggers is varying by greater than 5%. | Discard the record |
| 7 | 128 | Internal humidity warning | The relative humidity inside the CSAT3B block is greater than 80% | Discard the record |
| 8 | 256 | Memory error | There is a signature mismatch from the calibration file or another section of memory. | Discard the record |

For the original publisher gas analyzers, EddyFlow "expands" the individual diagnostic values and, in addition to using them to filter the corresponding gas data when appropriate, also reports their values in the ** Full Output File **.

The following tables list diagnostic values that can be reported for each analyzer and the action taken by EddyFlow for the purpose of computing fluxes.

| Bit (0=BAD, 1=OK) | Description | EddyFlow Action if Bad |
| --- | --- | --- |
| 0-3 | AGC | Calculate AGC |
| 4 | Sync | Keep the record |
| 5 | PLL | Discard the Record |
| 6 | Detector | Discard the Record |
| 7 | Chopper | Discard the Record |

| Bit (0=BAD, 1=OK) | Description | EddyFlow Action if Bad |
| --- | --- | --- |
| 0-3 | AGC | Calculate AGC |
| 4 | Sync | Keep the record |
| 5 | PLL | Discard the Record |
| 6 | Detector | Discard the Record |
| 7 | Chopper | Discard the Record |
| 8 | Head Pressure | Discard the Record |
| 9 | Aux Input | Keep the record |
| 10 | Tin | Discard the Record |
| 11 | Tout | Discard the Record |
| 12 | Head Connected | Discard the Record |
| 13-15 | Not Used—always 0 | Keep the record |

| Bit (0=OFF, 1=ON) | Description | EddyFlow Action if Bad |
| --- | --- | --- |
| 0 | 7550 Connected | Keep the record |
| 1 | TC1-Failure | Keep the record |
| 2 | TC2-Failure | Keep the record |
| 3 | TC3 Failure | Keep the record |
| 4 | Motor Failure | Keep the record |
| 5 | Instrument is Calibrating | Discard the Record |
| 6 | Bottom Heater ON | Keep the record |
| 7 | Top Heater ON | Keep the record |
| 8 | Pump ON | Discard the Record |
| 9 | Motor is Spinning | Discard the Record |
| 10 | Block Temp Unregulated | Discard the Record |
| 11 | Laser Temp Unregulated | Discard the Record |
| 12 | Bad Temperature | Keep the record |
| 13 | Reference Channel Unlocked | Discard the Record |
| 14 | No Sample Signal | Discard the Record |
| 15 | Instrument Not Ready | Discard the Record |

## Filtering with custom flags

In addition to the dedicated diagnostic variables, other variables can be used to identify and eliminate bad raw data before flux computation. For example, you may want to eliminate records for which the vertical wind component is too large, or gas concentrations that take on implausible values due to instrument failure. For this reason, any variable in the EddyFlow® Software (except those marked as "Ignore" and/or "Not numeric" in the ** Raw File Description ** table) can be treated as a record flag, including variables used in flux computation.

In EddyFlow, elimination of records through flags is done by setting a threshold value for the selected flag variable and by defining whether entire records should be eliminated when the variable value goes above or below the threshold. For example, if you have a data column which is set to "0" for good quality and "1" for bad quality, you can: 1) select that variable as a flag; 2) set the threshold to 0.00; and 3) select ** Discard if above threshold **. This way, all records for which the variable takes the value "1" will be eliminated from the dataset. As a second example, suppose you want to use the gas concentration as such a flag, instructing EddyFlow to eliminate all records for which a CO2 concentration falls below 300 ppm. In this case, select the CO2 variable as a flag, set the threshold to 300.00 and set the policy to "Discard if below threshold".

Make sure you enter the flag threshold in the units specified by EddyFlow in the label following the threshold column. If units do not appear, use the same units used in the raw files.

** Note:** If you describe more than one flag, EddyFlow will eliminate all records flagged by at least one test. Note also that currently the same variable cannot be used in two different flag definitions. The result of such an operation is unpredictable; most likely, only the latest flag definition with the same variable will have an effect.
