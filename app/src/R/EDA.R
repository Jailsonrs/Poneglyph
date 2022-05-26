##-----------------------------------------------------------------------------##
#fazer join com a chave populacao$estado
rm(list=ls())
gc(reset=TRUE)
library(data.table)
library(ggplot2)
library(dplyr)
library(magrittr)
library(tidyr)
library(viridis)
library(lubridate)
library(purrr)
library (readxl)
source("../SRC/MyGgthemes.R")
library(highcharter)
options(warning = FALSE, warnings = -1, warn =-1)
##setwd("~/Área de Trabalho/COVID/SHINY")
prepro <- readRDS("data/preprocessed/RDS/Prepro.RDS")
#skip
dadosBr <- data.table::fread(file.path("data","raw","HIST_PAINEL_COVIDBR_23mai2020csv.csv"),drop=1:3)
getwd()
prepro %>% filter(is.na(codmun)) %>% 
mutate(incidencia100k = (casosAcumulado/populacaoTCU2019)*100000,
       morte100k = (obitosAcumulado/populacaoTCU2019)*100000) %>%
 filter(data == max(data)) %>%
 group_by(estado, morte100k) %>% 
 select(estado, municipio,data, incidencia100k,morte100k) %>% 
 arrange(desc(incidencia100k))

write.csv(dadosBr,file.path("data","raw","HIST_PAINEL_COVIDBR_23mai2020csv.csv"))

dadosBr <- dadosBr[!is.na(dadosBr$populacaoTCU2019),]
dadosBr$populacaoTCU2019 <- as.double(dadosBr$populacaoTCU2019)
dadosMun <- readxl::read_excel("DATA/RAW/AUXILIARY/A221833189_28_143_208.xlsx")
dadosMun$CodUF<-substr(dadosMun$Município,1,2)
dadosBr %<>% mutate(chave = paste(coduf, populacaoTCU2019))
dadosMun %<>% mutate(chave = paste(CodUF, População_estimada))
dadosBr <- left_join(dadosBr, dadosMun, 
                     by=c("chave" = "chave")) 

##-----------------------------------------------------------------------------##
##-----------------------------------------------------------------------------##
dadosBr <- dadosBr[c("regiao","Município", "estado", "municipio", "coduf", "codmun", "codRegiaoSaude", 
                     "nomeRegiaoSaude", "data", "semanaEpi", "populacaoTCU2019", "casosAcumulado", 
                     "obitosAcumulado", "Recuperadosnovos", "emAcompanhamentoNovos")]

##as_tibble(dadosBr) %>% nest(-estado) -> teste
#obter os dados temporais para o maximo de cada data

##-----------------------------------------------------------------------------##
#Prerpocessamento
Saltos <- function(x){
  i=1; saltos = numeric(length(x))
  while(x[i]-x[i+1] >= 0  && i < length(x)){
    x[i]-x[i+1] -> saltos[i]
    i = i+1 
  }
  return(saltos)
}

Prepro <- function(dataset){
  dataset$semanaEpi <- as.numeric(dataset$semanaEpi)
  dataset$populacaoTCU2019 <-as.numeric(dataset$populacaoTCU2019)
  dataset$casosAcumulado <-as.numeric(dataset$casosAcumulado)
  dataset$obitosAcumulado <-as.numeric(dataset$obitosAcumulado)
  dataset %<>% mutate(taxaObito = obitosAcumulado/casosAcumulado)
  return(dataset)
}
##-----------------------------------------------------------------------------##
##-----------------------------------------------------------------------------##
Prepro(dadosBr) -> prepro

prepro %>% filter(regiao == "Brasil") %>% ggplot(aes(as.Date(data),casosAcumulado,group=1))+
geom_line(colour="steelblue")+tema2+scale_y_continuous(breaks=seq(0,300000,20000))+
scale_x_date(date_labels = "%d %b %Y",date_breaks = "5 day")+
theme(axis.text.x = element_text(angle=45))


prepro %>% filter(is.na(Município),regiao != "Brasil") %>% group_by(estado,data,casosAcumulado) %>% summarise(maximo = max(casosAcumulado))  %>%

arrange(desc(maximo))

prepro %>% filter(is.na(Município),regiao != "Brasil") %>% 
ggplot(aes(data, casosAcumulado,colour=estado,group=estado))+
geom_line(size=0.5)+tema2+geom_point(size=0.5)
# prepro %>% filter(regiao=="Nordeste",estado=="CE", !is.na(Município)) %>% 
#   ggplot(aes(.$data, taxaObito,colour=Município,group=Município))+
#   geom_line()+
#   scale_y_continuous(limits = c(0,0.09), breaks = seq(0,1,0.009))+
#   tema2+labs(title="Taxa de Mortalidade COVID19 ao longo do 
#              \ntempo para todo o Brasil")+theme(legend.position = "none")


 prepro %>% filter(regiao != "Brasil")  %>%
            mutate(mort100k = (obitosAcumulado/populacaoTCU2019)*100000) %>% 
            filter(data == max(data)) %>%
            group_by(estado,data,mort100k) %>% summarise(count=n()) %>%
                        arrange(desc(mort100k)) 

















prepro$estado

colnames(preproz
pre <- prepro %>% filter(regiao !="Brasil", estado == "CE")
# normal highchart
highchart() %>%
  hc_add_series(1:901)


opts <- getOption("highcharter.options")
opts$lang$decimalPoint <- "."
opts$lang$months = c("Janeiro", "Fevereiro", "Março",
  "Abril", "Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro")


     #hc_chart(zoomType = "x", animation = FALSE, type = "line") %>% 
highchart2() %>%
          hc_xAxis(type = "datetime", dateTimeLabelFormats = list(day = '%d of %b')) %>%
          hc_add_series(data = pre, 
                        mapping = hcaes(x = (data), y = log(casosAcumulado,10)),type="line")

options(highcharter.options = opts)

# now with "," instead of "." (confirm in tooltip)
highchart() %>%
  hc_add_serie_labels_values(1:901, seq(1, 10, 0.01))





##-----------------------------------------------------------------------------##
##-----------------------------------------------------------------------------##