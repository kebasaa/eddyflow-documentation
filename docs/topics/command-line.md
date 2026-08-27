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

[-j \| --jobs [N]] Number of worker threads to use for the planar-fit and time-lag-optimization pre-passes; if not provided assumes 1 (single-threaded)

[-h \| --help] Display this help and exit

[-v \| --version] Output version information and exit

PROJ_FILE Path of project (*.eddyflow) file; if not provided, assumes ..\\ini\\processing.eddyflow. Legacy *.eddypro project files are also accepted and will be automatically converted on import.
