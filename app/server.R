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
library(viridis)

embeddings <- read.csv('./data/transformed/UMAP_embeddings.csv')
df_municipios <- data.table::fread("./data/raw/dados_municipais.csv")
df_clusterizado <- data.table::fread("./data/transformed/clustered_dataset")
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
		scale_fill_viridis(discrete=TRUE, option='rocket', direction = 1, begin=0.2,end=.8)+
		coord_flip()+
		tema2 -> gp
		gp <- ggplotly(gp)
		gp
	})

	output$bar_cluster <- renderPlotly({

		boxplotData() %>% group_by(model) %>% 
		count() %>%
			ggplot(aes(x = model, y = n))+
			geom_col(fill = "orangered2",width=0.5, alpha = 0.9)+
		    geom_text(aes(label=n),colour = 'white',
				size = 3,nudge_y = c(-100))+
			labs(x = "Cluster", y = 'Qtd')+
			tema2+
			theme(panel.border = element_blank(),
			      axis.line.x.bottom = element_line(size=0.2,colour='grey'),
			      panel.grid.major.y = element_line(size=0.1, colour = "grey70"),
			      axis.text.x=element_text(angle=0,hjust=1,face=2,size=10,colour="grey30")

			)	
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

