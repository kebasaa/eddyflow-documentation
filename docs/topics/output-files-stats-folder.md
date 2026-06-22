# Statistics output

Along with the final results files, EddyFlow creates at least one subfolder in the user-specified output folder:

..\\eddypro_stats\\: contains seven files of basic statistics calculated on all available [sensitive variables](sensitive-and-nonsensitive-variables.md), at 7 different levels of processing. These files have a static format that includes statistical data for all sensitive variables, except the analyzer's [cell in/out temperature](calculate-cell-temperature.md). Statistics for variables that are not available are replaced by the string "n/a" (not available).

The seven levels of statistics refer to those calculated on the following datasets:

1. Unprocessed (dataset as imported from the raw file)
2. After despiking
3. After crosswind correction
4. After Angle of Attack correction
5. After double rotation for tilt correction
6. After time lag compensation
7. After detrending

..\\eddypro_user_stats\\: contains seven files of basic statistics calculated on all available [non-sensitive variables](sensitive-and-nonsensitive-variables.md) (including user-defined variables and sensitive variables not used for flux computation). These files have a dynamic format, including statistics only for available non-sensitive variables. This folder and the seven files contained in it are created only if EddyFlow detects at least one non-sensitive variable.

Like the statistics calculated on sensitive variables, the seven levels of statistics refer to those calculated on the following datasets:

1. Unprocessed (dataset as imported from the raw file)
2. After despiking
3. After crosswind correction
4. After Angle of Attack correction
5. After double rotation for tilt correction
6. After time lag compensation
7. After detrending

** Note:** Statistics on non-sensitive variables may result in seemingly wrong values (such as zero or not-a-number). This may happen when, for example, a variable has a constant value throughout the file, as with some instrument diagnostic variables. In these cases, however, high order statistics lose representativeness and usefulness.

## Statistics files content

The statistics file is described below and in [Table 3‑3](#stats).

### File information

- Raw file name
- Date and time of the end of the averaging period
- Number of valid records used for the current averaging period

### Statistics

- Mean values
- Variances
- Covariances of all variables with the three wind components
- Standard deviations
- Skewness
- Kurtosis

| Label | Description |
| --- | --- |
| filename | Name of the raw file (or first file of a set) from which the data in the current averaging interval was extracted |
| date | Date of the end of the averaging period |
| time | Time of the end of the averaging period |
| n_samples | Number of valid records found in the raw file (or set of raw files) |
| mean (var) | Mean value of variable (var) |
| var (var) | Variance of variable (var) |
| cov (u/var) | Covariance between the u wind component and var |
| cov(v/var) | Covariance between the v wind component and var |
| cov (w/var) | Covariance between the w wind component and var |
| st_dev(var) | standard deviation of variable var |
| skw(var) | skewness of variable var |
| kur(var) | kurtosis of variable var |
