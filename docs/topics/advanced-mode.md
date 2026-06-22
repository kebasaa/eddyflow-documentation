# Overview of advanced processing

Advanced Mode provides you with the high-level capabilities of the EddyFlow Advanced, computing fully corrected flux results in real-time with the processing options of your choice.

The SmartFlux configuration file, needed to run EddyFlow in Advanced mode inside the original SmartFlux or SmartFlux 2 System, is created in EddyFlow 5 or higher. This—and subsequent versions of EddyFlow—provide the capability to export a SmartFlux configuration file, that can then be uploaded via the gas analyzer PC software. Complete documentation is provided in the EddyFlow help.

There are additional considerations if you use ** EddyFlow Advanced ** in the SmartFlux or SmartFlux 2 System. For many scenarios, you will simply need to configure the advanced settings as you see fit, and load the SmartFlux configuration file into the SmartFlux or SmartFlux 2 System following the instructions provided below.

However, if you wish to use a ** Planar-fit method for Axis Rotation **, the ** Automatic Time Lag Optimization ** option, or one of the ** in situ spectral correction ** methods (Horst, 1997; Ibrom et al., 2007), *you will need to process an existing data set from the site in order to configure the parameters for these settings*.

** Important:** In order for the parameters to be valid, the site must not have undergone any significant changes between the time when the existing data set was collected and when the SmartFlux or SmartFlux 2 System is deployed. The instrument configuration should remain unchanged during the sampling period if the settings are to apply to the SmartFlux configuration file as well. For closed-path systems, the dataset used to optimize time lags and for the spectral assessment must refer to a period in which the sampling line did not undergo major modifications, such as replacement of tube or filters, change of the flow rate, etc.

When you create the configuration file, only the controls that can be configured for the SmartFlux or SmartFlux 2 System are enabled, and the other controls are disabled.
