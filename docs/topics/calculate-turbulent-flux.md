# Calculating turbulent fluctuations

See [Turbulent fluctuations](selecting-advanced-options.md#Turbulen) for more information.

Different methods are described in literature for extracting turbulent fluctuations from time series data. The most commonly applied, in the context of eddy covariance, are the block-averaging, linear detrending ([Gash and Culf, 1996](references.md#Gash)) and two types of high-pass filters, namely the moving average ([Moncrieff et al., 2004](references.md#Moncrieff)) and the exponentially weighted average ([McMillen, 1988](references.md#McMillen); [Rannik and Vesala, 1999](references.md#Rannik)).

High-pass filters determine a local mean value in a time series by an averaging procedure that evaluates neighboring samples in order to extract a local trend and then removes this trend from the original data. The linear detrending method implies calculating deviations around any linear trend evaluated, for example, on the whole flux averaging period.

Block averaging, or Reynolds averaging, is the simple operation of calculating the mean value of the variable and calculating turbulence fluctuations as individual departures from the mean. There are benefits and drawbacks to all methods, related to the amount of genuine vs. artificial (e.g. instrumental drift) low frequency information that is eliminated when the trend is removed.

** Note:** A block-averaging procedure is unavoidable at the moment when fluxes are evaluated by splitting the time series into flux averaging intervals. This procedure does partially dampen low frequency contributions as well.

For a thorough discussion refer to [Moncrieff et al., 2004](references.md#Moncrieff) and [Rannik and Vesala, 1999](references.md#Rannik).
