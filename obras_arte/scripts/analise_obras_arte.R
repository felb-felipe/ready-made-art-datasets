install.packages("ggrepel")
install.packages("stringi")
install.packages("writexl")

library(readxl)
library(dplyr)
library(ggplot2)
library(ggrepel)
library(stringi)
library(writexl)


bd_obras <- read_excel("C:\\Users\\braga\\OneDrive\\Área de Trabalho\\Felipe\\Doutorado\\dados\\Banco de dados Ready-Mades\\Obras de Arte_Objeto Real (BD)_16102025.xlsx")

bd_obras[,3] <- as.numeric(bd_obras$Início)
bd_obras[,4] <- as.numeric(bd_obras$Término)


str(bd_obras)


bd_obras %>%
  filter(NomeArtista1 == "Man Ray") %>%
  group_by(NomeArtista1) %>%
  summarize(n())



#histogram orbas de arte
bd_obras %>%
  ggplot(aes(x = Início)) +
  geom_histogram(colour = "black", fill = "grey", binwidth = 5) +
  #geom_vline(xintercept = 1915) +
  #theme_minimal() +
  #theme(axis.title.x = element_blank(),
        #axis.title.y = element_blank()) +
  scale_x_continuous(breaks = seq(1910, 1960, 5)) +
  scale_y_continuous(breaks = seq(0,400,25))



#gráfico de barras - qdo de obras de arte por ano
bd_obras %>%
  ggplot(aes(x = Início)) +
  geom_bar(colour = "black") +
  theme_minimal() +
  theme(axis.title.x = element_text(face = "bold"),
        axis.text.x = element_text(angle = 90),
        axis.title.y = element_text(face = "bold")) +
  scale_x_continuous(breaks = seq(1912, 1960, 2)) +
  scale_y_continuous(breaks = seq(0,200,10)) +
  xlab("Ano") +
  ylab("Número de Obras de Arte")
  
ggsave("barras_n_obras.jpeg")  
  


#gráfico de barras - qdo de obras de arte por ano (com os labels dos dados em cima das barras)
bd_obras %>%
  group_by(Início) %>%
  summarize(Qtd = n()) %>%
  ggplot(aes(x = Início, y = Qtd, label = Qtd)) +
  geom_col(colour = "black") +
  geom_text(size = 2.5, vjust = -0.5) +
  theme_minimal() +
  theme(axis.title.x = element_text(face = "bold"),
        axis.text.x = element_text(angle = 90),
        axis.title.y = element_text(face = "bold"),
        axis.text.y = element_blank()) +
  scale_x_continuous(breaks = seq(1912, 1960, 3)) +
  scale_y_continuous(breaks = seq(0,200,10)) +
  xlab("Ano") +
  ylab("Número de Obras de Arte")



#boxplot com o número de obras de arte feitas por ano

bd_obras %>%
  group_by(Início) %>%
  summarize(Qtd = n()) %>%
  ggplot(aes(x = 1, y = Qtd)) +
  geom_boxplot()

#boxplot com o número de obras de arte feitas por ano (sem os outliers do box plot anterior: 1958, 1959, 1960)

bd_obras %>%
  group_by(Início) %>%
  filter(!Início %in% c(1958, 1959, 1960)) %>%
  summarize(Qtd = n()) %>%
  ggplot(aes(x = 1, y = Qtd)) +
  geom_boxplot() +
  scale_y_continuous(breaks = seq(0, 35, 2))

#boxplot com o número de obras de arte feitas por ano (sem a década de 1950/1960)

bd_obras %>%
  group_by(Início) %>%
  filter(Início < 1950) %>%
  summarize(Qtd = n()) %>%
  ggplot(aes(x = 1, y = Qtd)) +
  geom_boxplot() +
  scale_y_continuous(breaks = seq(0, 35, 2))



#boxplot com o número de obras de arte feitas por ano (sem a década de 1950/1960, e sem os três outliers: 1926, 1936, 1945)

bd_obras %>%
  group_by(Início) %>%
  filter(Início < 1950, Início %in% c(1926, 1936, 1945)) %>%
  summarize(Qtd = n()) %>%
  ggplot(aes(x = 1, y = Qtd)) +
  geom_boxplot() +
  scale_y_continuous(breaks = seq(0, 35, 2))


#sd do número de obras de arte produzidas por ano (todo o intervalo)

bd_obras %>%
  group_by(Início) %>%
  summarize(Qtd = n()) %>%
  summarize(sd(Qtd))

#sd do número de obras de arte produzidas por ano (por década)

bd_obras %>%
  group_by(Início) %>%
  summarize(Qtd = n()) %>%
  mutate(Decada = ifelse(Início < 1920, "10's", ifelse(Início < 1930, "20's", ifelse(Início < 1940, "30's", ifelse(Início < 1950, "40's", "50's"))))) %>%
  group_by(Decada) %>%
  summarize(sd(Qtd))


#sd do número de obras de arte produzidas por ano (sem a década de 1950, e sem os otliers; importante destacar que o anor de 1951 pertence à década de 1940)

bd_obras %>%
  group_by(Início) %>%
  filter(!Início %in% c(1926, 1936, 1945, 1950, 1958, 1959, 1960)) %>%
  summarize(Qtd = n()) %>%
  mutate(Decada = ifelse(Início < 1920, "10's", ifelse(Início < 1930, "20's", ifelse(Início < 1940, "30's", ifelse(Início < 1952, "40's", "50's"))))) %>%
  group_by(Decada) %>%
  summarize(Desvio_padrão = sd(Qtd))

#media do número de obras de arte produzidas por ano (sem a década de 1950, e sem os otliers)

bd_obras %>%
  group_by(Início) %>%
  filter(!Início %in% c(1926, 1936, 1945, 1950, 1958, 1959, 1960)) %>%
  summarize(Qtd = n()) %>%
  mutate(Decada = ifelse(Início < 1920, "10's", ifelse(Início < 1930, "20's", ifelse(Início < 1940, "30's", ifelse(Início < 1950, "40's", "50's"))))) %>%
  group_by(Decada) %>%
  summarize(mean(Qtd))


#mediana do número de obras de arte produzidas por ano (agrupados por década)

bd_obras %>%
  group_by(Início) %>%
  filter(!Início %in% c(1926, 1936, 1945, 1950, 1958, 1959, 1960)) %>%
  summarize(Qtd = n()) %>%
  mutate(Decada = ifelse(Início < 1920, "10's", ifelse(Início < 1930, "20's", ifelse(Início < 1940, "30's", ifelse(Início < 1952, "40's", "50's"))))) %>%
  group_by(Decada) %>%
  summarize(Mediana = median(Qtd))


bd_obras %>%
  group_by(Início) %>%
  filter(Início >= 1950) %>%
  summarize(Qtd = n())


#preciso contruir um bd em que a unidade seja o artista, e não a obra
#neste BD estão apenas as informações do artista 1
bd_artista_1 <- bd_obras %>%
  select(Obra, Início, Término, Fonte, ID_artista_1, NomeArtista1, PaísNascimentoArtista1, PaísMorteArtista1) %>%
  rename(ID_artista = ID_artista_1, NomeArtista = NomeArtista1, PaísNascimentoArtista = PaísNascimentoArtista1, PaísMorteArtista = PaísMorteArtista1)

#neste BD estão apenas as informações do artista 2
bd_artista_2 <- bd_obras %>%
  select(Obra, Início, Término, Fonte, ID_artista_2, NomedoArtista2, PaísNascimentoArtista2, PaísMorteArtista2) %>%
  filter(NomedoArtista2 != "NA") %>%
  rename(ID_artista = ID_artista_2, NomeArtista = NomedoArtista2, PaísNascimentoArtista = PaísNascimentoArtista2, PaísMorteArtista = PaísMorteArtista2)

#juntar os dois BD; neste Bd: bd_artista, a unidade é o artista, e não a obra; uma mesma obra aparece duas vezes, quando a obra foi produzidas por dois artistas diferentes; no total, o BD tem 804 obras de arte; 
bd_artista <- rbind(bd_artista_1, bd_artista_2)


str(bd_artista)


bd_artista %>%
  group_by(NomeArtista) %>%
  summarize(n()-n()) %>%
  print(n = 126)




artista_comeco <- bd_artista %>%
  group_by(NomeArtista, Início) %>%
  summarize(n()) %>%
  group_by(NomeArtista) %>%
  summarize(Inicio = min(Início)) %>%
  arrange(Inicio)


write_xlsx(artista_comeco,
           "C:\\Users\\braga\\OneDrive\\Área de Trabalho\\Felipe\\Doutorado\\dados\\Banco de dados Ready-Mades\\artista_comeco.xlsx")


#Número de artistas diferentes produzindo obras em cada ano
bd_artista %>%
  group_by(Início, NomeArtista) %>%
  summarize(n()) %>%
  group_by(Início) %>%
  summarize(Qtd = n()) %>%
  ggplot(aes(x = Início, y = Qtd, label = Qtd)) +
  geom_col(colour = "black") +
  geom_text(vjust = -0.5, size = 3) +
  scale_x_continuous(breaks = seq(1910, 1960, 5)) +
  theme_minimal() +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size = 10, vjust = -0.5, face = "bold")) +
  xlab("Ano")
  
#bd_número de artistas por ano + década
artistas_ano <- bd_artista %>%
  group_by(Início, NomeArtista) %>%
  summarize(n()) %>%
  group_by(Início) %>%
  summarize(Qtd = n()) %>%
  mutate(Década = ifelse(Início < 1920, "10's", ifelse(Início < 1930, "20's", ifelse(Início < 1940, "30's", ifelse(Início < 1950, "40's", "50's")))))


#sd, median e media do número de artistas do banco (só a fase de circulação lenta, sem 1960, 1959, 1958)
sd_median_mean_todos <- artistas_ano %>%
  filter(!Início %in% c(1960, 1959, 1958)) %>%
  summarize(Desvio_Padrão = sd(Qtd), Mediana = median(Qtd), Média = mean(Qtd))



#boxplot do número de artistas por ano

artistas_ano%>%
  filter(!Início %in% c(1960, 1959, 1958)) %>%
  ggplot(aes(x = "", y = Qtd)) +
  geom_boxplot() +
  geom_text(aes(label = Início)) +
  scale_y_continuous(breaks = seq(0, 45, 5))
  

#de acordo com o box_plot, os anos de 1960, 1959, 1958, 1956, 1936 são outliers


sd_median_mean_sem_outlier <- artistas_ano %>%
  filter(!Início %in% c(1960, 1959, 1958, 1956, 1936)) %>%
  summarize(Desvio_Padrão = sd(Qtd), Mediana = median(Qtd), Média = mean(Qtd))

sd_median_mean_artistas <- rbind(sd_median_mean_todos, sd_median_mean_sem_outlier)

cbind(Tipo = c("Com outliers", "Sem outliers"), sd_median_mean_artistas) 



#sd, median, mean por década, excluindo os anos outliers (década redonda)
sd_median_mean_decada_redonda <- artistas_ano %>%
  group_by(Década) %>%
  filter(!Início %in% c(1960, 1959, 1958, 1956, 1936)) %>%
  summarize(Desvio_Padrão = sd(Qtd), Mediana = median(Qtd), Média = mean(Qtd))


sd_median_mean_decada_redonda <- cbind(Tipo = rep("Década redonda",5), sd_median_mean_decada_redonda)

  
#bd_número de artistas por ano + década (década ajustada (1910 - 1919, 1920 - 1930, 1931 - 1939, 1940 - 1952, 1953 - 1957))
artistas_ano_ajustado <- bd_artista %>%
  group_by(Início, NomeArtista) %>%
  summarize(n()) %>%
  group_by(Início) %>%
  summarize(Qtd = n()) %>%
  mutate(Década = ifelse(Início < 1920, "10's", ifelse(Início < 1931, "20's", ifelse(Início < 1940, "30's", ifelse(Início < 1953, "40's", "50's")))))



#sd, median, mean por década, excluindo os anos outliers (década ajustada)
sd_median_mean_decada_ajustada <- artistas_ano_ajustado %>%
  group_by(Década) %>%
  filter(!Início %in% c(1960, 1959, 1958, 1956, 1936)) %>%
  summarize(Desvio_Padrão = sd(Qtd), Mediana = median(Qtd), Média = mean(Qtd))

sd_median_mean_decada_ajustada <- cbind(Tipo = rep("Década ajustada",5), sd_median_mean_decada_ajustada)


#tabela com os sd, median, mean para todas as décadas (redonda e ajustada)
rbind(sd_median_mean_decada_redonda, sd_median_mean_decada_ajustada)



#número de novos artistas por ano; gráfico descreve a quantidade de artistas que começaram a usar o objeto real em cada ano
bd_artista %>%
  group_by(NomeArtista, Início) %>%
  summarize(n()) %>%
  group_by(NomeArtista) %>%
  summarize(Início = min(Início)) %>%
  group_by(Início) %>%
  summarize(Qtd = n()) %>%
  ggplot(aes(x = Início, y = Qtd, label = Qtd)) +
  geom_col() +
  geom_text(vjust = -0.5) +
  scale_x_continuous(breaks = seq(1910, 1960, 5))
  

novos_artistas <- bd_artista %>%
  group_by(NomeArtista, Início) %>%
  summarize(n()) %>%
  group_by(NomeArtista) %>%
  summarize(Início = min(Início)) %>%
  group_by(Início, NomeArtista) %>%
  summarize(Qtd = n())
  

novos_artistas[,4] <- seq(1,126,1)

colnames(novos_artistas)[4] <- "Cumulativo"


#gráfico cumulativo de novos artistas que passam a usar o objeto real a cada ano; no final, em 1960, o gráfico chega em 126: é o número total de artistas do banco de dados
novos_artistas %>%
  group_by(Início) %>%
  summarize(Cumulativo = max(Cumulativo)) %>%
  ggplot(aes(x = Início, y = Cumulativo)) +
  geom_segment(aes(x = 1936, y = y_1936, xend = 1955, yend = y_1955), colour = "grey", size = 2) +
  geom_segment(aes(x = 1913, y = y_1913, xend = 1935, yend = y_1935), colour = "grey", size = 2) +
  geom_segment(aes(x = 1957, y = y_1957, xend = 1960, yend = y_1960), colour = "grey", size = 2) +
  geom_line(alpha = 0.7) +
  geom_point(alpha = 0.7) +
  #geom_text(aes(label = Cumulativo), vjust = -0.5, size = 3) +
  #geom_abline(intercept = -2761, slope = 1.4461) +
  scale_x_continuous(breaks = seq(1910, 1960, 5)) +
  scale_y_continuous(breaks = seq(0,126,5)) +
  xlab("Ano") +
  ylab("Cumulativo de artistas")
  


#calculo do segmento de reta para o intervalo de 1913 a 1935
intercept_1913_1935 <- -2.114 * 10^3
slope_1913_1935 <- 1.106

y_1913 = slope_1913_1935 * 1913 + intercept_1913_1935
y_1935 = slope_1913_1935 * 1935 + intercept_1913_1935



  
#calculo do segmento de reta para o intervalo de 1936 a 1955
intercept_1936_1957 <- -2761
slope_1936_1957 <- 1.4461
  
y_1936 = slope_1936_1957 * 1936 + intercept_1936_1957
y_1955 = slope_1936_1957 * 1955 + intercept_1936_1957
  
  
#calculo do segmento de reta para o intervalo de 1957 a 1960
intercept_1957_1960 <- -2.908*10^4
slope_1957_1960 <- 1.490*10

y_1957 = slope_1957_1960 * 1957 + intercept_1957_1960
y_1960 = slope_1957_1960 * 1960 + intercept_1957_1960


#regressão linear para a inclinação da curva de crescimento de novos artistas por ano entre 1913 e 1935

novos_artistas_1913_1935 <- novos_artistas %>%
  group_by(Início) %>%
  summarize(Cumulativo = max(Cumulativo)) %>%
  filter(Início <= 1935)

lm_1913_1935 <- lm(Cumulativo ~ Início, data = novos_artistas_1913_1935)
summary(lm_1913_1935)

#regressão linear para a inclinação da curva de crescimento de novos artistas por ano entre 1936 e 1955


novos_artistas_1936_1955 <- novos_artistas %>%
  group_by(Início) %>%
  summarize(Cumulativo = max(Cumulativo)) %>%
  filter(Início >= 1936, Início <= 1955)

lm_1936_1955 <- lm(Cumulativo ~ Início, data = novos_artistas_1936_1957)
summary(lm_1936_1955)

#regressão linear para a inclinação da curva de crescimento de novos artistas por ano entre 1958 e 1960


novos_artistas_1957_1960 <- novos_artistas %>%
  group_by(Início) %>%
  summarize(Cumulativo = max(Cumulativo)) %>%
  filter(Início >= 1957)

lm_1957_1960 <- lm(Cumulativo ~ Início, data = novos_artistas_1957_1960)
summary(lm_1957_1960)


1.490*10



#gráfico de pontos com o número de obras que os artistas mais produtivos (mais de 6 obras) produziram; no eixo x, o ano em que eles começaram a produzir; no eixo y, a quantidade total de obras que eles produziram no período de 1913 a 1960 (sem Cornell)
 bd_artista %>%
   mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
   mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
   group_by(Sobrenome, Início) %>%
   summarize(Qtd = n()) %>%
   group_by(Sobrenome) %>%
   summarize(Comeco = min(Início), Qtd = sum(Qtd)) %>%
   filter(Sobrenome != "Cornell", Qtd >= 6) %>%
   ggplot(aes(x = as.numeric(Comeco), y = Qtd, label = Sobrenome)) +
   geom_label_repel() +
   geom_point() +
   geom_vline(xintercept = c(1929, 1949), alpha = 0.35) +
   scale_x_continuous(breaks = seq(1910,1960,5)) +
   scale_y_continuous(breaks = seq(0,40,2)) +
   xlab("Ano do começo") +
   ylab("Número de obras")

 
 
 #gráfico de pontos com o número de obras que os artistas mais produtivos (mais de 20 obras) produziram; no eixo x, o ano em que eles começaram a produzir; no eixo y, a quantidade total de obras que eles produziram no período de 1913 a 1960 (sem Cornell)
 bd_artista %>%
   mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
   mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
   group_by(Sobrenome, Início) %>%
   summarize(Qtd = n()) %>%
   group_by(Sobrenome) %>%
   summarize(Comeco = min(Início), Qtd = sum(Qtd)) %>%
   filter(Sobrenome != "Cornell", Qtd >= 20) %>%
   ggplot(aes(x = as.numeric(Comeco), y = Qtd, label = Sobrenome)) +
   geom_label_repel() +
   geom_point() +
   geom_vline(xintercept = c(1929, 1949), alpha = 0.35) +
   scale_x_continuous(breaks = seq(1910,1960,5)) +
   scale_y_continuous(breaks = seq(0,40,2)) +
   xlab("Ano do começo") +
   ylab("Número de obras")
 
 
 
 #gráfico de pontos com o número de obras que os artistas mais produtivos (mais de 6 obras) produziram; no eixo x, o ano em que eles começaram a produzir; no eixo y, a quantidade total de obras que eles produziram no período de 1913 a 1960 (com Cornell)  
 bd_artista %>%
   mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
   mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
   group_by(Sobrenome, Início) %>%
   summarize(Qtd = n()) %>%
   group_by(Sobrenome) %>%
   summarize(Comeco = as.numeric(min(Início)), Qtd = sum(Qtd)) %>%
   filter(Qtd >= 20) %>%
   ggplot(aes(x = Comeco, y = Qtd, label = Sobrenome)) +
   geom_label_repel(max.overlaps = 30) +
   geom_point() +
   geom_vline(xintercept = c(1929, 1949), alpha = 0.35) +
   scale_x_continuous(breaks = seq(1910,1960,5)) +
   scale_y_continuous(breaks = seq(0,200,10)) +
   xlab("Ano do começo") +
   ylab("Número de obras")
 
 #extrair sobrenomes que fizeram mais de 20 obras de arte 
 artistas_20_mais <- bd_artista %>%
   mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
   mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
   group_by(Sobrenome) %>%
   summarize(Qtd = n()) %>%
   filter(Qtd >= 20) %>%
   pull(Sobrenome)
 
 #extrair sobrenomes que fizeram mais de 15 obras de arte 
 artistas_15_mais <- bd_artista %>%
   mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
   mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
   group_by(Sobrenome) %>%
   summarize(Qtd = n()) %>%
   filter(Qtd >= 15) %>%
   pull(Sobrenome)
 
 
 
 
  bd_artista %>%
   mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
   mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
   filter(Sobrenome %in% artistas_20_mais) %>%
   group_by(Sobrenome, Início) %>%
   summarize(Qtd = n()) %>%
    filter(Sobrenome == "Nevelson") %>%
    ggplot(aes(x = Início, y = Qtd)) +
    geom_col()
    #scale_x_continuous(breaks = seq(1910, 1960, 5))
    
  

  
  bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Sobrenome, Início) %>%
    summarize(Qtd = n()) %>%
    group_by(Sobrenome) %>%
    summarize(Comeco = min(Início), Qtd = sum(Qtd)) %>%
    filter(Comeco <= 1930) %>%
    arrange(Comeco)
  

  
  bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Início, Sobrenome) %>%
    summarize(Qtd = n()) %>%
    filter(Sobrenome %in% artistas_20_mais) %>%
    ggplot(aes(x = Início, y = Qtd)) +
    geom_point() +
    facet_wrap(vars(Sobrenome)) +
    scale_x_continuous(breaks = seq(1915, 1960, 15)) +
    theme(axis.text.x = element_text(size = 7)) +
    xlab("Ano") +
    ylab("Número de obras")
    
#ordem dos sobrenomes de acordo com o ano em que eles começaram a produzir obras
  sobrenomes_ordem <- bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Sobrenome, Início) %>%
    summarize(n()) %>%
    summarize(Min = min(Início)) %>%
    arrange(-Min) %>%
    pull(Sobrenome)
  

  
  #gráfico "tiles" (todos os artistas)
  bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Início, Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    #filter(Sobrenome %in% c("Duchamp", "Ray", "Baronesa", "Cornell", "Arman", "Breton", "Klein", "Nevelson", "Rauschenberg", "Tinguely", "Dalí", "Conner", "Calder")) %>%
    summarize(Qtd = n()) %>%
    ggplot(aes(x = as.numeric(Início), y = Sobrenome)) +
    geom_tile(aes(fill = Qtd)) +
    scale_fill_gradient(low = "lightgrey", high = "red") +
    theme_minimal() +
    theme(axis.text.y = element_blank(),
          axis.title.y = element_blank(),
          legend.position = "none", 
          #panel.grid.major = element_blank(),
          #panel.grid.minor = element_blank(),
          axis.title.x = element_text(face = "bold", vjust = -1)) +
    scale_x_continuous(breaks = seq(1912, 1960, 4)) +
    xlab("Ano")
  
  
  
  #vector com os artistas que começaram a produzir obras na década de 1910
  artista_1910 <- bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    summarize(Min = min(Início)) %>%
    filter(Min > 1910, Min <= 1919) %>%
    pull(Sobrenome)
  
  
    

  #gráfico "tiles" (artistas 1910)
  bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Início, Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    #filter(Sobrenome %in% c("Duchamp", "Ray", "Baronesa", "Cornell", "Arman", "Breton", "Klein", "Nevelson", "Rauschenberg", "Tinguely", "Dalí", "Conner", "Calder")) %>%
    summarize(Qtd = n()) %>%
    filter(Sobrenome %in% artista_1910) %>%
    ggplot(aes(x = Início, y = Sobrenome)) +
    geom_tile(aes(fill = Qtd)) +
    scale_fill_gradient(low = "lightgrey", high = "red") +
    theme_minimal() +
    theme(axis.title.y = element_blank(),
          legend.position = "none", 
          #panel.grid.major = element_blank(),
          #panel.grid.minor = element_blank(),
          axis.title.x = element_text(face = "bold", vjust = -1)) +
    scale_x_continuous(breaks = seq(1912, 1960, 4)) +
    xlab("Ano")
  
  
  
  
  
  #vector com os artistas que começaram a produzir obras na década de 1910 e 1920
  artista_1910_1920 <- bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    summarize(Min = min(Início)) %>%
    filter(Min > 1910, Min <= 1929) %>%
    pull(Sobrenome)
  
  
  
  
  #gráfico "tiles" (artistas 1910 e 1920 casadinhos)
  bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Início, Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    #filter(Sobrenome %in% c("Duchamp", "Ray", "Baronesa", "Cornell", "Arman", "Breton", "Klein", "Nevelson", "Rauschenberg", "Tinguely", "Dalí", "Conner", "Calder")) %>%
    summarize(Qtd = n()) %>%
    filter(Sobrenome %in% artista_1910_1920) %>%
    ggplot(aes(x = Início, y = Sobrenome)) +
    geom_tile(aes(fill = Qtd)) +
    scale_fill_gradientn(colours = c("lightgrey", "#FFA0A0", "red"), values = c(0, 0.001, 1)) +
    theme_minimal() +
    theme(axis.title.y = element_blank(),
          legend.position = "none", 
          #panel.grid.major = element_blank(),
          #panel.grid.minor = element_blank(),
          axis.title.x = element_text(face = "bold", vjust = -1)) +
    scale_x_continuous(breaks = seq(1912, 1960, 4)) +
    xlab("Ano")
  
  
  
  
  
  
  
  
  
  #vector com os artistas que começaram a produzir obras na década de 1920
  artista_1920 <- bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    summarize(Min = min(Início)) %>%
    filter(Min > 1919, Min <= 1929) %>%
    pull(Sobrenome)
  
  
  
  
  #gráfico "tiles" (artistas 1920)
  bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Início, Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    #filter(Sobrenome %in% c("Duchamp", "Ray", "Baronesa", "Cornell", "Arman", "Breton", "Klein", "Nevelson", "Rauschenberg", "Tinguely", "Dalí", "Conner", "Calder")) %>%
    summarize(Qtd = n()) %>%
    filter(Sobrenome %in% artista_1920) %>%
    ggplot(aes(x = Início, y = Sobrenome)) +
    geom_tile(aes(fill = Qtd)) +
    scale_fill_gradientn(colours = c("lightgrey", "#FFA0A0", "red"), values = c(0, 0.001, 1)) +
    theme_minimal() +
    theme(axis.title.y = element_blank(),
          legend.position = "none", 
          #panel.grid.major = element_blank(),
          #panel.grid.minor = element_blank(),
          axis.title.x = element_text(face = "bold", vjust = -1)) +
    scale_x_continuous(breaks = seq(1912, 1960, 4)) +
    xlab("Ano")

  
  
  
  #vector com os artistas que começaram a produzir obras na década de 1930
  artista_1930 <- bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    summarize(Min = min(Início)) %>%
    filter(Min > 1929, Min <= 1939) %>%
    pull(Sobrenome)
  
  
  
  
  #gráfico "tiles" (artistas 1930)
  bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Início, Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    #filter(Sobrenome %in% c("Duchamp", "Ray", "Baronesa", "Cornell", "Arman", "Breton", "Klein", "Nevelson", "Rauschenberg", "Tinguely", "Dalí", "Conner", "Calder")) %>%
    summarize(Qtd = n()) %>%
    filter(Sobrenome %in% artista_1930) %>%
    ggplot(aes(x = Início, y = Sobrenome)) +
    geom_tile(aes(fill = Qtd)) +
    scale_fill_gradientn(colours = c("lightgrey", "#FFA0A0", "red"), values = c(0, 0.001, 1)) +
    theme_minimal() +
    theme(axis.title.y = element_blank(),
          legend.position = "none", 
          #panel.grid.major = element_blank(),
          #panel.grid.minor = element_blank(),
          axis.title.x = element_text(face = "bold", vjust = -1)) +
    scale_x_continuous(breaks = seq(1912, 1960, 4)) +
    xlab("Ano")
  
  
  
  
  #vector com os artistas que começaram a produzir obras na década de 1940
  artista_1940 <- bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    summarize(Min = min(Início)) %>%
    filter(Min > 1939, Min <= 1949) %>%
    pull(Sobrenome)
  
  
  
  
  #gráfico "tiles" (artistas 1940)
  bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Início, Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    #filter(Sobrenome %in% c("Duchamp", "Ray", "Baronesa", "Cornell", "Arman", "Breton", "Klein", "Nevelson", "Rauschenberg", "Tinguely", "Dalí", "Conner", "Calder")) %>%
    summarize(Qtd = n()) %>%
    filter(Sobrenome %in% artista_1940) %>%
    ggplot(aes(x = Início, y = Sobrenome)) +
    geom_tile(aes(fill = Qtd)) +
    scale_fill_gradientn(colours = c("lightgrey", "#FFA0A0", "red"), values = c(0, 0.001, 1)) +
    theme_minimal() +
    theme(axis.title.y = element_blank(),
          legend.position = "none", 
          #panel.grid.major = element_blank(),
          #panel.grid.minor = element_blank(),
          axis.title.x = element_text(face = "bold", vjust = -1)) +
    scale_x_continuous(breaks = seq(1912, 1960, 4)) +
    xlab("Ano")
  
  
  
  #vector com os artistas que começaram a produzir obras na década de 1950-1957
  artista_1950_1957 <- bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    summarize(Min = min(Início)) %>%
    filter(Min > 1949, Min <= 1957) %>%
    pull(Sobrenome)
  
  
  
  
  #gráfico "tiles" (artistas 1950_1957)
  bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Início, Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    #filter(Sobrenome %in% c("Duchamp", "Ray", "Baronesa", "Cornell", "Arman", "Breton", "Klein", "Nevelson", "Rauschenberg", "Tinguely", "Dalí", "Conner", "Calder")) %>%
    summarize(Qtd = n()) %>%
    filter(Sobrenome %in% artista_1950_1957) %>%
    ggplot(aes(x = Início, y = Sobrenome)) +
    geom_tile(aes(fill = Qtd)) +
    scale_fill_gradientn(colours = c("lightgrey", "#FFA0A0", "red"), values = c(0, 0.001, 1)) +
    theme_minimal() +
    theme(axis.title.y = element_blank(),
          axis.text.y = element_text(size = 10),
          legend.position = "none", 
          #panel.grid.major = element_blank(),
          #panel.grid.minor = element_blank(),
          axis.title.x = element_text(face = "bold", vjust = -1)) +
    scale_x_continuous(breaks = seq(1912, 1960, 4)) +
    xlab("Ano")
  
  

  #vector com os artistas que começaram a produzir obras na década de 1958-1960
  artista_1958_1960 <- bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    summarize(Min = min(Início)) %>%
    filter(Min > 1957, Min <= 1960) %>%
    pull(Sobrenome)
  
  
  
  
  #gráfico "tiles" (artistas 1958-1960)
  bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Início, Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    #filter(Sobrenome %in% c("Duchamp", "Ray", "Baronesa", "Cornell", "Arman", "Breton", "Klein", "Nevelson", "Rauschenberg", "Tinguely", "Dalí", "Conner", "Calder")) %>%
    summarize(Qtd = n()) %>%
    filter(Sobrenome %in% artista_1958_1960) %>%
    ggplot(aes(x = Início, y = Sobrenome)) +
    geom_tile(aes(fill = Qtd)) +
    scale_fill_gradientn(colours = c("lightgrey", "#FFA0A0", "red"), values = c(0, 0.001, 1)) +
    theme_minimal() +
    theme(axis.title.y = element_blank(),
          axis.text.y = element_text(size = 10),
          legend.position = "none", 
          #panel.grid.major = element_blank(),
          #panel.grid.minor = element_blank(),
          axis.title.x = element_text(face = "bold", vjust = -1)) +
    scale_x_continuous(breaks = seq(1912, 1960, 4)) +
    xlab("Ano")
  
    
  
  
  #vector com os artistas engajados
  artista_engajados <- bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    summarize(Min = min(Início)) %>%
    filter(Sobrenome %in% c("Duchamp", "Ray", "Calder", "Dalí", "Stankiewicz", "Cornell", "Conner", "Arman", "Indiana", "Rauschenberg", "Nevelson", "Tinguely", "Klein")) %>%
    pull(Sobrenome)
  
  
  
  
  #gráfico "tiles" (artistas engajados)
  bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Início, Sobrenome) %>%
    mutate(Sobrenome = factor(Sobrenome, levels = sobrenomes_ordem, ordered = T)) %>%
    #filter(Sobrenome %in% c("Duchamp", "Ray", "Baronesa", "Cornell", "Arman", "Breton", "Klein", "Nevelson", "Rauschenberg", "Tinguely", "Dalí", "Conner", "Calder")) %>%
    summarize(Qtd = n()) %>%
    filter(Sobrenome %in% artista_engajados) %>%
    ggplot(aes(x = Início, y = Sobrenome)) +
    geom_tile(aes(fill = Qtd)) +
    geom_vline(xintercept = 1940) +
    geom_vline(xintercept = 1949) +
    scale_fill_gradientn(colours = c("lightgrey", "#FFA0A0", "red"), values = c(0, 0.001, 1)) +
    theme_minimal() +
    theme(axis.title.y = element_blank(),
          legend.position = "none", 
          #panel.grid.major = element_blank(),
          #panel.grid.minor = element_blank(),
          axis.title.x = element_text(face = "bold", vjust = -1)) +
    scale_x_continuous(breaks = seq(1912, 1960, 4)) +
    xlab("Ano")
  
 ggsave("tile_engajados_2.jpeg") 
  
  
  #grafico de barras descrevendo a quantidade de obras que cada artista do banco fez; é uma maneira de descrever o engajamento, a intensidade com que o artista inseriu o suporte real no próprio portfólio artístico  
  bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Sobrenome) %>%
    filter(Sobrenome != "Cornell") %>%
    summarize(Qtd = n()) %>%
    group_by(Qtd) %>%
    summarize(Qtd_2 = n()) %>%
    mutate(Propor = paste(round((Qtd_2/sum(Qtd_2)*100)),"%", sep = "")) %>%
    ggplot(aes(x = Qtd, y = Qtd_2, label = Propor)) +
    geom_col(color = "black", fill = "white") +
    geom_text(size = 2, vjust = -0.5) +
    scale_x_continuous(breaks = seq(1, 40, 2)) +
    scale_y_continuous(breaks = seq(0, 65, 5)) +
    xlab("Número de obras por artista") +
    ylab("Número de artistas") +
    theme_minimal() +
    theme(axis.title.x = element_text(size = 10),
          axis.title.y = element_text(size = 10))
    
  
  
  bd_artista %>%
    mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
    mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
    group_by(Sobrenome) %>%
    filter(Sobrenome != "Cornell") %>%
    summarize(Qtd = n()) %>%
    group_by(Qtd) %>%
    summarize(Qtd_2 = n()) %>%
    mutate(Propor = paste(round((Qtd_2/sum(Qtd_2)*100)),"%", sep = "")) %>%
    print(n=25)
  
  
  
  bd_artista %>%
  mutate(Sobrenome = stri_extract_last_words(NomeArtista)) %>%
  mutate(Sobrenome = ifelse(Sobrenome == "Loringhoven", "Baronesa", Sobrenome)) %>%
  group_by(Sobrenome) %>%
  filter(Sobrenome != "Cornell") %>%
  summarize(Qtd = n()) %>%
  ggplot(aes(x = Qtd)) +
  geom_density() +
  scale_x_continuous(breaks = seq(1,40, 2)) +
  scale_y_continuous(breaks = seq(0, 0.25, 0.02))
  
  
  
  
  
  
  str(bd_artista)
  
  
  n_obras <- bd_artista %>%
    group_by(Nome = NomeArtista) %>%
    summarize(N_obras = n(), Inicio = min(Início))
  
  write_xlsx(n_obras, 
             "C:\\Users\\braga\\OneDrive\\Área de Trabalho\\Felipe\\Doutorado\\dados\\Banco de dados Ready-Mades\\n_obras.xlsx")
  
  
  
  bd_artista %>%
    group_by(NomeArtista) %>%
    (NomeArtista, País_Morte_Artista)
  


  
    