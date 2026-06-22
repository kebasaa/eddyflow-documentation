# Calculating ambient and cell parameters

The time lag compensation is the last step of raw data reduction. Covariances calculated after time lag compensation will be used to calculate uncorrected and corrected fluxes. Before actually calculating fluxes, EddyFlow evaluates some key average ambient variables such as temperature, pressure, and molar volume. The same quantities are calculated for the cell of each closed path gas analyzer in use (if any).

## Average ambient temperature

In order of priority, ambient temperature (Ta, K) is calculated as:

1. The average ambient temperature, if ambient temperature is available as a raw measurement; or
2. The average sonic temperature. In this case, it will be corrected later to account for effects of ambient humidity ([Schotanus et al., 1983](references.md#Schot)).

## Average ambient air pressure

In order of priority, ambient pressure (Pa, Pa) is computed as:

1. The average ambient pressure, if ambient pressure is available as a raw measurement; or
2. The site barometric pressure, calculated based on site altitude as ([Campbell and Norman, 1998](references.md#Campbell)):

Pa= Pa0e-Site Altitude/8200

where Pa0=101.3 kPa.

## Average ambient air molar volume

Ambient air molar volume (va, m3mol-1) is calculated using ambient air temperature and pressure as:

6‑28
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation964.svg)

where ℜ = 8.314 J mol-1K-1, the universal gas constant.

## Average cell temperature (closed path systems only)

In order of priority, cell temperature (Tc, K) is calculated as:

1. The average cell temperature, if cell temperature is available as a raw measurement or as calculated in [calculating cell temperature](calculate-cell-temperature.md), or
2. The average ambient temperature as calculated above.

## Average cell pressure (closed path systems only)

In order of priority, cell pressure (Pc, Pa) is calculated as:

1. The average cell pressure, if cell pressure is available as a raw measurement; or
2. The average ambient pressure as calculated above.

## Average cell molar volume (closed path systems only)

Cell air molar volume (vc, m3 mol-1) is calculated using cell temperature and pressure as:

6‑29
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation965.svg)

where ℜ = 8.314 J mol-1K-1, the universal gas constant.
