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
   The metadata editor preserves them too, because it writes through `QSettings`
   without clearing keys it does not recognise.
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

## Not yet carried

EddyFlow's per-species records - which column supplies a gas's water vapour,
which cell temperature and pressure it uses, its molecular weight and
diffusivity - live in the project file and have no metadata expression. They are
per-column attributes in all but name, so `col_N_*` keys can carry them and a
later format version is expected to. Until then, an extended archive still needs
an EddyFlow project to state them.
