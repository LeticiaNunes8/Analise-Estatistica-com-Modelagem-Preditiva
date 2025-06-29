# Análise Estatística e Modelo Preditivo com Aplicação Web em Shiny

#### Este projeto foi desenvolvido como parte da avaliação da disciplina Tópicos Especiais II, ministrada pelo professor Thiago Silva Souza, no curso de Sistemas de Informação da Universidade La Salle do Rio de Janeiro.

## Componentes:
- `script_analise.R`: análise estatística + geração do modelo.
- `modelo.rds`: modelo treinado com lm(NUMDEFECTS ~ sumLoc_TOTAL).
- `app.R`: aplicação Shiny interativa com entrada e gráficos.
- `plumber.R`: API REST que retorna a previsão de NUMDEFECTS.
- `dataset_nasa.xlsx`: base de dados fornecida.
- `README.md`: instruções e informações do projeto.

## Acesso à aplicação
🔗 [Link do app publicado no shinyapps.io](https://leticianunes.shinyapps.io/projeto_g2/)

## Como rodar localmente

```r
runApp("app.R")
```

## Como testar a API local
```r
library(plumber)
r <- plumb("plumber.R")
r$run(port = 8000)
```
Acesse: http://127.0.0.1:8000/prever?valor=100
