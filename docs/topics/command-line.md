# Running EddyFlow from command prompt

<span id="top"></span>

The EddyFlow engine can be run from a command line interface. This section briefly describes the calls.

To run the EddyFlow engine, launch a command line interface, enter the directory of the binary, and then enter a command. The available commands are given below.

*******************

Executing EddyFlow

*******************

Help for EddyFlow-RP

--------------------

EddyFlow-RP, version 5.1.1, build 2014-06-06, 12:34.

USAGE: eddyflow_rp [OPTION [ARG]] [PROJ_FILE]

OPTIONS:

[-s \| --system [win \| linux \| mac]] Operating system; if not provided assumes "win"

[-m \| --mode [embedded \| desktop]] Running mode; if not provided assumes "desktop"

[-c \| --caller [gui \| console]] Caller; if not provided assumes "console"

[-e \| --environment [DIRECTORY]] Working directory, to be provided in embedded mode; if not provided assumes

[-j \| --jobs [N]] Worker processes for the planar-fit and time-lag pre-passes; 0 or absent uses every core, 1 is serial. See [Worker processes: -j and --jobs](#worker-processes-j-and-jobs)

[-h \| --help] Display this help and exit

[-v \| --version] Output version information and exit

PROJ_FILE Path of project (*.eddyflow) file; if not provided, assumes ..\\ini\\processing.eddyflow. Legacy *.eddypro project files are also accepted and will be automatically converted on import.


## Worker processes: -j and --jobs

**Syntax:** `-j N` or `--jobs N`, placed anywhere on the command line, including after the project path (for example `eddyflow_rp <project> -j 4`).

**Exact help text:** "Worker processes for the planar-fit and time-lag pre-passes; 0 or absent uses every core, 1 is serial".

**What it does.** Before it computes any flux, EddyFlow may walk every averaging period once to fit the planar fit planes (see [Planar fit](planar-fit.md#top)), and once more to optimise the time lags and measure the drift (see [Time lag detect & compensate](time-lag-detect-correct.md#top)). On a long dataset these walks dominate the run. Each period in them is independent of the others, so the range of periods is split into slices. The engine starts copies of itself (`eddyflow_rp`) as worker processes to compute the slices; the parent process computes the first slice itself, waits for the others, and merges the records in order.

**Values.**

- `-j 0`, or the switch left out: use every processor core.
- `-j 1`: run the serial path, with no worker processes.
- `-j N` with N greater than 1: use up to N processes in total, the parent included. The number is capped at 32, and a pre-pass is split only into slices of at least four periods each, so a short dataset may use fewer processes than requested or none. When a pre-pass is split the log says "Splitting the pre-pass across N worker processes."
- A value that is missing, negative or not a number is treated like 0 (every core) rather than reported as an error.
- `-j 1` also turns off the background unpacking of the next .ghg archive while the current one is processed, since 1 means that nothing is started alongside the main process. Results are unchanged either way.

**Which stages are split.**

- The planar fit pre-pass.
- The time lag optimization and drift pre-pass.
- The cache pre-pass of the pre-whitening block-bootstrap method (`tlag_meth=5` with `to_mode=1`, see [Pre-whitening block-bootstrap time lag](pwb-time-lag-settings.md#top)). The workers compute the per-period results; the parent then post-processes the settled table once.

The flux computation itself (the main pass) is not split. A project that runs no pre-pass is not affected by the switch.

**Results do not change.** The planar fit coefficients and the optimised time lags are byte-identical to those of a serial run. The switch only changes how long the run takes.

**Measured speed-up.** On two days of data from one site, with 8 workers, the planar fit pre-pass went from 108 s to 32 s and the time lag optimizer from 197 s to 57 s. The gain depends on the number of periods, the disk and the number of cores; short datasets gain little.

**The graphical interface.** The interface exposes the same switch as a checkbox, **Parallelise the planar fit and time lag pre-passes**, in the **Other options** group of **Advanced Settings > Processing Options**. It is a setting of the computer, not of the project: it is remembered between sessions, is not saved in the project file, and is off by default. The interface always passes `-j` explicitly, `-j 0` when the box is ticked and `-j 1` when it is not, so an unticked box means a serial run. When you run the engine yourself from a command line without `-j`, every core is used.

**Placement of the switch.** A switch placed after the project path (`eddyflow_rp <project> -e <home>`) used to be silently ignored. Switches are now honoured wherever they appear.

**Workers stop with the parent (8.1.2).** A worker checks, at the top of every period, that the process that started it is still running. If the parent has gone (the Stop button of the interface, Task Manager, or an error stop in the parent), the worker tidies up, writes nothing and exits with code 3, so that a leftover result code tells an orphaned worker from an ordinary failure. Before this, killing the parent left the workers running to the end of their slices. When you run from the interface, **Stop**, **Pause** and **Resume** reach every process of the run, the parent and all workers (see below), so nothing is left running after Stop.

**Work is handed to whichever worker is free (8.1.2).** The pre-pass range is cut into about four pieces per worker, with equal shares of estimated work (a period that has a raw file weighs 1, one without weighs 0.05). The parent runs the first piece and then hands out the next ones as workers finish, so a fast core takes more pieces than a slow one and nobody waits idle while work is left. The pieces are merged in order, results stay byte-identical to a serial run, and a failed piece stops the run at once. The parent reports "n of M pieces done" as pieces finish.

**Stop, Pause and Resume in the interface (8.1.2).** On Windows the engine runs inside a job object, so **Stop** ends the parent and every worker, **Pause** and **Resume** suspend and resume all of them, and closing or crashing the interface takes the whole run with it. On other systems the engine leads its own process group and the same three actions signal the group.

**Temporary folders (8.1.2).** Each worker removes its own temporary folder when it finishes.

!!! note

    The options `--batch`, `--batch-out`, `--batch-tmp` and `--batch-parent` are used internally by the engine to start and supervise its worker processes. They do not appear in the help and are not meant to be typed.

## Input links

Every input path of a project file may be a link to a folder or file shared on Google Drive or Dropbox with **Anyone with the link**: the raw data directory, metadata, dynamic metadata and biomet inputs, and the planar fit, time lag, spectral assessment and cospectra inputs. The output folder must be local. Downloads are made with `curl`, which has to be installed on the computer that runs the engine (`curl.exe` ships with Windows 10 and later). Nothing is needed on the command line: the link is simply the value of the key in the project file. See [Remote folders and shared links](remote-folders.md#top).
