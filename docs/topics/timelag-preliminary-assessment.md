# Timelag preliminary assessment

Under: Advanced Settings > Processing Options > Time lags compensation > Timelag preliminary assessment...

Before processing, you have to tell EddyFlow where to look for each gas's time lag: a **Nominal time lag** and a window between a **Minimum** and a **Maximum time lag**, per column of the metadata (see [Nominal, minimal, and maximum time lag](nominal-time-lag.md#top)). A window that misses the real lag pins covariance maximization or PWB to its edge, or makes the run fall back to the nominal value. The preliminary assessment finds out where the lags actually are first. It detects the time lag of a random sample of the half-hours, or of all of them, over a wide search window that ignores the nominal, minimum and maximum lags already set. It then shows, gas by gas, where the detected lags fall, suggests a nominal lag and a window, and writes them to the metadata on request.

![The Timelag Preliminary Assessment dialog after a run](../assets/timelag-preliminary-assessment-dialog.png)

The assessment detects lags with the method selected under **Time lag detection method**: with **Pre-whitening block-bootstrap**, by PWB (see [Pre-whitening block-bootstrap](time-lag-detect-correct.md#pre-whitening-block-bootstrap-pwb)); with any other method, by covariance maximization over the search window, with the project's covariance options (maximized variable, stochastic detrending, baseline subtraction). The button is available whenever **Time lags compensation** is ticked.

!!! note

    The assessment needs raw data. If no raw data folder is set on the Basic Settings page, the folder does not exist, or it holds no raw files of the project's type, the button says so instead of opening the dialog. A raw data folder given as a Google Drive or Dropbox shared link is accepted; its files are listed when the run starts.

## Sample

- **Half-hours to assess:** A slider for the share of the half-hours with raw data that are drawn at random and assessed, on a log scale from 0.1 % to 100 %: each tenfold step takes the same travel. The label beside it gives the share and about how many half-hours that is. At least **10** half-hours are always drawn, however small the share.
- **Default:** The slider opens at a default that depends on the size of the dataset, marked by a small triangle under the slider; double-click the slider to return to it. The default is only a starting point, and any share can be chosen.

    | Dataset | Half-hours | Default share | Half-hours assessed |
    |---|---|---|---|
    | 1 day | 48 | 20 % | 10 (the minimum) |
    | 3 days | 144 | 20 % | 29 |
    | 1 week | 336 | 20 % | 67 |
    | 2 weeks | 672 | 17.3 % | 116 |
    | 1 month | 1440 | 10 % | 144 |
    | 3 months | 4380 | 4.5 % | 197 |
    | 1 year | 17520 | 1.6 % | 280 |
    | 2 years or more | 35040 or more | 1 % | 350 or more |

    The default is 20 % for a dataset of up to about 11 days, 10 % for a month, and falls slowly after that, as 10 % × (1440 / half-hours)<sup>0.72</sup>, to 1 % from two years on. The share shrinks as the dataset grows while the number of half-hours assessed still rises slowly.

- **Run entire dataset:** Assess every half-hour with raw data instead of a sample. The slider moves to 100 % and is locked; unticking the box returns it to where it was. A run over the entire dataset takes as long as the time lag pre-pass of a full run, and it is one. See [Using the result as the project's time lag file](#using-the-result-as-the-projects-time-lag-file).

The sample is drawn from the whole raw data folder, not from the project's processing period (**Select a different period** on the Basic Settings page), so that a short processing period can still be assessed against all the data available.

## Search window

A table with one column per gas of the project and two rows, **From [s]** and **To [s]**: the lags searched for that gas. Double-click a cell to edit it. The heading's tooltip says whether the gas is measured by a closed-path or an open-path analyser and, for a closed path, the transit time of its intake tube.

The window opens wide, so that the real lag is inside it whatever the metadata says:

- **Open path:** from −5 s to +5 s.
- **Closed path:** from 0 s to three times the tube transit time plus 10 s, rounded up. The transit time is the tube's volume divided by its flow rate, from the analyser's tube length, inner diameter and flow rate in the metadata, as EddyFlow derives a default lag. Where the tube is not described, 0 s to 30 s.

A wider window costs processing time, and with PWB it also lengthens the bootstrap blocks (see **Block length** in [PWB time lag optimization settings dialog](pwb-time-lag-settings.md#bootstrap-and-reliability)). If many lags come out at an edge of the window, widen it and run again.

## Running the assessment

- **Run assessment:** Start the assessment. While it runs the button reads **Cancel** and stops it, the sample and the search windows cannot be changed, and the main window waits. A progress bar shows how many of the drawn half-hours are done and about how long is left. Until the engine has listed the raw files and read the metadata, the bar shows that it is busy without a count.
- **Keep pre-assessment outputs:** See [Outputs](#outputs). Off by default.
- **Show engine output:** Appears when a run fails or detects no lag, and shows what the engine printed.

The assessment always runs split across all the processor cores, whatever the main window's **Parallelise the planar fit and time lag pre-passes** setting says (see [Advanced settings: processing options](raw-processing-options.md#parallelise-the-planar-fit-and-time-lag-pre-passes)). Its result does not depend on how the half-hours are shared out.

The engine runs on a throw-away copy of the project and of its metadata, written to a temporary folder with an engine home folder of its own. Your project and metadata files are not written, a project with unsaved changes stays unsaved (and the copy includes those changes), and a run started from the main window is not disturbed. The copy runs in advanced mode over the whole dataset as an assessment-only time lag pre-pass, without the flux correction step.

## Detected time lags

A bar chart of the lags found for one gas:

- **Gas:** The gas shown. Clicking a gas's column in the suggestions table below shows it too.
- **Bin width:** The width of each bar, in seconds (default 0.5 s).
- **Include lags at the window edges:** A lag at either end of the search window is where the covariance was still rising, not a peak. Such lags are always drawn, stacked in grey on top of the others; ticked, they also count towards the suggestions. Unticked by default.
- **Only half-hours above the flux threshold:** Use only the half-hours whose flux cleared the minimum flux of the automatic time lag optimization (`gas_<i>_to_min_flux`, and `to_le_min_flux` for water vapor, set in the [Time lag optimization settings](time-lag-detect-correct.md#automatic-time-lag-optimization)). A weak flux gives a poorly defined lag, but the threshold is compared with the signed flux, so for a gas that is mostly taken up rather than emitted it may drop every half-hour. Unticked by default, and not available with PWB, which judges each detection itself.

Vertical lines mark the suggested **nominal** lag (solid) and the **min** and **max** of the window (dashed). They follow any edit to the suggestions. Below the chart, a line gives how many half-hours are shown, the window searched and, if any, how many lags fell at a window edge.

## Suggested time lags

A table with one column per gas and four rows:

- **Lags used:** How many of the gas's detected lags the suggestion is made from, out of all detected for it.
- **Nominal [s]:** The median of the lags used.
- **Minimum [s]** and **Maximum [s]:** The median minus and plus `to_pg_range` robust standard deviations, the robust standard deviation being the median absolute deviation divided by 0.6745, never taken as less than 0.1 s. This is the rule the [automatic time lag optimization](time-lag-detect-correct.md#time-lag-optimization-for-passive-gases) uses for passive gases, with its **Plausibility range around median value** setting (`to_pg_range`, 1.5 by default). For a closed path the minimum is never below 0 s, and neither value goes outside the window searched.

Double-click a value to edit it before setting it in the metadata.

A gas with a remark shows an icon in its column heading: a warning sign for a remark that calls the suggestion into question, an information sign otherwise. Hover anywhere over the column to read it. The remarks are:

- **No clear peak:** The suggested window covers more than half of the window searched, so the lags are spread out rather than gathered at one value. Check the chart before using the suggestion.
- **Too few usable lags:** Fewer than 5 lags were left to suggest anything from, and the column holds no values.
- **Not detected in any half-hour.**
- **Water vapor:** Its lag grows with relative humidity, so a single window is a compromise. The automatic time lag optimization handles this with humidity classes (see [Time lag optimization for water vapor](time-lag-detect-correct.md#time-lag-optimization-for-water-vapor)).

## Set in metadata

Writes each gas's nominal, minimum and maximum lag, as they stand in the table, to that gas's column in the metadata (`col_<N>_nom_timelag`, `col_<N>_min_timelag`, `col_<N>_max_timelag`). The metadata is then saved as after any other edit. Gases without a suggestion are left as they are. A summary says what was written where.

What else changes depends on the time lag detection method:

- **Automatic time lag optimization** and **Pre-whitening block-bootstrap** search windows of their own (`gas_<i>_to_min_lag` / `gas_<i>_to_max_lag`, `gas_<i>_pwb_min_lag` / `gas_<i>_pwb_max_lag`), which would otherwise go on overriding the metadata. The minimum and maximum also become that window, rounded outwards to 0.1 s.
- **Covariance maximization** and **Covariance maximization with default** read the metadata directly.
- **Constant** uses only the nominal lag.

If the project reads its metadata from the raw files (GHG files without an alternative metadata file), the metadata is not changed; only the methods' own windows are.

If the project reads the PWB time lag table of an earlier entire-dataset assessment (see below), you are asked first. That table was detected with the search window, and the engine refuses a PWB table whose windows differ from the project's, stopping with "PWB time-lag file was written under different PWB settings". Answer **Yes** to set the suggested windows and have the project detect its lags itself again. Answer **No** to write the metadata only and keep using the table.

## Using the result as the project's time lag file

A run over the entire dataset is a time lag pre-pass like any other. Whether or not the outputs are kept, it leaves in the project's output folder the file that pre-pass leaves:

- **Covariance-based methods:** the time lag optimization results (`<id>_timelag_opt_<timestamp>.txt`), with the project's water vapor humidity classes.
- **Pre-whitening block-bootstrap:** the half-hourly PWB time lag table (`<id>_pwb_timelag_<timestamp>.csv`) and its aggregate summary (`<id>_pwb_timelag_opt_<timestamp>.txt`).

With **Automatic time lag optimization** or **Pre-whitening block-bootstrap** selected, the **Use time lag file in project** button then appears. It sets the project to **Time-lag file available** (`to_mode=0`) and selects the file (`to_file`), so the project's run reads its time lags from it instead of repeating the pre-pass. Under PWB, where the file is the half-hourly table, the project's PWB search windows are also set to the windows searched, the ones the table was detected with, since the engine accepts the table only under those. The other methods do not read such a file, so the button does not appear for them.

The file reflects the wide search windows of the assessment, not the narrower windows you may set afterwards. Under the automatic optimization that is what the pre-pass is for. Under PWB, see the question described in [Set in metadata](#set-in-metadata).

## Outputs

The assessment's outputs are written to its temporary folder and removed when the dialog closes, unless **Keep pre-assessment outputs** is ticked. Then the folder is copied to `tlag_preassessment_<yyyyMMdd-HHmm>` in the project's output folder, or beside the project file if the output folder is not a local folder. The copy is refreshed when the dialog closes, so the charts and suggestions saved are the ones you ended with. It holds:

- `<gas>_timelag_histogram.png`: each gas's chart, as shown in the dialog (same bins, same options, same suggestion), in light colors whatever the interface's theme.
- `suggested_timelags.csv`: one row per gas with the lags used, the nominal, minimum and maximum lags, and the remark.
- `out/<id>_tlag_preassess_<timestamp>.csv`: every lag detected, one row per half-hour and gas, with the columns `date`, `time`, `gas`, `gas_record` (the project's `gas_<i>` record), `method` (`maxcov` or `pwb`), `detected_lag_s`, `window_min_s`, `window_max_s`, `at_edge`, `flux` and `flux_ok`. The lags are taken before the automatic optimization's flux and window-edge filters drop anything. Under PWB the lag is each half-hour's own detection, before any gap-filling, and the flux columns are empty.
- `out/`: the rest of the engine's output, among them the time lag optimization file and the run log.
- `preassess.<ext>` and `preassess.metadata`: the copies of the project and metadata the engine ran on.
- `home/`: the engine's working folder.

## Project-file keys

The assessment adds four keys to the copy of the project it runs, in `[RawProcess_TimelagOptimization_Settings]`. They are never written to your project. They are listed here for running the engine by hand:

- `to_sample_frac`: Share of the half-hours with raw data to walk, from 0 to 1. Absent or 0, every half-hour is walked.
- `to_sample_min_n`: The fewest half-hours drawn (default 10).
- `to_sample_seed`: Seed of the random draw. The same seed draws the same half-hours, serial or split across workers.
- `to_dump_lags`: `1` writes `<id>_tlag_preassess_<timestamp>.csv`.

They act only in an on-the-fly time lag pre-pass (`to_mode=1` with `tlag_meth` 4 or 5). With `tlag_assessment_only=1` the run stops after the pre-pass.

## Dialog buttons

- **Set in metadata:** See [Set in metadata](#set-in-metadata).
- **Use time lag file in project:** See [Using the result as the project's time lag file](#using-the-result-as-the-projects-time-lag-file).
- **Close:** Close the dialog. A running assessment is stopped first, after you confirm. The outputs are removed unless kept.
