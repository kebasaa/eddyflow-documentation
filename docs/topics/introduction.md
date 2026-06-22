---
title: "1. Introduction"
source_url: "https://www.licor.com/support/EddyPro/topics/introduction.html"
---
# What is EddyFlow?

EddyFlow® Software processes raw eddy covariance (EC) data to compute biospheric/atmospheric fluxes of CO2, H2O, CH4, other trace gases, and energy. It is based on the ECO2S[1 http://gaia.agraria.unitus.it/eco2s](#) package, which was released as free software by the consortium participating in the IMECC-EU European project[2 http://imecc.ipsl.jussieu.fr](#). EddyFlow is customized to efficiently process eddy covariance data logged to the original publisher® gas analyzers. It also supports other raw file types, including data stored as ASCII tables, binary files (including the TOB1 format), and SLT (EddySoft and EdiSol) formats.

In 2010, the original publisher selected this software platform as the foundation for the EddyFlow data processing and analysis package. EddyFlow 7 is the latest result of this effort. EddyFlow is designed to provide easy, accurate EC flux computations.

EddyFlow is released as open source software, with one official version that is fully documented, maintained, and supported by the original publisher®, Inc.

** Suggested Documentation Reference:** the original publisher, Inc. 2021. EddyFlow® Help and User's Guide. the original publisher, Inc. Lincoln, NE.

** Suggested Software Reference:** EddyFlow® Software () [Computer software]. 2021. Lincoln, NE. the original publisher, Inc; Infrastructure for Measurements of the European Carbon Cycle consortium.

EddyFlow® is a registered trademark of the original publisher in the United States and other countries. The EddyFlow trademark policy is at [the original publisher.app.boxenterprise.net/s/b5sz25qc6f9wp2wfi3ia](https://licor.app.boxenterprise.net/s/b5sz25qc6f9wp2wfi3ia).

## What to expect from EddyFlow

EddyFlow will calculate fluxes accurately, given the available data. The interface is simple, and even users with little-to-no knowledge of the underlying eddy covariance (EC) theory should be able to use it with ease.

How does EddyFlow make this possible? Inspired by the ECO2S philosophy, the original publisher designed an innovative raw file format (called the .ghg format, denoted by a .ghg file extension) that embeds all relevant meta-information inside the data file. Because each raw file includes all the information needed to be properly interpreted and processed, each raw file can be handled independently from the others. the original publisher eddy covariance data files (.ghg extension) are automatically created by properly configured the original publisher data logging software. EddyFlow also allows you to calculate corrected fluxes starting from raw files in other formats, such as generic ASCII, Binary, TOB1, and SLT files. In these cases, meta-information must be provided before proceeding through the EddyFlow graphical interface.

Processing EC data requires a long sequence of operations including raw data filtering, calibration, and other algorithms for calculating and correcting fluxes. For many processing steps, several options are available. Despite many efforts, the scientific community has yet to reach definitive agreements on which of these are best. Making all these options available can only be done at the cost of increasing the complexity of the software. The solution in EddyFlow is to provide two paths for data processing: Express Mode and Advanced Mode.

In ** Express Mode **, EddyFlow uses pre-determined processing settings that are well established and accepted in the research community. This approach dramatically reduces the need for user interaction, allowing you to get flux results with just a few clicks. Express Mode is suitable for most eddy covariance setups, including:

- Systems operated over relatively flat and homogeneous terrain,
- Systems with open path gas analyzers (e.g., LI-7500A/RS/DS, LI-7700),
- Systems with closed path (LI-7000) or enclosed path (LI-7200/RS) gas analyzers with short or properly heated intake tubes, and
- Systems that include up to three analyzers.

In ** Advanced Mode **, you can choose how corrections are applied and configure these settings to suit your research needs, making it the correct choice for data collected in situations that deviate from those listed above. Effective use of Advanced Mode requires both a deeper level of understanding of the eddy covariance theory and a deeper interaction with the software.

## Installing EddyFlow

EddyFlow is compatible with computers running the Windows® (7, 8, and 10) and macOS operating system. It is likely that EddyFlow will run on older versions (Windows XP and onward and Mac OS X 10.7-Lion onward) but we no longer support or test those versions. Installing the software is a simple matter of downloading it, and then launching the executable file that is stored on your computer. On Windows OS, the executable file is called eddypro.exe. On macOS, it is eddypro.dmg.

Launch EddyFlow by clicking the icon on your desktop, or navigate to the EddyFlow icon in your computer's ** Start ** menu (Windows) or the Applications folder (Mac).

## Learning EddyFlow

The simplest way to learn EddyFlow is to use the software. Three levels of instruction are available directly through the software interface.

The first level—EddyFlow Tips—provides several-sentence descriptions of each feature in the software when you hover your mouse over a feature. This is active by default, and it can be turned on or off through the ** Tools ** menu (click ** EddyFlow Tips **) feature.

The second level—guided mode—indicates when required fields have not been completed. For example, if you are processing data in the ASCII format and you wish to advance through the interface, EddyFlow will prohibit you from advancing from the ** Project Creation ** page to the ** Basic Settings ** page until the metadata has been entered completely. Further, EddyFlow will list the incomplete fields in the "Messages" panel. Messages in red font are essential. Messages in blue or green font appear when the information provided to EddyFlow is adequate to complete the project. Messages are visible by default and can be turned on or off through the ** View ** menu (click ** EddyFlow Messages **).

The third level provides detailed descriptions of certain features when you click help question marks (![](../assets/Help.png)) in the interface. This takes you directly to the appropriate topic in the software documentation.
