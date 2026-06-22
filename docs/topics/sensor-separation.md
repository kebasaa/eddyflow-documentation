# Northward, eastward, and vertical separation

Measurement of the separation between the gas analyzer(s) and the sonic anemometer used is necessary to estimate the high-frequency flux losses due to the distance between the instruments that measured the vertical wind component and the gas concentration(s). Raw files might contain data from more than one anemometer. EddyFlow, however, will calculate fluxes using data from only one anemometer, which you select in the ** Processing Page **.

In order to allow EddyFlow to calculate the distance from a gas analyzer and the anemometer, distances are provided in a Cartesian coordinate system.

- Units must be provided in centimeters (cm).
- The first anemometer (reference anemometer) described in the .metadata file serves as the center of the coordinate system.
- Exact orientation of north-south and east-west axes are aligned with respect to true north, corrected for the local declination.
- For all gas analyzers and other anemometers (if any), the distances from the reference anemometer are provided along the north-south axis and the east-west axis.
- Distances are positive if the second instrument is to the north, east, or above the reference anemometer. This makes it possible for EddyFlow to calculate distances between any pair of instruments.

## For the LI-7500/A/RS/DS

Measure the north, east, and vertical offsets.

- ** Northward Separation (cm):** North (positive) or south (negative) distance between the anemometer and gas analyzer sample volumes.
- ** Eastward Separation (cm):** East (positive) or west (negative) distance between the anemometer and gas analyzer sample volumes.
- ** Vertical Separation (cm):** Distance between the anemometer midline and the gas analyzer sample midline. Positive value if the inlet is above the anemometer midline; negative value if the inlet is below the anemometer midline.

## For the LI-7200/RS

Measure the north, east, and vertical offsets.

- ** Northward Separation (cm):** North (positive) or south (negative) distance between the anemometer sample volume and the gas analyzer air inlet.
- ** Eastward Separation (cm):** East (positive) or west (negative) distance between the anemometer sample volume and the gas analyzer air inlet.
- ** Vertical Separation (cm):** Distance between the anemometer midline and the gas analyzer air inlet. Positive value if the inlet is above the anemometer midline; negative value if the inlet is below the anemometer midline.

## For the LI-7700

Measure the north, east, and vertical offsets.

- ** Northward Separation (cm):** North (positive) or south (negative) distance between the anemometer and LI-7700 sample volume midpoint.
- ** Eastward Separation (cm):** East (positive) or west (negative) distance between the anemometer and LI-7700 sample volume midpoint.
- ** Vertical Separation (cm):** Distance between the anemometer midline and the LI-7700 sample midline. Positive value if the midline is above the anemometer midline; negative value if the midline is below the anemometer midline.
