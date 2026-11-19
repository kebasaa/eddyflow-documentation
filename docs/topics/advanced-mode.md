# Overview of advanced processing

Advanced Mode provides you with the high-level capabilities of the EddyFlow Advanced, computing fully corrected flux results in real-time with the processing options of your choice.

The SmartFlux configuration file, needed to run EddyFlow in Advanced mode inside the original SmartFlux or SmartFlux 2 System, is created in EddyFlow 5 or higher. This—and subsequent versions of EddyFlow—provide the capability to export a SmartFlux configuration file, that can then be uploaded via the gas analyzer PC software. Complete documentation is provided in the EddyFlow help.

There are additional considerations if you use **EddyFlow Advanced** in the SmartFlux or SmartFlux 2 System. For many scenarios, you will simply need to configure the advanced settings as you see fit, and load the SmartFlux configuration file into the SmartFlux or SmartFlux 2 System following the instructions provided below.

However, if you wish to use a **Planar-fit method for Axis Rotation**, the **Automatic Time Lag Optimization** option, or one of the **in situ spectral correction** methods (Horst, 1997; Ibrom et al., 2007), *you will need to process an existing data set from the site in order to configure the parameters for these settings*.

!!! warning

    In order for the parameters to be valid, the site must not have undergone any significant changes between the time when the existing data set was collected and when the SmartFlux or SmartFlux 2 System is deployed. The instrument configuration should remain unchanged during the sampling period if the settings are to apply to the SmartFlux configuration file as well. For closed-path systems, the dataset used to optimize time lags and for the spectral assessment must refer to a period in which the sampling line did not undergo major modifications, such as replacement of tube or filters, change of the flow rate, etc.

When you create the configuration file, only the controls that can be configured for the SmartFlux or SmartFlux 2 System are enabled, and the other controls are disabled.

## Missing planar fit, time lag or spectral assessment files

A project can use an existing **planar fit file**, **time lag file** or **spectral assessment file** from an earlier run. When you start an Advanced run, EddyFlow checks that each file the run will read is still where the project says it is. If one has been moved, renamed or deleted, an **Input Files Not Found** window opens before anything is processed:

- One line per file, with the same **Browse...** and **Remote drive...** buttons as the settings pages. A line is greyed out when the current settings do not use that file.
- A missing file's line is pre-filled with a similar file when one is found: the same name with a different timestamp, as a later run of the same project writes it. EddyFlow looks in the file's own folder, the project's output folder, the folders beside the file's folder, and the project file's folder, and offers the most recent match. A PWB time lag table is never offered the `_pwb_timelag_opt_` summary written beside it.
- A line whose path is not the one saved in the project is highlighted, so a suggested file is never used without your seeing it.

**Continue** is available once every file the run uses exists; the project is then saved with the new paths and the run starts. **Cancel Run** stops without changing the project. Files on a remote drive are not checked here; the engine fetches them itself.
