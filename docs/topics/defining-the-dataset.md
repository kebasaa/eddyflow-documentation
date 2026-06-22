---
title: "Defining the EddyFlow Express Data Set"
source_url: "https://www.licor.com/support/EddyPro/topics/defining-the-dataset.html"
---
# Defining the EddyFlow dataset

The averaging dataset is comprised of all numeric data columns that were found in the raw file(s), including sensitive and non-sensitive variables. From this dataset, the *EddyFlow dataset* (or *EP dataset*) is derived through the following operations:

If at least one column of the raw file is defined as a flag, EddyFlow scans that column and filters individual data records according to the [flag policy and value of the flag threshold](flags.md). Recall that EddyFlow supports up to two flag columns.

Variables of the averaging dataset are split into [sensitive and non-sensitive variables](sensitive-and-nonsensitive-variables.md). Sensitive variables are stored in the EP dataset, while non-sensitive variables are stored in what we call the *user dataset*. Starting from here, the two datasets undergo a different path of processing. In particular, the EPE dataset is used for the flux computation.
