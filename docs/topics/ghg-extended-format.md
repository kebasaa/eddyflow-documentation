# Extended .ghg files (format version 2.0)

EddyFlow supports instruments, and site descriptions, that LI-COR's
[.ghg format](ghg-file-format.md) has no place for. The extended format adds
what EddyFlow needs **without giving up the ability to open the file in
EddyPro**, by describing the site twice: once in the keys EddyPro validates, and
once in additive keys beside them that EddyPro ignores.

Everything on this page was tested against EddyPro 7.0.9 rather than inferred.

## Why extending is possible at all

A `.metadata` file is an INI file whose keys are matched **by exact name**. Three
consequences make the extension safe:

1. **Unknown keys are ignored.** A key neither engine's tag table names is simply
   never looked up. Adding keys changes nothing about how EddyPro reads the file.
   Note this is about *reading*: EddyFlow's Metadata File Editor rewrites the
   `[Instruments]` and `[FileDescription]` sections wholesale when it saves, so
   the added keys do not survive a save there. That is deliberate - see
   [In the interface](#in-the-interface) below.
2. **Unselected columns are never validated.** A column is only inspected if the
   *project* points at it. Extra `col_N_*` blocks - a fifth gas species, a new
   record type - are invisible to a project that does not select them.
3. **Unrecognised instruments are refused; generic ones are not.** EddyPro checks
   `manufacturer` and `model` against fixed lists and rejects anything else
   outright. But `generic_open_path`, `generic_closed_path` and `generic_sonic`
   are accepted, provided the instrument states real geometry.

Point 3 is the one that costs something, and it is why the format works the way
it does.

!!! warning "There is no version negotiation, and there cannot be"
    Because unknown keys are ignored, EddyPro **cannot detect** that a file is
    written in this format. `ghg_format_version` is read by EddyFlow and by
    nothing else; it will not make EddyPro refuse a file it only partly
    understands. Compatibility rests entirely on the file being self-consistently
    processable under EddyPro's own rules - which is what the stand-in rule below
    guarantees.

## The stand-in rule

Where an instrument is one EddyPro does not know, the file declares it **twice**:

    ; what EddyPro validates - a generic model with the instrument's real geometry
    instr_2_manufacturer=other_irga
    instr_2_model=generic_open_path_1
    instr_2_hpath_length=12.5
    instr_2_vpath_length=12.5
    instr_2_tau=0.1

    ; what EddyFlow reads instead
    instr_2_ef_model=csi_ec150_1

EddyFlow prefers `instr_<k>_ef_model` and re-derives the manufacturer from it, so
it processes the real instrument. EddyPro never looks the key up and processes a
generic open-path analyser with correct path lengths and time response.

!!! note "Columns bind to instruments by name - use the stand-in's"
    `col_N_instrument` names the instrument's `model` string, not its block
    number. In an extended file it must name the **stand-in**
    (`generic_open_path_1`), because that is the only name EddyPro knows. EddyFlow
    matches on the file's spelling as well as on the model it resolved from
    `ef_model`, so naming the stand-in satisfies both engines; naming the real
    model satisfies neither.

    A `col_N_instrument` that matches no instrument makes EddyPro refuse the whole
    archive with `Invalid metadata. / At least one variable is associated with an
    inexistent instrument.` - reported against a **column number**, not against
    the instrument, which is a confusing way to be told about a typo.

### What the stand-in costs, measured

**Nothing, provided the geometry is stated truthfully.**

One LI-7500A archive through EddyPro 7.0.9 twice - as itself, and as a
`generic_open_path` stand-in declaring the analyser's real path lengths and time
response - is **bit-identical across all 189 output columns**. The same archive
through EddyFlow twice, with and without `ef_model`, moves **no value at all**;
the only difference is the analyser's name in two column labels
(`co2_li7500a_1_mean`).

The cost is therefore in the *geometry declaration*, not in the mechanism. It is
worth knowing how much, because it is what a carelessly written stand-in buys:
declaring 12.5 cm of horizontal path where the LI-7500A has 0.95 cm moves

| | EddyPro | EddyFlow |
|---|---|---|
| `LE`, `h2o_flux`, `ET`, `bowen_ratio` | 0.237 % | 0.205 % |
| `co2_flux` | 0.012 % | 0.013 % |
| `LE_scf`, `co2_scf`, `h2o_scf` | 0.010 % | 0.011 % |
| `ch4_flux` | 0.001 % | 0.000 % |
| everything else - Tau, u\*, H, concentrations, time lags, QC flags | identical | identical |

Two independent engines agreeing to within a few thousandths of a percent is
what makes it plain the residual is the geometry and not the stand-in.

!!! important "State the instrument's real geometry"
    `hpath_length`, `vpath_length` and `tau` are the only things EddyPro has left
    to work from once the model is generic. They are not a formality to satisfy
    the validator - they are the correction. A stand-in carrying plausible but
    wrong numbers processes cleanly and reports fluxes that are quietly wrong.

## Which instruments need which treatment

Two different problems wear the same clothes, and they need different files.

EddyPro's vocabulary below is taken from
[eddypro-engine](https://github.com/LI-COR-Environmental/eddypro-engine)
`metadata_file_validation.f90`, cross-checked against
[eddypro-gui](https://github.com/LI-COR-Environmental/eddypro-gui) and against
the installed 7.0.9 binary. All three agree exactly.

### Renamed: EddyPro knows the device under a different key

Write **EddyPro's** spelling in `instr_<k>_model`. EddyFlow canonicalises it on
read, so `instr_<k>_ef_model` is optional here and merely makes the intent
explicit.

| Instrument | EddyPro | EddyFlow |
|---|---|---|
| Campbell CSAT3 | `csat3` | `csi_csat3` |
| Campbell CSAT3B | `csat3b` | `csi_csat3b` |

Writing EddyFlow's prefixed spelling instead makes the file unreadable to
EddyPro, which has no prefixed form of either.

### Stood in for: EddyPro has no name for the device at all

Declare the generic model **with the instrument's real geometry**, set the
manufacturer to match it, and name the instrument in `instr_<k>_ef_model`.

| Instrument | EddyFlow | Declare to EddyPro as | Manufacturer |
|---|---|---|---|
| Campbell CSAT3A | `csi_csat3a` | `generic_sonic` | `other_sonic` |
| Campbell CSAT3C | `csi_csat3c` | `generic_sonic` | `other_sonic` |
| Campbell IRGASON, sonic half | `csi_irgason_sonic` | `generic_sonic` | `other_sonic` |
| Campbell EC150 | `csi_ec150` | `generic_open_path` | `other_irga` |
| Campbell IRGASON, analyser half | `csi_irgason_irga` | `generic_open_path` | `other_irga` |
| Campbell EC155 | `csi_ec155` | `generic_closed_path` | `other_irga` |
| Campbell TGA200A | `csi_tga200a` | `generic_closed_path` | `other_irga` |
| MIRO MGA1/5, MGA4/6, MGA9/10, MGAi-N2O | `miro_mga1_5`, `miro_mga4_6`, `miro_mga9_10`, `miro_mgai_n2o` | `generic_closed_path` | `other_irga` |
| Aerodyne TILDAS | `aerodyne_tildas` | `generic_closed_path` | `other_irga` |

!!! warning "The manufacturer has to move with the model"
    EddyPro validates `manufacturer` and `model` against **separate** lists, and
    its analyser firms are only `licor` and `other_irga` - it has no `csi_irga`,
    `miro` or `aerodyne`. A stand-in that keeps the real manufacturer fails the
    firm test rather than the model one, and the message names neither.

### Identical on both sides

Every Gill, Young and Metek sonic, every LI-COR analyser, and the krypton and
Lyman-alpha hygrometers are spelt the same in both programs and need nothing.

## Three places a name propagates

`col_<n>_instrument` is the one that catches people, but it is not the only one.
An instrument declared as a stand-in must be referred to by the **stand-in's**
name everywhere EddyPro will read, and by the real name everywhere EddyFlow
will:

| Where | In a `.ghg` read by EddyPro | In an EddyFlow project |
|---|---|---|
| `instr_<k>_model` | the stand-in | (from `ef_model`) |
| `col_<n>_instrument` | the stand-in | resolved from the file |
| `master_sonic`, in the **project** | the stand-in | the real model |

Getting `master_sonic` wrong is the least obvious of the three: it produces
`At least one among u, v, w and a fast temperature is missing`, which does not
mention instruments at all.

## Saving in the Metadata File Editor drops the dual naming

Opening an extended archive in EddyFlow's editor and saving writes an
**EddyFlow-native** metadata: the real model in `instr_<k>_model`, the columns
repointed to it, and no `ef_model` or `ghg_format_version`. This is deliberate,
and is what the editor already does for every legacy spelling it migrates - but
it means a saved file is no longer readable by EddyPro. Keep the archive if you
need to keep that.

## Keys added in version 2.0

| Key | Section | Meaning |
|---|---|---|
| `ghg_format_version` | `[FileDescription]` | `2.0`. Absent means a classic LI-COR archive. |
| `instr_<k>_ef_model` | `[Instruments]` | The instrument's true model. Overrides `instr_<k>_model`, and the manufacturer is re-derived from it. |

Sections are cosmetic - keys are matched by name alone - but writing them where
they belong keeps the file readable by hand.

## Keys the classic format already permits but LI-COR does not write

These need no extension. Both engines' tag tables have always named them; a
LI-COR archive simply omits them and they take their defaults. An extended file
is free to state them, and should state the geometry ones whenever it uses a
stand-in.

Per instrument: `hpath_length`, `vpath_length`, `tau`, `kw`, `ko`, `ac_freq`,
`integrates`.

Per column: `flag_threshold`, `error_value`, `spectro_a`, `spectro_b`, `useit`.

## Limits

|  | EddyPro (fork base) | EddyFlow |
|---|---|---|
| instruments | 5 | 8 |
| raw columns | 100 | 200 |
| gas species | 4 fixed slots | 64 records |

A file that must stay EddyPro-readable should stay within **5 instruments and
100 columns**. Beyond that it is still a valid EddyFlow file, but the
dual-description property no longer holds. EddyFlow itself raises error 97 rather
than silently dropping instruments past its own limit.

## What EddyPro does with an extra species

An unrecognised variable name in a column EddyPro's project does not select is
not literally invisible: EddyPro surfaces it as a **custom variable** and writes
its mean to the output. Adding a `cos` column to an archive changed none of the
191 shared output values and added one column, `cos_mean`.

So extra gas columns are free as far as correctness goes, but they do change the
EddyPro output header. Anything parsing that output by column position needs to
know.

## In the interface

EddyFlow's Metadata File Editor **reads** the extension: open an extended archive
and the instrument table shows the real analyser, taken from `ef_model`, with the
geometry the file declares. The manufacturer is re-derived from that model rather
than read, because the one written beside a stand-in describes the *stand-in* - an
EC150 declared as `generic_open_path` says "Other".

If the model named in `ef_model` is one your build of EddyFlow does not know - an
archive written by a newer release - the interface falls back to showing the
stand-in, which by construction it does know. The file still processes; it is
simply described by the generic.

**Saving produces a plain metadata file, and that is intended.** The stand-in
pair exists only so an *archive* stays readable by EddyPro. A standalone
`.metadata` is under no such obligation, so what gets written names the real
instrument in `model` outright, keeps its geometry, and carries neither
`ef_model` nor `ghg_format_version` - there is nothing left for them to say. So
moving off a `.ghg`'s embedded metadata onto your own file gives you a clean
description of your real analyser.

## Not yet carried

EddyFlow's per-species records - which column supplies a gas's water vapour,
which cell temperature and pressure it uses, its molecular weight and
diffusivity - live in the **project** file. A `.metadata` has never carried them
and, by decision, still does not: `gas_<n>_moist` and `gas_<n>_cell` are project
settings, and adding them to the format would duplicate rather than replace that.

The consequence is worth stating rather than discovering. An extended archive is
**not self-describing**: `gas_<n>_col` pins a metadata column *number* and
`gas_<n>_instr` an instrument *name*, so a project is coupled to the layout of
the archives it was written for, and an archive passed on without its project
cannot say which analyser's water belongs to, say, a carbonyl sulfide column.

They are per-column attributes in all but name, so `col_N_*` keys could carry
them if a self-describing archive is ever wanted.
