# Dataset: Artists–Exhibitions Affiliation Network (1950–1960)

## Description

This dataset maps the exhibition participation of artists who began producing artworks using found objects during the 1950s.

From the main artworks database (1913–1960), all artists who initiated object-based practices during the 1950s were identified. This resulted in a group of **72 artists**.

Between **1950 and 1960 (inclusive)**, these 72 artists participated in **196 exhibitions**, which constitute the second entity of this two-mode network.

The unit of analysis is the **artist–exhibition participation**.

This dataset allows the construction of a bipartite (two-mode) network linking artists and exhibitions, as well as its projection into a one-mode artist–artist co-participation network.

---

## Research context

This dataset is analytically connected to the main database of found-object artworks (1913–1960).

The artworks database revealed a significant acceleration in the circulation of object-based works around **1958**.

To investigate the mechanisms underlying this acceleration, the following hypothesis was formulated:

If wealthy collectors began acquiring object-based artworks more intensively around 1958, the institutional visibility of artists working with this support should have expanded during the same period.

This expansion would be observable through:

- an increase in exhibition participation,
- broader institutional diffusion (galleries, museums, biennials),
- denser co-participation patterns among artists.

This dataset was constructed to test that hypothesis.

---

## Data collection methodology

### 1. Artist selection

From the main artworks dataset, all artists who began producing object-based works during the 1950s were selected.

Total: **72 artists**.

### 2. Exhibition data collection

For each of these artists, all exhibitions in which they participated between **1950 and 1960 (inclusive)** were collected.

The source used was:

Artfacts (https://artfacts.net)

No filtering was applied based on prestige, scale, or institutional type. All recorded participations in the specified period were included.

The final dataset contains **196 unique exhibitions**.

Exhibition types include:

- private galleries  
- museums  
- biennials  
- salons (when recorded in the source database)

---

## Data structure

The dataset is organized into two relational tables:

### 1. Artist–Exhibition Relations (edge list)

Each row represents a participation tie between an artist and an exhibition.

Columns include:

- artist_id  
- exhibition_id  
- participation (coded as 1)

This table allows reconstruction of the bipartite network.

### 2. Exhibition Attributes

This table contains descriptive information for each exhibition:

- exhibition_id  
- exhibition_name  
- start_year  
- end_year  
- institution_name  
- city  
- country  

Artist attributes are available in the main artworks dataset.

---

## Sources and limitations

All data were collected from Artfacts.

Artfacts is a commercial database aggregating exhibition histories and institutional information. As such:

- Coverage may vary across countries and periods.
- Smaller or undocumented exhibitions may not be included.
- The database may privilege artists and institutions with higher visibility.

This dataset should therefore be interpreted as a structured approximation of institutional participation patterns rather than a fully exhaustive historical record.

---

## File structure

data/
artists_exhibitions_edges.csv  
exhibitions_attributes.csv  

scripts/
artists_exhibitions_network.R  

visualizations/

---

## Reproducibility

The script provided in this repository:

- reconstructs the bipartite affiliation network,
- projects the network when necessary,
- computes network-level metrics,
- and generates the visualizations presented in the thesis.

Running the script with the datasets provided reproduces the figures and measures discussed in the dissertation.

The script reflects the research process and is not fully modularized, but it ensures computational transparency and reproducibility.

---

## Funding

This research was supported by:

São Paulo Research Foundation (FAPESP)  
Grant no. 2021/00645-8

---

## Related research

This dataset was created for the doctoral thesis:

Braga, Felipe Eduardo Lázaro. (2026).  
*A biografia do ready-made, da natureza-morta a Rauschenberg*.  
Universidade de São Paulo (USP), Programa de Pós-Graduação em Sociologia.
