##Supongo que a esta función le llega el dataset convenientemente
##preprocesado, esto es, con valores discretizados o factorizados
##es decir, que ha sido tratado de igual manera que se trata
##previo uso a la función 'apriori' o 'eclat', por ejemplo.

##Solo contemplo dos tipos: data frame y transactions. No incluyo avisos ni excepciones
##en caso de que el tipo de "data" pasado no esté soportado.
support.and.confidence <- function(data, rule){

  library(stringr)
  rows <- dim(data)[1]
  
  numberOfAntItems <- str_count(labels(lhs(rule)),"=") 
  matches <- rep(TRUE,rows)
  matchesAntecedent <- rep(TRUE,rows)
  
  lhs.labels <- labels(lhs(rule))
  rhs.labels <- labels(rhs(rule))
  labels <- c(lhs.labels,rhs.labels)
  labels <- str_remove_all(labels,"[{}\"]")
  
  if(class(data)=="data.frame"){
    labels <- labels[which(labels!="")] ##eliminación de cadenas vacías
    labels <- str_split(labels,"[=,]")
    labels <- unlist(labels)
    ##tenemos las claves en posiciones impares, y los valores en posiciones pares
    keys   <- labels[seq(1,length(labels),by=2)] 
    values <- labels[seq(2,length(labels),by=2)] 
    
    for(i in 1:length(keys)){
      matches <- matches & data[[keys[i]]]==values[i]
      if(i == numberOfAntItems){
        matchesAntecedent <- matches
      }
    }
  }else if (class(data)=="transactions"){
    rules <- str_split(labels,"[,]")
    rules <- unlist(rules)
    for(i in 1:length(rules)){
      ##si la regla es un conjunto vacío, no computo nada pero se tiene  cuenta como analizada
      ##de cara al computo posterior
      if(rules[i] != ""){
        row <- which(colnames(data)==rules[i])
        matches <- matches & data@data[row,]
      }
      if(i == numberOfAntItems){
        matchesAntecedent <- matches
      }
    }
  }
  
  supp <- length(which(matches)) / rows
  conf <- length(which(matches)) / length(which(matchesAntecedent))
  return(list( support=supp, confidence=conf  ))
}
