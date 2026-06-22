---
title: "Planar Fit Configuration Dialog"
source_url: "https://www.licor.com/support/EddyPro/topics/planar-fit.html"
---
# Planar fit configuration dialog

Under: Advanced Settings > Raw data processing > Rotation Method

Selecting either Planar Fit option (Standard Planar Fit and Planar Fit with no velocity bias) will cause the ** Planar Fit Settings ** button to activate. Click on it and access the planar fit configuration dialogue. Two options are available here: if you already have a planar fit rotation matrices file created by a previous EddyFlow run, which also applies to your current dataset, select the option ** Planar Fit file available ** and locate the corresponding file by using the ** Load ** button. Otherwise, select the option ** Planar Fit file not available ** and enter the following settings:

## Planar fit different period

- ** Start date:** Starting date of the dataset to use for calculating planar fit rotation matrices
- ** End date:** Ending date of the dataset to use for calculating planar fit rotation matrices

## Planar fit settings

- ** Minimum number of elements per sector:** Set the minimum number of mean wind vectors ("elements") to be used for each sector to assess the fitting plane and calculate the rotation matrix. The higher the number of elements, the more accurate the results, but also the longer the required planar fit subset.
- ** Maximum mean vertical wind component:** Setting a maximum vertical wind component will cause EddyFlow to ignore flux averaging periods with larger mean vertical wind components when calculating the rotation matrices. Using elements with too large (unrealistic) vertical wind components would corrupt the assessment of the fitting plane and of the related rotation matrices.
- ** Minimum mean horizontal wind component:** Setting a minimum horizontal wind component will cause EddyFlow to ignore flux averaging periods with smaller mean horizontal wind components when calculating the rotation matrices. When the horizontal wind is very small, the attack angle may be affected by large errors, as would be the vertical wind component, resulting in poor quality data that would degrade the planar fit assessment.
- ** If planar fit calculations fail for a sector:** Chose how EddyFlow should behave if, for any given wind sector, planar fit sectors cannot be calculated (either because there are not enough wind data from that sector, because calculations fail, or because the sector was explicitly excluded, see below). Three options are available: use the planar fit rotation matrices calculated for the neighboring sector (counted either clockwise or counter-clockwise) or use double rotations.

Then use the visual tool to design the wind sectors. A few suggestions on the use of the designer:

- Use the + and – buttons to add or remove sectors;
- To remove a specific sector, click on it on the pie or on the table, and click on the – button;
- To create one only wind sector of 360°, click on the + button and click on "Set equally spaced" or, simply, double-click on the pie.
- To create N equally spaced wind sectors (of 360/N degrees), click N times on the + button and then click on "Set equally spaced";
- To create a sector that spans through the "North", use the "North offset first sector" field. Offset can go from -180 to + 180°;
- After creating 1 or more sectors, if you want to create a last sector to close the 360° angle, just double-click on the remaining empty portion of the pie;
- To instruct EddyFlow to ignore any sector (i.e. not calculate the rotation matrix for that sector), uncheck it on the table.

The proper rotation matrix will then be used for each flux averaging period, according to the current mean wind direction.

** Note:** The higher the number of sectors, the longer the planar fit subset must be, so as to assure that enough data are available for each sector to perform a robust bi-linear fit.
