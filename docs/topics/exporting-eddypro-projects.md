# Exporting a project to EddyPro

**File > Export > EddyPro Project...** writes the open project as a LI-COR EddyPro 7 project, so the same dataset can be processed in EddyPro for comparison or by a colleague who uses it. The EddyFlow project is not changed: the export works from a copy, and an unsaved project is exported as it is shown and stays unsaved.

EddyFlow measures more gases, knows more instruments and offers more methods than EddyPro. The export does not refuse a project that uses them. It replaces each one with what EddyPro would use (its generic instrument, or its default method) and then lists every replacement in a report.

## Exporting

1. Click **File > Export > EddyPro Project...**. The item is available while a project is open.
2. In **Export to EddyPro: Gas Columns**, choose the metadata column for each of EddyPro's four gas slots. See [Choosing the gas columns](#choosing-the-gas-columns).
3. Choose where to save the **.eddypro** file. The dialog opens beside the current project, under its name.
4. EddyFlow writes the files and shows **EddyPro Project Exported**, which names the files written and lists the changes.

If the metadata file or the report already exists beside the chosen name, EddyFlow asks before replacing it.

## Files written

All three files are written to the folder you choose and named after the file you choose:

| File | Contents |
|---|---|
| `<name>.eddypro` | The processing project, in EddyPro 7.0.9 format (tag `;EDDYPRO_PROCESSING`). |
| `<name>_EP.metadata` | The metadata, in EddyPro's vocabulary. `proj_file` in the project points to it and `use_pfile` is set. |
| `<name>_EP_export_report.txt` | The report shown after the export, as plain text. |

The `_EP` suffix keeps the exported metadata apart from the project's own metadata file, so neither overwrites the other.

A project that reads the metadata embedded in its .ghg files (no alternative metadata file) gets no `_EP.metadata`: EddyPro reads the same embedded metadata, which LI-COR writes in EddyPro's vocabulary. The report notes this.

The paths of other files the project uses (raw data, biomet, spectral assessment, planar fit, time lag optimization, output folder) are written as they are.

## Choosing the gas columns

EddyPro processes one CO<sub>2</sub>, one H<sub>2</sub>O, one CH<sub>4</sub> and one other gas. EddyFlow has no such limit, so before writing anything the export asks which metadata column fills each slot:

- **CO<sub>2</sub>**, **H<sub>2</sub>O** and **CH<sub>4</sub>** each list the metadata's columns of that species.
- **Fourth gas** lists the columns of every other gas species.
- Every slot also offers **None**, which leaves it empty.

The dialog opens on the project's own choice, the first gas record of each species. A gas the project processes that is not chosen here is not exported, and the report lists it under **Gases**.

A column can be chosen even if the project does not process it (for example a second CO<sub>2</sub> analyzer). Its processing settings, such as despiking and absolute limits, then take the species defaults.

### The fourth gas

EddyPro's interface offers N<sub>2</sub>O, CO, SO<sub>2</sub>, O<sub>3</sub>, NH<sub>3</sub>, NO and NO<sub>2</sub> for the fourth gas. Any other species, such as COS, is written in the metadata as `n2o`, which is the name EddyPro's engine gives the fourth gas column anyway, and the report says so.

EddyPro computes the fourth gas with N<sub>2</sub>O's molecular weight and diffusivity unless the project states others (`gas_mw` and `gas_diff`). The export writes the real species' values whenever the fourth gas is not N<sub>2</sub>O, so the fluxes are computed for the right gas.

!!! warning "EddyPro's interface resets the fourth gas's constants"
    If the exported project is opened in EddyPro's interface, it resets the molecular weight and diffusivity to N<sub>2</sub>O's values. Run the project from the command line, or enter the values again in EddyPro. The report repeats this warning whenever it applies.

## What the export changes

The report lists **only the settings that changed**, each as *setting: old value → new value*, with the reason. It is grouped as follows.

### Gases

- A gas the project processes that is in none of the four slots (**not exported**).
- Signal strength (AGC/RSSI) records, which EddyPro has no place for.

### Instruments

An instrument EddyPro does not know becomes EddyPro's generic anemometer or generic open- or closed-path gas analyzer. Its measured geometry (path lengths, time response, tube, separations, extinction coefficients) is kept, which the generic instrument needs to give the same fluxes. These are the same pairs as in [Extended .ghg files](ghg-extended-format.md#stood-in-for-eddypro-has-no-name-for-the-device-at-all):

| Instrument | Exported as | Manufacturer |
|---|---|---|
| Campbell CSAT3A, CSAT3C, IRGASON (sonic half) | `generic_sonic` | `other_sonic` |
| Campbell EC150, IRGASON (analyzer half) | `generic_open_path` | `other_irga` |
| Campbell EC155, TGA200A; MIRO MGA1/5, MGA4/6, MGA9/10, MGAi-N2O; Aerodyne TILDAS | `generic_closed_path` | `other_irga` |

The Campbell CSAT3 and CSAT3B are written under EddyPro's own names, `csat3` and `csat3b`. This is a spelling change only and is not reported. A renamed instrument is renamed everywhere it is referred to: its block in the metadata, every column that names it, and the master anemometer (`master_sonic`) in the project.

The report also lists:

- An instrument with its own sampling rate, because EddyPro samples every instrument at the station's rate.
- An instrument set to average over its sampling interval, because EddyPro treats every reading as instantaneous.
- Instruments beyond EddyPro's five, when no column reads them. They are dropped.

### Variables

- A gas species EddyPro does not know that is not the fourth gas, and the AGC and RSSI variables: set to `ignore`.
- A column in pmol/mol, a unit EddyPro does not have: converted to ppb. The factor 0.001 is applied through the column's gain and offset (`gain_offset` conversion).
- A column-specific missing value other than -9999: removed, because EddyPro recognizes only its own missing-value label.

A variable name EddyFlow does not recognize either, such as a custom variable, is kept: EddyPro accepts custom variables.

### Processing options

Methods EddyPro lacks are replaced, because EddyPro would otherwise read the value as something else. The time lag method becomes EddyPro's closest equivalent; the others become EddyPro's default:

| Setting | EddyFlow-only value | Exported as |
|---|---|---|
| Time lag compensation | Pre-whitening block-bootstrap (Vitale et al. 2024) | Automatic time lag optimization |
| High-frequency spectral correction | Eugster and Senn (1995) | Moncrieff et al. (1997) |
| Quality check flagging policy | Vitale et al. (2020) | Mauder and Foken (2004) |
| Random uncertainty method | Billesbach (2011), Lenschow et al. (2000) | None |
| Despiking method | Consecutive difference (EddyUH) | Vickers and Mahrt (1997) |

Options EddyPro does not have are removed. EddyPro then behaves as if they were off, so each is reported only if it was on:

- Conditional eddy covariance partitioning
- Cospectral model (other than Moncrieff et al. 1997)
- Iterative spectral correction
- Post-flux despiking and storage flux cleaning (Vitale et al. 2020)
- Limit of detection (Langford et al. 2015), flux detection limit, and the random uncertainty scaled by the spectral correction
- Spectroscopic correction (Peltola et al. 2014)
- Covariance maximization against the window's chord, and conditional time lag borrowing (Nemitz et al. 2018)
- Inclinometer tilt correction and Metek head correction
- Instrument malfunction diagnostics (RFlux)
- Assessment-only planar fit and time lag optimization
- Per-instrument limits on missing samples (EddyPro has one limit for all instruments)

Like the pre-whitening method, EddyPro's automatic time lag optimization finds the lags statistically, but it uses its own [time lag optimization settings](time-lag-detect-correct.md#automatic-time-lag-optimization). Check them in EddyPro before running an exported project.

The settings that belong to a removed option, such as the number of iterations of the iterative correction, are removed with it and not listed separately.

## Warnings

Below the changes, the report warns about anything EddyPro may refuse that the export cannot fix without inventing a value:

- **Generic instrument without geometry.** EddyPro rejects a generic instrument whose path lengths or time response are zero, and a generic closed-path analyzer without a tube length, diameter and flow rate. Set them in the metadata before exporting.
- **Fourth gas constants.** See [The fourth gas](#the-fourth-gas). If no diffusivity is known for the fourth gas, EddyPro uses N<sub>2</sub>O's.
- **More than 100 columns.** EddyPro reads at most 100 columns; a gas column beyond that is invisible to it.

## SmartFlux packages

[SmartFlux packages](smartflux-settings.md) also contain an EddyPro project, but they are not affected by this export. A package still refuses a project that uses an option the SmartFlux module cannot run, so that settings are not downgraded silently in the field.
