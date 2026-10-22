# Linear scaling

EddyFlow allows a linear transformation to take each variable, either sensitive or non sensitive, from an input range to a defined output range. This operation is normally used to convert raw voltages into physical units, but it can be used for any other rescaling purpose. The linear transformation is performed by providing gain and offset scaling factors.

Conversions are performed according to:

$$
X_{\mathit{out}} = \mathrm{Gain} \cdot X_{\mathit{in}} + \mathrm{Offset} \tag{5-3}
$$

Xout is the output value, Xin is the input value, Gain is the gain value, and Offset is the offset value
