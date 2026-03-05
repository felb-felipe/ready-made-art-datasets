# Dataset: Google Books NGram frequencies – Impressionnisme, Cubisme and Surréalisme (1875–1925)

## Description

This dataset contains yearly frequency data for the following artistic movements:

- "Impressionnisme"
- "Cubisme"
- "Surréalisme"

The data were collected from the Google Books Ngram Viewer using the French corpus.

The temporal range spans from 1875 to 1925 (inclusive), with yearly observations.

The dataset was constructed to analyze the discursive emergence and diffusion of major modern art movements within French-language printed books.

## Source

Data were retrieved directly from:

Google Books Ngram Viewer  
https://books.google.com/ngrams

Corpus: French  
Case sensitivity: Case-insensitive  
Smoothing: 1

## Query parameters

- N-gram type: One-gram  
- Expressions queried:
  - "Impressionnisme"
  - "Cubisme"
  - "Surréalisme"
- Time interval: 1875–1925  
- Case handling: Uppercase and lowercase treated as equivalent  
- Smoothing parameter: 1  

A smoothing value of 1 means that each data point corresponds to a moving average including the selected year, one preceding year, and one following year. This reduces short-term fluctuations and highlights medium-term trends.

## Data structure

The dataset is structured in long (tidy) format.

Each row corresponds to a specific artistic movement in a specific year between 1875 and 1925.

Variables include:

- `year` – calendar year  
- `movement` – artistic movement ("Impressionnisme", "Cubisme", or "Surréalisme")  
- `zeros` – total number of leading zeros in the decimal representation of the frequency (including the zero before the decimal point)  
- `ngram` – significant digits of the frequency value  

Thus, each year appears three times in the dataset: once for each movement.

## Frequency encoding

For readability during manual data collection, frequency values were decomposed into two variables: `zeros` and `ngram`.

For example, if the frequency provided by Google Books was:

0.00000345

It was encoded as:

- zeros = 6  
- ngram = 345  

In this encoding:
- one zero corresponds to the integer part before the decimal point  
- the remaining zeros correspond to leading zeros after the decimal point  

To reconstruct the original numeric frequency:

1. Subtract 1 from `zeros` to obtain the number of zeros after the decimal point.
2. Insert the value of `ngram` after those zeros.

Thus:

zeros = 6 → 5 zeros after the decimal  
ngram = 345  

Reconstructed value:
0.00000345

Users may reconstruct the full numeric frequency prior to statistical analysis if required.

## Methodological note

The dataset captures printed book mentions in the Google Books French corpus and should not be interpreted as a direct measure of artistic production or institutional consolidation. Rather, it functions as a proxy for discursive visibility within French-language published literature.

The Google Books corpus composition varies over time and may introduce structural biases related to publication volume, digitization coverage, and language standardization.

The selected time window (1875–1925) allows for the observation of early diffusion phases of Impressionnisme and Cubisme, as well as the emergence of Surréalisme within its original linguistic context.

## File structure

- `data/art_movements_1875_1925.csv` – main dataset  
- `scripts/ngram_movements_analysis.R` – data processing and visualization  
- `visualizations/` – generated figures  

## Reproducibility

The raw frequency values were manually retrieved from the Google Books Ngram Viewer using the parameters described above.

Running the analysis script with the provided dataset reproduces the visualizations presented in the thesis.

## Funding

This dataset was produced within a doctoral research project funded by the São Paulo Research Foundation (FAPESP), Grant No. 2021/00645-8.

## Related research

This dataset supports the analysis presented in:

Braga, Felipe Eduardo Lázaro. (2026).  
*A biografia do ready-made, da natureza-morta a Rauschenberg*.  
Universidade de São Paulo (USP), Programa de Pós-Graduação em Sociologia.