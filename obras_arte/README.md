# Dataset: Found-object artworks (1913–1960)

## Description

This dataset maps artworks produced with found objects between 1913 and 1960, inspired by the readymade experiments of Marcel Duchamp.  
Each row corresponds to a single artwork.

The dataset contains **824 artworks** described using **18 variables**.

The unit of analysis is the individual artwork.

## Conceptual scope

The dataset includes artworks that incorporate ordinary, mass-produced, or everyday objects as primary material support.  
The selection follows a sociological definition of the readymade and found-object tradition within modern and contemporary art.

## Data collection methodology

Data collection was conducted in three stages:

### 1. Specialized bibliography

A survey of books and academic articles on modern and contemporary art was conducted to identify:

- artists associated with found-object practices  
- documented artworks produced between 1913 and 1960  

This stage generated an initial pool of artists and works.

### 2. Exhibition catalogues

To expand beyond the canon established in specialized literature, 24 catalogues of group exhibitions focused on found objects were collected.

This stage identified **268 unique artists**.  
For each artist, artworks were retrieved from:

- museum collection databases  
- auction aggregators  
- artists’ estates  
- catalogues raisonnés  

### 3. Institutional collection networks

A third stage used the institutional network study:

Fraiberger et al. (2018), *Quantifying reputation and success in art*, Science 362:825–829.

From this study, the **100 most connected art institutions** were selected.  
Their collection databases were searched for artworks produced with found objects between 1913 and 1960.

This strategy ensured coverage of the most structurally central collections in the global contemporary art system.

## Sources

Data were compiled from:

- specialized academic literature  
- exhibition catalogues  
- museum and institutional collection databases  
- auction database aggregators  
- artists’ estates and catalogues raisonnés  

## File structure

- `data/obras_arte.csv` – main dataset  
- `scripts/obras_arte.R` – data processing and visualization script  
- `visualizations/` – figures generated from the dataset


## Reproducibility

The script used to process this dataset and generate the visualizations is available in:

scripts/obras_arte.R


Running this script reproduces the figures presented in the thesis.

## Code note

The script provided in this repository corresponds to the code used during the research process.  
It is not fully modularized, but it reproduces the visualizations presented in the thesis when run with the dataset provided.

## Variables

| Variable name | Description | Type |
|---------------|-------------|------|
| Name of the Work | Title of the artwork | Text |
| Start of Construction of the Work | Estimated year in which the artist began creating the work | Numeric (year) |
| End of Construction of the Work | Estimated year in which the artist completed the work | Numeric (year) |
| Medium | Materials or objects used in the artwork | Text |
| Category | Artistic classification assigned by the holding institution (e.g., sculpture, readymade, object) | Categorical |
| Replica? | Indicates whether the work is a replica (YES) or an original (NO) | Binary (categorical) |
| Source | URL where the artwork information was collected | Text (URL) |
| Institution | Institution that holds the artwork | Text |
| Country of Institution | Country where the holding institution is located | Categorical |
| Number of artists | Number of artists involved in the creation of the work | Numeric (integer) |
| Artist ID 1 | Unique identifier for the first artist | Numeric / ID |
| Artist Name 1 | Name of the first artist | Text |
| Country of Birth Artist 1 | Country of birth of the first artist | Categorical |
| Country Death Artist 1 | Country of death of the first artist | Categorical |
| Artist ID 2 | Unique identifier for the second artist (if applicable) | Numeric / ID |
| Artist Name 2 | Name of the second artist (if applicable) | Text |
| Country of Birth Artist 2 | Country of birth of the second artist | Categorical |
| Country Death Artist 2 | Country of death of the second artist | Categorical |

## Related research

This dataset was created for the doctoral thesis:

Braga, Felipe Eduardo Lázaro. (2026).  
*A biografia do ready-made, da natureza-morta a Rauschenberg*.  
Universidade de São Paulo (USP), Programa de Pós-Graduação em Sociologia.


## Funding

This dataset was produced within a doctoral research project funded by the São Paulo Research Foundation (FAPESP), Grant No. 2021/00645-8.
