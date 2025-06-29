# script_analise.R - Análise Estatística e Modelo Preditivo

# Pacotes necessários
install.packages(c("readxl", "ggplot2", "ggpubr", "PerformanceAnalytics", "dplyr"))
library(readxl)
library(ggplot2)
library(ggpubr)
library(PerformanceAnalytics)
library(dplyr)

# 1. Carregar os dados
dados <- read_excel("dataset_nasa.xlsx")

# 2. Visualizar estrutura
str(dados)

# 3. Selecionar colunas numéricas
dados_num <- dados[, sapply(dados, is.numeric)]

# 4. Função moda
moda <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# 5. Medidas descritivas
for (col in colnames(dados_num)) {
  cat("
Coluna:", col, "
")
  cat("Média:", mean(dados_num[[col]], na.rm = TRUE), "
")
  cat("Mediana:", median(dados_num[[col]], na.rm = TRUE), "
")
  cat("Moda:", moda(dados_num[[col]]), "
")
  cat("Desvio Padrão:", sd(dados_num[[col]], na.rm = TRUE), "
")
  cat("Mínimo:", min(dados_num[[col]], na.rm = TRUE), "
")
  cat("Máximo:", max(dados_num[[col]], na.rm = TRUE), "
")
  cat("Amplitude:", diff(range(dados_num[[col]], na.rm = TRUE)), "
")
}

# 6. Testes de normalidade
for (col in colnames(dados_num)) {
  cat("
Shapiro-Wilk para:", col, "
")
  print(shapiro.test(dados_num[[col]]))
}

# 7. Gráficos: histogramas e boxplots
for (col in colnames(dados_num)) {
  print(
    ggplot(dados, aes_string(x = col)) +
      geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", alpha = 0.6) +
      geom_density(color = "red", size = 1) +
      ggtitle(paste("Histograma + Densidade -", col))
  )
  
  print(
    ggplot(dados, aes_string(y = col)) +
      geom_boxplot(fill = "orange") +
      ggtitle(paste("Boxplot -", col))
  )
}

# 8. Matriz de correlação
chart.Correlation(dados_num, histogram = TRUE, pch = 19)

# 9. Selecionar variável mais correlacionada com NUMDEFECTS
correlacoes <- cor(dados_num, use = "complete.obs")
cor_NUMDEFECTS <- correlacoes["NUMDEFECTS", ]
cor_NUMDEFECTS <- cor_NUMDEFECTS[names(cor_NUMDEFECTS) != "NUMDEFECTS"]
variavel_mais_correlacionada <- names(which.max(abs(cor_NUMDEFECTS)))
cat("
Variável mais correlacionada com NUMDEFECTS:", variavel_mais_correlacionada, "
")

# 10. Regressão linear
formula_reg <- as.formula(paste("NUMDEFECTS ~", variavel_mais_correlacionada))
modelo <- lm(formula_reg, data = dados)
summary(modelo)

# 11. Diagnóstico dos resíduos
par(mfrow = c(2, 2))
plot(modelo)

# 12. Gráfico da regressão
ggplot(dados, aes_string(x = variavel_mais_correlacionada, y = "NUMDEFECTS")) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  ggtitle(paste("Regressão Linear: NUMDEFECTS ~", variavel_mais_correlacionada))

# 13. Salvar modelo para uso no Shiny e API
saveRDS(modelo, "modelo.rds")