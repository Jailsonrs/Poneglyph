source("src/R/libs.R")
source("src/R/MyGgthemes.R")
library(glue)
library(shiny)
library(tidyverse)
library(DT)
library(viridis)
library("scales")
library(dplyr)
options(shiny.maxRequestSize = 500*1024^2)


embeddings <- read.csv('../data/transformed/UMAP_embeddings.csv')

df_municipios <- data.table::fread("../data/raw/dados_municipais.csv")
df_clusterizado <- data.table::fread("../data/transformed/clustered_dataset")
embeddings <- data.frame(embeddings[,c(4,7)], df_clusterizado[,'model'])
df_cluster_unscalled <- data.frame(df_municipios, df_clusterizado[,'model'])
df_cluster_unscalled <- df_cluster_unscalled %>%
separate("Município", sep="\\(", into = c("Municip","estado")) %>% select(-c("Municipio"))
df_cluster_unscalled[,'estado'] <- str_remove(df_cluster_unscalled[,'estado'],pattern='\\)')


function(session, input, output){

	filteredData <- reactive({df_cluster_unscalled %>% 
		group_by(estado, model) %>% count() %>% arrange(model)
	})

	boxplotData <- reactive({
		df_cluster_unscalled
	})

	output$qtd_regiao <- renderPlotly({
		ggplot(filteredData(), aes(x =n,y = estado, fill= factor(model)))+
		geom_col()+
		labs(x = "n", y = 'UF', fill="Cluster")+
		tema2 -> gp
		gp <- ggplotly(gp)
		gp
	})


	output$dt_clusterizado <- DT::renderDataTable({
		DT::datatable(
			df_cluster_unscalled,
			filter="top",
			extensions = c('Buttons'), 
			width="1500px",
			options = list( dom = 'Bfrtip',
				buttons = c('copy', 'csv', 'excel'),
				pageLength=10,              
				columnDefs = list(list(width = '400px', targets = c(2,3))),
				scrollY = 200,
				scrollX = 1000
			)
		)
	})
}

