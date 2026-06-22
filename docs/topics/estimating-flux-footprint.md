---
title: "Estimating the Flux Footprint"
source_url: "https://www.licor.com/support/EddyPro/topics/estimating-flux-footprint.html"
---
# Estimating the flux footprint

See [Footprint estimation](selecting-advanced-options.md#Footprin) for more information.

EddyFlow features three crosswind-integrated flux footprint models, useful to estimate the upwind area contributing to the measured fluxes. The flux footprint functions estimate the location and relative importance of passive scalar sources influencing flux measurements at a given receptor height, depending on receptor height, atmospheric stability, and surface roughness (Kljun et al., 2004). Regardless of the chosen model, the footprint estimation is provided as a set of distances from the anemometer location in the direction from which the wind blows. These distances express:

- Peak distance: the distance from the anemometer in the direction from which the largest relative individual contribution to the flux originates.
- Offset distance: the area between the anemometer and the offset provides up to 1% of the total flux.
- 10%, 30%, 50%, 70%, 90%: the area between the anemometer and the NN% distance provides NN% of the total flux.

Hereafter, a short introduction to the implemented models is provided. Please refer to the respective papers for in-depth information and for an informed selection of the method to be used. The default option in EddyFlow is the parameterization of Kljun et al. (2004), merely because it is the newest 'model' and it is a thoroughly validated one. However, at this stage we explicitly don't advocate the use of a particular model among those available.

## Footprint parameterization from Kljun et al (2004)

A footprint estimation is provided according to the "simple footprint parameterization" described in [Kljun et al. (2004)](references.md#Kljun). The set of distances is calculated according to:

Peak contributing distance (m):

6‑121
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1052.svg), ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1053.svg)

NN% contribution (m):

6‑122
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1054.svg), ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1055.svg)

The second equation is used to provide the offset distance (NN = 1) and the 10% to 90% distances. In these equations, parameters c and d are calculated using Eqs. 13 to 16 in Kljun et al. (2004) (where the roughness length enters as a parameter). The distance L'[1 The FORTRAN source code for this calculation, along with the tabulated values of L', were shared by the main author of the model, Natascha Kljun, for being embedded into ECO2S, and subsequently, EddyFlow. We gratefully acknowledge Dr. Kljun for this contribution.](#) is tabulated for each percentage between 0 and 95% (see Figure A1 in the referenced paper). All other quantities are routinely calculated by EddyFlow.

The footprint parameterization is valid only in certain ranges of micrometeorological conditions, well specified in the [Kljun et al. (2004)](references.md#Kljun). In particular, the model is claimed to be valid if the following conditions hold:

- The measurement height is lower than the boundary layer height;
- The terrain is dynamically homogeneous;
- The stability parameter is in the range of: -200 < ζ < 1;
- The friction velocity is larger than a specific threshold: u. ≥ 0.2 m s-1;
- The measurement height is larger than 1 m: hm ≥ 1m.

## Footprint model from Kormann and Meixner (2001)

This is a crosswind integrated model based on the solution of the two dimensional advection-diffusion equation given, e.g., by van Ulden (1978) for power-law profiles in wind velocity and eddy diffusivity. Contributing distances are calculated according to (Eq. 21 in the original paper):

6‑123
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1056.svg)

where x is the distance from the location of the anemometer measured in the wind direction, ξ = ξ(z) is a flux length scale that depends on the height above the ground z, μ is a dimensionless model constant and Γ(μ) is the gamma function. The equation is actually used to calculate x, given the fraction of the flux contribution of interest (10%, 30%, etc.). The equation for the peak distance is explicitly derived by the authors (Eq. 22), by merely finding the maximum from the former equation:

6‑124
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1057.svg) .

## Footprint model from Hsieh et al. (2000)

This is a crosswind integrated model based on the former model of Gash (1986) and on simulations with a Lagrangian stochastic model. Contributing distances are calculated according to (Eq. 17 in the original paper):

6‑125
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1058.svg)

where, again, x and z are the upwind distance from the measuring location and the measuring height, L is the Monin-Obukhov length and k, D, P, zu are model-specific parameters.

Similar to Kormann and Meixner (2001), the equation above is actually used to calculate x, given the fraction of the flux contribution of interest (10%, 30%, etc.). The equation for the peak distance is explicitly derived by the authors (Eq. 19), by merely finding the maximum from the former equation:

6‑126
                                                            ![](https://www.licor.com/support/GeneratedImages/Equations/Equation1059.svg) .
