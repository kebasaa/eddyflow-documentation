---
title: "Magnetic Declination"
source_url: "https://www.licor.com/support/EddyPro/topics/declination.html"
---
# Magnetic declination

The field identified as ** North Reference ** is used to tell EddyFlow what to use as North.

** Use magnetic North ** simply instructs EddyFlow to consider the reference North as magnetic North.

** Use geographic North ** instructs EddyFlow to compute the declination based upon the date and location (geographical coordinates). To accomplish this, EddyFlow polls the United States National Oceanic and Atmospheric Administration (NOAA) web site for the correct declination. By default, EddyFlow uses the current date, but you can specify the date in the drop-down menu. The website constrains access to future dates.

** Note:** An Internet connection is required in order to retrieve the magnetic declination from the NOAA web site. EddyFlow uses the International Geomagnetic Reference Field (IGRF11) model, which is described here: [https://www.ngdc.noaa.gov/geomag-web/](https://www.ngdc.noaa.gov/geomag-web/). You can compute declination online at the same website.
