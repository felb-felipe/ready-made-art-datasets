
library(readxl)
library(dplyr)
library(ggplot2)


picasso_ngram <- read_excel("C:\\Users\\braga\\OneDrive\\Área de Trabalho\\Felipe\\Doutorado\\dados\\N-gram Picasso\\N-Gram Pablo Picasso.xlsx")


str(picasso_ngram)

picasso_ngram %>%
  ggplot(aes(x = Ano, y = Ngram)) +
  geom_col() +
  scale_x_continuous(breaks = seq(1899, 1925, 2)) +
  scale_y_continuous(breaks = seq(0, 60000, 5000))
  
picasso_ngram %>%
  ggplot(aes(x = Ano, y = Crescimento)) +
  geom_line(color = "darkgrey") +
  scale_x_continuous(breaks = seq(1901, 1925, 2)) +
  theme_bw() +
  geom_hline(yintercept = 0, size = 0.5)

ggsave("picasso.jpg")


cubisme_ngram <- read_excel("C:\\Users\\braga\\OneDrive\\Área de Trabalho\\Felipe\\Doutorado\\dados\\N-gram Picasso\\N_Gram_Cubisme_Impressionisme.xlsx")

str(cubisme_ngram)


cubisme_ngram %>%
  ggplot(aes(x = Ano, y = Ngram, color = Expressão)) +
  geom_line(size = 0.7) +
  geom_hline(yintercept = 100000) +
  theme_bw() +
    theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 90)) +
  scale_x_continuous(breaks = seq(1870, 1925, 3))

ggsave("surrealisme.jpg")
  
cubisme_ngram %>%
  filter(Ano >= 1900, Expressão == "Cubisme") %>%
  ggplot(aes(x = Ano, y = Ngram, color = Expressão)) +
  geom_line(size = 1) +
  geom_hline(yintercept = 100000) +
  theme_bw() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 90)) +
  scale_x_continuous(breaks = seq(1870, 1925, 2))  


ggsave("cubisme.jpg")
