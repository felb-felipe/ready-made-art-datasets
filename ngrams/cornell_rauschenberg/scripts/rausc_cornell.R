
install.packages("ggh4x")

install.packages("ggplot2")
install.packages("dplyr")
install.packages("readxl")
install.packages("ggh4x")


library(readxl)
library(dplyr)
library(ggplot2)
library(ggh4x)


cornell_rausc <- read_excel("C:\\Users\\braga\\OneDrive\\Área de Trabalho\\Felipe\\Doutorado\\dados\\N-Gram Cornell e Rauschenberg (1945-1960)\\Ngram_Cornell_Rauschenberg.xlsx")


cornell_rausc %>%
  ggplot(aes(x = Ano, y = NGRAM, colour = Artista)) +
  geom_line(size = 1) +
  geom_point(size = 3, alpha = 0.5) +
  scale_x_continuous(breaks =  seq(1946,1960,2)) +
  scale_color_manual(values = c("#E3120B", "#076FA1")) +
  theme_light() +
  theme(legend.position = "bottom") +
  theme_light() +
  theme(legend.position = "bottom",
        panel.grid.major = element_blank(),
        panel.grid = element_blank(),
        axis.title.x = element_blank()
  ) +
  theme(
    # Set background color to white
    panel.background = element_rect(fill = "white"),
    # Remove all grid lines
    panel.grid = element_blank(),
    # But add grid lines for the vertical axis, customizing color and size 
    panel.grid.major.y = element_line(color = "#A8BAC4", size = 0.3),
    # Remove tick marks on the vertical axis by setting their length to 0
    axis.ticks.length.y = unit(0, "mm"), 
    # But keep tick marks on horizontal axis
    axis.ticks.length.x = unit(2, "mm"),
    # Remove the title for both axes
    axis.title.x = element_blank(),
    # Only the bottom line of the vertical axis is painted in black
    axis.line.x.bottom = element_line(color = "black"),
    # Remove labels from the vertical axis
    axis.text.y = element_blank(),
    # But customize labels for the horizontal axis
    axis.text.x = element_text(family = "Econ Sans Cnd", size = 16),
    axis.title.y = element_text(family = "Econ Sans Cnd", size = 16)
  )



ggplot(cornell_rausc, aes(x = Ano)) +
  geom_line(aes(y = NGRAM))

cornell <- cornell_rausc$NGRAM[cornell_rausc$Artista == "Cornell"]
raus <- cornell_rausc$NGRAM[cornell_rausc$Artista == "Rauschenberg"]
ano <- c(1945:1960)

cr_new <- data.frame(Ano = ano, Cornell = cornell, Raus = raus)


cr_new %>%
  ggplot(aes(x = Ano)) +
  geom_line(aes(y = Cornell), size = 0.5, colour = "black") +
  geom_line(aes(y = Raus), size = 0.5, colour = "black") +
  stat_difference(aes(ymin = Raus, ymax = Cornell), alpha = 0.3) +
  scale_fill_manual(
    values = c("#3D85F7", "#C32E5A","grey60"), labels = c("Cornell mais citado", "Rauschenberg mais citado", "same")) +
  scale_x_continuous(breaks = seq(1946,1960,2)) +
  scale_y_continuous(breaks = seq(0,20000,2000)) +
  theme_light() +
  theme(legend.position = "bottom",
        panel.grid.major = element_blank(),
        panel.grid = element_blank(),
        axis.title.x = element_blank()
        ) +
  annotate("point", x = 1957.76, y = 4130, size = 3, colour = "black") +
  ylab("Ngram")


