# plumber.R
#* @apiTitle Previsão de NUMDEFECTS via Regressão Linear

modelo <- readRDS("modelo.rds")

#* Realiza previsão com base na variável sumLoc_TOTAL
#* @param valor Valor de sumLoc_TOTAL
#* @get /prever
function(valor) {
  entrada <- data.frame(sumLoc_TOTAL = as.numeric(valor))
  predict(modelo, newdata = entrada)
}