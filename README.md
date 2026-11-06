[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![DOI](https://zenodo.org/badge/1276839437.svg)](https://doi.org/10.5281/zenodo.24011244)

![EddyFlow](img/app-logo.svg)

# EddyFlow Documentation

EddyFlow® is an open source software application for processing eddy covariance data. It computes fluxes of water vapor, carbon dioxide, other trace gases, and energy with the eddy covariance method.

This repository contains the source for the EddyFlow documentation site published with GitHub Pages.

## EddyFlow repositories

EddyFlow consists of 4 repositories:

- [eddyflow-engine](https://github.com/kebasaa/eddyflow-engine): The engine behind it all
- [eddyflow-gui](https://github.com/kebasaa/eddyflow-gui): The Qt6 GUI
- [eddyflow-documentation](https://github.com/kebasaa/eddyflow-documentation) (current repository): The documentation of the software and its usage
- [eddyflow-build-script](https://github.com/kebasaa/eddyflow-build-script): This builds the software binaries (currently Windows only)


## Documentation

- Published documentation: [https://kebasaa.github.io/eddyflow-documentation/](https://kebasaa.github.io/eddyflow-documentation/)
- Local documentation source: [docs/index.md](docs/index.md)

## Repository Structure

- `docs/`: MkDocs documentation source.
- `docs/assets/`: images, logo copies, and stylesheet used by the site.
- `mkdocs.yml`: site configuration and navigation.
- `.github/workflows/`: GitHub Pages deployment workflow.
- `img/`: source EddyFlow branding assets used by this repository.

## Local Preview

Install the documentation dependencies:

```bash
python -m pip install -r requirements-docs.txt
```

Start a local preview server:

```bash
mkdocs serve
```

Build the site strictly:

```bash
mkdocs build --strict
```

## How to Cite

Muller, J.D. (2026). *eddyflow-documentation: Documentation for the EddyFlow software*. DOI: https://doi.org/10.5281/zenodo.24011244

## License

This software is distributed under the [GNU General Public License (GPL) v3.0](LICENSE). Any modification of the code in this repository may only be released under the same license, and with attribution of authorship of the original code (i.e., citation above).
