
install.packages("ggraph")
install.packages("igraph")
install.packages("extrafont")
install.packages("tidygraph")



library("extrafont")
library("ggraph")
library("dplyr")
library("igraph")
library("readxl")
library("tidygraph")


extrafont::font_import(prompt = F)
extrafont::loadfonts(device = "win")


#matrizes

#matriz de incidência

df_full <- read_excel("C:\\Users\\braga\\OneDrive\\Área de Trabalho\\Felipe\\Doutorado\\dados\\Artistas_Explosão\\R Studio_viz\\Grafos crono\\Matriz_incidencia.xlsx")

df_full[is.na(df_full)] <- 0

m_full <- df_full %>%
  select(-Nomes) %>% #tirar a primeira coluna com os nomes dos artistas
  mutate(across(everything(), as.numeric)) %>% #transforma tudo em numérico
  as.matrix() #transforma em matriz

dim(m_full)

str(m_full)


#atributos_artistas

atri_artistas <- read_excel("C:\\Users\\braga\\OneDrive\\Área de Trabalho\\Felipe\\Doutorado\\dados\\Artistas_Explosão\\R Studio_viz\\Grafos crono\\Atributos_artistas.xlsx")

str(atri_artistas)

#atributos_mostras

atri_mostras <- read_excel("C:\\Users\\braga\\OneDrive\\Área de Trabalho\\Felipe\\Doutorado\\dados\\Artistas_Explosão\\R Studio_viz\\Grafos crono\\Atributos_mostras.xlsx")

atri_mostras <- atri_mostras %>%
  mutate(ID = as.character(ID))

str(atri_mostras)



#passar a matriz de incidência completa para o objeto igraph

m_full <- graph_from_biadjacency_matrix(m_full)


#vetor com os nomes dos artistas

nomes_artistas <- df_full$Nomes

#vetor com os nomes das mostras

nomes_mostras <- colnames(df_full[-1])


#nomear nós com os vetores nome_artistas e nome_mostras

V(m_full)$name <- c(nomes_artistas, nomes_mostras)


V(m_full)$name


#passar o objeto igraph para um objeto tidugraph

g_full <- as_tbl_graph(m_full)


#passar as informações dos atributos dos artistas para a matriz de incidência

g_full <- g_full %>%
  activate(nodes) %>%
  left_join(atri_artistas, by = c("name" = "Sobrenome"))


#passar as informações dos atributos das mostras para a matriz de incidência

g_full <- g_full %>%
  activate(nodes) %>%
  left_join(atri_mostras, by = c("name" = "ID"))


#filtrar apenas as mostras de 1950

g_full %>%
  activate(nodes) %>%
  filter(Ano == 1951 | N_de_obras >= 1) %>%
  mutate(grau = centrality_degree(), N_de_obras_dois = ifelse(type == F, (N_de_obras*10), 10), Nome_mostra = ifelse(type, paste("Mostra", name), NA)) %>%
  filter(grau > 0) %>%
  ggraph(layout = "fr") +
  geom_edge_link(alpha = 0.5, arrow = arrow(type = "closed", length = unit(3, "mm")), end_cap = circle(6, "mm")) +
  geom_node_point(aes(shape = type, fill = type, size = ifelse(type == F, N_de_obras, 8)), stroke = 1) +
  geom_node_text(aes(label = ifelse(type, name, " ")), size = 5, repel = F, colour = "white", family = "Roboto", vjust = 0.5, fontface = "bold") +
  geom_node_text(aes(label = ifelse(type, " ", name)), size = 5, repel = T, colour = "black", family = "Roboto", vjust = 2, fontface = "bold", segment.colour = NA) +
  scale_shape_manual(values = c(21, 22), labels = c("Artistas", "Mostras")) +
  scale_fill_manual(values = c("#E74C3C", "#154360"), labels = c("Artistas", "Mostras")) +
  scale_size_continuous(range = c(8, 24), guide = "none") +
  annotate("text", x = -Inf, y = Inf, label = "1951", size = 14, colour = "grey35", fontface = "bold", hjust = -0.3, vjust = 1.7) +
  theme_void() +
  theme(legend.position = c(1,0),
        legend.justification = c(1,0),
        legend.title = element_blank(),
        legend.text = element_text(size = 16)) +
  guides(shape = guide_legend(override.aes = list(size = 6)))



ggsave(
  "minha_rede_1951.png",
  width = 12,       # em polegadas
  height = 10,
  dpi = 300,
  bg = "white"
)

str(atri_artistas)


str(atri_artistas)

#fake network


ggraph(network_fake, layout = 'kk') +
  geom_edge_link() +
  geom_node_point(aes(shape = type, fill = type, size = ifelse(type, 3.5, obras)), colour = "black", stroke = 0.8) +
  geom_node_text(aes(label = ifelse(type," ", name)), size = 2.5, repel = T, colour = "grey30", family = "Roboto") +
  scale_shape_manual(values = c(21, 22), labels = c("Artistas", "Mostras")) +
  scale_fill_manual(values = c("steelblue", "coral"), labels = c("Artistas", "Mostras")) +
  scale_size_continuous(guide = "none") +
  theme_void() +
  theme(legend.position = "bottom")


cols <- paste("Mostra", seq(1:10))
rows <- paste("Artista", seq(1:100))

data <- rbinom(1000, 1, 0.1)      
network_fake <- matrix(data, nrow = 100, ncol = 10)


rownames(network_fake) <- rows
colnames(network_fake) <- cols


data_atrib <- sample(c(1:20), 100, replace = T)
atributos <- data.frame(Nome = rows, Obras = data_atrib)


is.matrix(network_fake)

network_fake <- graph_from_biadjacency_matrix(network_fake)

network_fake


table(V(network_fake)$type)


obras <- setNames(atributos$Obras, atributos$Nome)


class(network_fake)
is.null(network_fake)


V(network_fake)

V(network_fake)$name

V(network_fake)$type


sum(!V(network_fake)$type)

V(network_fake)$obras <- NA

artists <- V(network_fake)$name[!V(network_fake)$type]

obras[artists]

V(network_fake)$obras[!V(network_fake)$type] <- obras[V(network_fake)$name[!V(network_fake)$type]]



V(network_fake)[!V(network_fake)$type] <- obras[V(network_fake)$name[!V(network_fake$type)]]




network_fake <- delete_vertices(network_fake, degree(network_fake) == 0)

ggraph(network_fake, layout = 'kk') +
  geom_edge_link() +
  geom_node_point(aes(shape = type, fill = type, size = ifelse(type, 3.5, obras)), colour = "black", stroke = 0.8) +
  geom_node_text(aes(label = ifelse(type," ", name)), size = 2.5, repel = T, colour = "grey30", family = "Roboto") +
  scale_shape_manual(values = c(21, 22), labels = c("Artistas", "Mostras")) +
  scale_fill_manual(values = c("steelblue", "coral"), labels = c("Artistas", "Mostras")) +
  scale_size_continuous(guide = "none") +
  theme_void() +
  theme(legend.position = "bottom")


m_full <- delete_vertices(m_full, degree(m_full) == 0)

ggraph(m_full, layout = 'fr') +
  geom_edge_link() +
  geom_node_point(aes(shape = type, fill = type), colour = "black", stroke = 0.8, size = 3) +
  #geom_node_text(aes(label = ifelse(type," ", name)), size = 2.5, repel = T, colour = "grey30", family = "Roboto") +
  scale_shape_manual(values = c(21, 22), labels = c("Artistas", "Mostras")) +
  scale_fill_manual(values = c("steelblue", "coral"), labels = c("Artistas", "Mostras")) +
  scale_size_continuous(guide = "none") +
  theme_void() +
  theme(legend.position = "bottom")







names(grDevices::windowsFonts())



