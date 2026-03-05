# Dataset: Google Books NGram frequencies – Rauschenberg & Cornell (1945–1960)

## Description

This dataset contains yearly frequency data for the two-grams:

- "Robert Rauschenberg"  
- "Joseph Cornell"  

The data were collected from the Google Books Ngram Viewer using the English corpus.

The temporal range spans from 1945 to 1960 (inclusive), with yearly observations.

The dataset was constructed to analyze the discursive emergence and relative visibility of both artists in printed English-language books during the early postwar period.

## Source

Data were retrieved directly from:

Google Books Ngram Viewer  
https://books.google.com/ngrams

Corpus: English  
Case sensitivity: Case-insensitive  
Smoothing: 0 (no smoothing applied)

## Query parameters

- N-gram type: Two-gram  
- Expressions queried:
  - "Robert Rauschenberg"
  - "Joseph Cornell"
- Time interval: 1945–1960  
- Case handling: Uppercase and lowercase treated as equivalent  
- Smoothing parameter: 0  

The smoothing value of 0 ensures that the reported frequency corresponds to the observed value in each specific year, without averaging across adjacent years.

## Data structure

The dataset is structured in long (tidy) format.

Each row corresponds to a specific artist in a specific year between 1945 and 1960.

Variables include:

- `year` – calendar year  
- `artist` – artist name ("Robert Rauschenberg" or "Joseph Cornell")  
- `frequency` – relative frequency of the two-gram in the English corpus for that year  

Thus, each year appears twice in the dataset: once for each artist.

Frequencies correspond to the relative share of the two-gram among all two-grams in the corpus for that year, as defined by Google Books.

## Methodological note

The dataset captures printed book mentions in the Google Books English corpus and should not be interpreted as a direct measure of artistic production or institutional recognition. Rather, it functions as a proxy for discursive visibility within published literature.

The Google Books corpus composition varies over time and may introduce structural biases related to publication volume and digitization coverage.

## File structure

- `data/rausch_cornell_1945_1960.csv` – main dataset  
- `scripts/ngram_rausch_cornell_analysis.R` – data processing and visualization  
- `visualizations/` – generated figures  

## Reproducibility

The raw frequency values were manually retrieved from the Google Books Ngram Viewer using the parameters described above and stored in CSV format.

Running the analysis script with the provided dataset reproduces the visualizations presented in the thesis.

## Related research

This dataset supports the analysis presented in:

Braga, Felipe Eduardo Lázaro. (2026).  
*A biografia do ready-made, da natureza-morta a Rauschenberg*.  
Universidade de São Paulo (USP), Programa de Pós-Graduação em Sociologia.

## Funding

This dataset was produced within a doctoral research project funded by the São Paulo Research Foundation (FAPESP), Grant No. 2021/00645-8.