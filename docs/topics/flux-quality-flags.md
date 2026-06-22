---
title: "Flux Quality Flags for Micrometeorological Tests"
source_url: "https://www.licor.com/support/EddyPro/topics/flux-quality-flags.html"
---
# Flux quality flags for micrometeorological tests

See [Quality check](selecting-advanced-options.md#Quality) for more information.

Quality flags are calculated for all fluxes (sensible and latent heat, momentum and gas fluxes). The final flags provided on output files are based on a combination of partial flags calculated as a result of two tests, widely adopted and thoroughly described in literature (see [Foken et al., 2004](references.md#Foken2); [Foken and Wichura, 1996](references.md#Foken); [Göckede et al., 2008](references.md#Gockede)).

The two tests are known as the *steady state test* and the *developed turbulent conditions* test. For details on the two methods refer to the cited literature. In EddyFlow, each test provides a flag ranging from 1 (best) to 9 (poorest). The two flags are then combined into a unique flag, depending on the selected flagging policy:

- Mauder and Foken 2004: policy described in the documentation of the TK2 Eddy Covariance software that also constituted the standard of the CarboEurope IP project and is widely adopted. Here, the combined flag attains the value "0" for best quality fluxes, "1" for fluxes suitable for general analysis such as annual budgets and "2" for fluxes that should be discarded from the results dataset.
- Foken 2003: A system based on 9 quality grades. "0" is best, "9" is worst. The system of [Mauder and Foken (2004)](references.md#Mauder) and of [Göckede et al. (2006)](references.md#Gockede2) are based on a rearrangement of this system.
- [Göckede et al., 2006](references.md#Gockede2): A system based on 5 quality grades. "0" is best, "5" is worst.
