# CEC settings dialog

Under: Advanced Settings > Processing Options > Other options > Conditional Eddy Covariance

Activating **Conditional Eddy Covariance** under **Other options** will cause the **CEC Settings** button to activate. Click on it to open the CEC configuration dialog and configure the quality gates used to accept or reject partitioning results, and the channels used for partitioning. For an explanation of the CEC method itself, its output variables, and its assumptions and limitations, see [Conditional Eddy Covariance](conditional-eddy-covariance.md#top). This page documents only the dialog fields.

## Canopy parameter

- **Canopy height:** The height of the canopy above the zero-plane displacement, used by CEC to characterize the measurement height relative to the canopy.

## Partitioning quality gates

These settings define the data-quality conditions that a flux averaging period must meet before EddyFlow reports a CEC-partitioned result. Periods that fail a gate are still processed conventionally, but the corresponding CEC output columns are flagged or left unavailable for that period.

- **Minimum octant-1/octant-2 ratio:** Minimum allowed ratio between the number of samples in the stomatal and non-stomatal conditional classes (the two ejection octants used by CEC). Ratios below this threshold indicate that one class is too poorly represented relative to the other for a reliable partition.
- **Minimum data fraction per octant:** Minimum fraction of all samples in the averaging period that must fall into each of the two conditional octants (stomatal and non-stomatal). This corresponds to the conditional sample size criterion described by Zahn et al. (2022).
- **Minimum valid data fraction:** Minimum fraction of raw records in the averaging period that must be valid (i.e., not removed by despiking or other quality tests) for CEC partitioning to be attempted.
- **Minimum signal strength:** Minimum instrument signal strength (AGC or equivalent, depending on the gas analyzer) required for the averaging period to be used in partitioning. Low signal strength indicates degraded optical measurement quality that can bias the high-frequency fluctuations used by CEC.
- **Maximum gap-filled fraction:** Maximum allowed fraction of the high-frequency time series that may consist of gap-filled (rather than measured) records. CEC relies on the instantaneous covariation between vertical wind and scalar fluctuations, which gap-filled records cannot reliably provide.
- **Maximum non-stationarity:** Maximum allowed non-stationarity, evaluated using the original criterion described by Zahn et al. (2022), above which the averaging period is excluded from partitioning.
- **Minimum flux/random-error ratio:** *(Added in engine 8.0.0.)* Minimum ratio of the total flux to its random uncertainty required before CEC attempts to partition it. This gate ensures that CEC only partitions a flux that is itself resolvable above its own noise.
- **Non-stationarity mode:** *(Added in engine 8.0.0.)* Selects which non-stationarity criterion is applied: the original Zahn et al. (2022) criterion, which judges the stationarity of the high-frequency flux itself, or an alternative criterion that instead judges the stationarity of the partition (the conditional flux ratio) rather than the underlying flux.
- **Per-species non-stationarity threshold:** *(Added in engine 8.0.0.)* When the alternative non-stationarity mode is selected, this sets the maximum allowed non-stationarity individually for each partitioned species (e.g., carbon dioxide, water vapor, or an additional paired species such as carbonyl sulfide).

## Channel pairing table

The channel pairing table lets you define which measured channels CEC should use for partitioning, instead of relying on a single fixed carbon dioxide/water vapor pair. Each row in the table pairs two channels — for example, carbon dioxide and water vapor from the same gas analyzer, or carbon dioxide and water vapor from different instruments — so that partitioning can be run on more than one instrument combination in the same processing run. The table also accepts channels for other trace species, such as carbonyl sulfide (COS), allowing CEC to be applied beyond the standard evapotranspiration and net carbon dioxide flux partitioning.

Use the table to add, remove, or edit pairs:

- Add a pair and select the two channels (vertical wind is implicit; select the two scalar channels to be conditionally sampled together).
- Remove a pair that is no longer needed.
- Edit an existing pair to point to a different channel, for example after reconfiguring instruments.

!!! note

    The minimum flux/random-error ratio gate and the non-stationarity mode/per-species threshold settings were introduced in engine 8.0.0 as refinements to the original Zahn et al. (2022) quality criteria. Datasets processed with earlier engine versions used only the conditional sample size, valid data fraction, signal strength, gap-filled fraction, and the original non-stationarity criterion.
