# Iterative calculations of micrometeorological variables

If, throughout the calculation of micrometeorological variables, sonic temperature was used as a proxy of air temperature, this is refined at the end to account for the effect of ambient humidity. Thus, an iteration is performed to recalculate all micrometeorological variables (including air temperature) with the refined temperature estimates. One iteration typically improves the estimates by about 1-2%, while further iterations normally do not bring detectable improvements. Obviously, if a "native" ambient air temperature measurement is available, the iteration is not performed.

!!! note

    This page describes the refinement of air temperature and the micrometeorological variables derived from it. It is unrelated to the **Iterate the correction** option of the spectral corrections, which repeats the spectral correction until the stability it assumes and the one it produces agree; see [Spectral corrections](spectral-corrections.md#top).
