# Trabalho G2 - Análise Estatística e Modelo Preditivo com Shiny

## Componentes:
- `script_analise.R`: análise estatística + geração do modelo.
- `modelo.rds`: modelo treinado com lm(NUMDEFECTS ~ sumLoc_TOTAL).
- `app.R`: aplicação Shiny interativa com entrada e gráficos.
- `plumber.R`: API REST que retorna a previsão de NUMDEFECTS.
- `dataset_nasa.xlsx`: base de dados fornecida.
- `README.md`: instruções e informações do projeto.

## Acesso à aplicação
🔗 [Link do app publicado no shinyapps.io](https://leticianunes.shinyapps.io/minha_aplicacao/)

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