# Calculating turbulent fluxes level 0 (uncorrected fluxes)

Level 0 fluxes are uncorrected. They are computed according to the following equations:

## Ambient sensible heat flux, uncorrected (H, W m-2)

$$
H_o = \rho_a c_p \overline{w'{T_s}'} \tag{6-51}
$$

## CO2 flux, uncorrected (F0,co2, μmol m-2 s-1)

If CO2 is measured as molar density with an open path analyzer:

$$
F_{0,co_2} = 10^3 \cdot \overline{w'd'_{co_2}} \tag{6-52}
$$

If CO2 is measured as molar density with a closed path analyzer:

$$
F_{0,co_2} = 10^3 \cdot \overline{w'd'_{co_2}} \tag{6-53}
$$

If CO2 is measured as mixing ratio:

$$
F_{0,co_2} = \frac{1}{v_d} \cdot \overline{w'r'_{co_2}} \tag{6-54}
$$

If CO2 is measured as mole fraction:

$$
F_{0,co_2} = \frac{1}{v_a} \cdot \overline{w'\chi'_{co_2}} \tag{6-55}
$$

## H2O flux, uncorrected (F0,co2, mmol m-2 s-1)

If H2O is measured as molar density with an open path analyzer:

$$
F_{0,h_2 o} = \overline{w'd'_{h2o}} \tag{6-56}
$$

If H2O is measured as molar density with a closed path analyzer:

$$
F_{0,h_2 o} = \overline{w'd'_{h_2 o}} \tag{6-57}
$$

If H2O is measured as mixing ratio:

$$
F_{0,h_2 o} = \frac{1}{v_d} \cdot \overline{w'r'_{h_2 o}} \tag{6-58}
$$

If H2O is measured as mole fraction:

$$
F_{0,h_2 o} = \frac{1}{v_a} \cdot \overline{w'\chi'_{h_2 o}} \tag{6-59}
$$

## CH4 flux, uncorrected: (F0,ch4, μmol m-2 s-1)

If CH4 is measured as molar density with an open path analyzer:

$$
F_{0,ch_4} = \overline{w'd'_{ch_4}} \tag{6-60}
$$

If CH4 is measured as molar density with a closed path analyzer:

$$
F_{0,ch_4} = \overline{w'd'_{ch_4}} \tag{6-61}
$$

If CH4 is measured as mixing ratio:

$$
F_{0,ch_4} = \frac{1}{v_d} \cdot \overline{w'r'_{ch_4}} \tag{6-62}
$$

If CH4 is measured as mole fraction:

$$
F_{0,ch_4} = \frac{1}{v_a} \cdot \overline{w'\chi'_{ch_4}} \tag{6-63}
$$

## Latent heat flux, uncorrected (LE0, W m-2)

$$
LE_0 = 10^{-3} F_{0,h_2 o} \cdot \lambda \cdot M_{h_2 o} \tag{6-64}
$$

## Evapotranspiration flux, uncorrected: (E0, kg m-2 s-1)

$$
E_0 = 10^{-3} F_{0,h_2 o} \cdot M_{h_2 o} \tag{6-65}
$$

## Momentum flux, uncorrected: (T0, kg m-1 s-2)

Calculated after [van Dijk et al. (2004)](references.md#vanDijk), eq. 2.85

$$
T_0 = \rho_a \sqrt{\overline{u'w'}^2 + \overline{v'w'}^2} \tag{6-66}
$$

## Friction velocity (u*, ms-1)

Calculated according to its definition as:

$$
u_* = \left(\overline{u'w'}^2 + \overline{v'w'}^2\right)^{1/4} \tag{6-67}
$$

## Potential temperature (Tp, K)

Calculated according to:

$$
T_p = T_a \cdot \left(\frac{P_{0,a}}{P_a}\right)^{0.286} \tag{6-68}
$$

where P0,a*=10*5 Pa, and is the reference pressure.

## Monin-Obukhov length (L, m)

Calculated according to its definition as:

$$
L = -\frac{T_p u_*^3}{\kappa \cdot g \cdot \frac{H_0}{\rho_a c_p}} \tag{6-69}
$$

where κ = ~0.41, and is the von Kármán constant; g = ~9.81 m s-1, and is the gravity.

## Monin-Obukhov stability parameter (ζ, non-dimensional)

ζ is calculated as:

$$
\zeta = \frac{h_m - d}{L} \tag{6-70}
$$

where hm is the measurement height above the ground, as measured in the center of the anemometer measurement volume, and d is the [displacement height](displacement-height.md).

## Dynamic temperature (T*, K)

Calculated according to its definition (e.g., [Foken and Wichura, 1996](references.md#Foken)):

$$
T_* = -\frac{\overline{w'{T_s}'}}{u_*} \tag{6-71}
$$
