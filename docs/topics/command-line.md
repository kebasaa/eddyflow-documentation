---
title: "Run EddyFlow from Command Line"
source_url: "https://www.licor.com/support/EddyPro/topics/command-line.html"
---
# Running EddyFlow from command prompt

The EddyFlow engine can be run from a command line interface. This section briefly describes the calls.

To run the EddyFlow engine, launch a command line interface, enter the directory of the binary, and then enter a command. The available commands are given below.

*******************

Executing EddyFlow

*******************

Help for EddyFlow-RP

--------------------

EddyFlow-RP, version 5.1.1, build 2014-06-06, 12:34.

USAGE: eddypro_rp [OPTION [ARG]] [PROJ_FILE]

OPTIONS:

[-s \| --system [win \| linux \| mac]] Operating system; if not provided assumes "win"

[-m \| --mode [embedded \| desktop]] Running mode; if not provided assumes "desktop"

[-c \| --caller [gui \| console]] Caller; if not provided assumes "console"

[-e \| --environment [DIRECTORY]] Working directory, to be provided in embedded mode; if not provided assumes

[-h \| --help] Display this help and exit

[-v \| --version] Output version information and exit

PROJ_FILE Path of project (*.eddypro) file; if not provided, assumes ..\\ini\\processing.eddypro
