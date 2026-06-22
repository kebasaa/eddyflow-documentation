---
title: "Linear Scaling"
source_url: "https://www.licor.com/support/EddyPro/topics/conversion-type.html"
---
# Linear scaling

EddyFlow allows a linear transformation to take each variable, either sensitive or non sensitive, from an input range to a defined output range. This operation is normally used to convert raw voltages into physical units, but it can be used for any other rescaling purpose. The linear transformation is performed by providing gain and offset scaling factors.

Conversions are performed according to:

5‑3
                                                            ![Xout=A*Xin+B](https://www.licor.com/support/GeneratedImages/Equations/Equation901.svg)

Xout is the output value, Xin is the input value, Gain is the gain value, and Offset is the offset value
