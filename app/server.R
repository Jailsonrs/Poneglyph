source("src/R/libs.R")
source("src/R/MyGgthemes.R")
library(MASS)
library(glue)
library(shiny)
library(tidyverse)
library(DT)
library(viridis)
library("scales")
library(dplyr)
library(hexbin)
library(viridis)
library(leaflet)

MAX_REQ_SIZE = 500*1024^2
options(shiny.maxRequestSize = MAX_REQ_SIZE)

embeddings <- read.csv('./data/transformed/UMAP_embeddings.csv')
df_municipios <- data.table::fread("./data/raw/dados_municipais.csv")
df_clusterizado <- data.table::fread("./data/transformed/clustered_dataset")
embeddings <- data.frame(embeddings[,c(4,7)], df_clusterizado[,'model'])
df_cluster_unscalled <- data.frame(df_municipios, df_clusterizado[,'model'])
df_cluster_unscalled <- df_cluster_unscalled %>%
	tidyr::separate("Município", sep="\\(", into = c("Municip","estado"))  %>% dplyr::select(-4)
df_cluster_unscalled[,'estado'] <- str_remove(df_cluster_unscalled[,'estado'],pattern='\\)')

function(session, input, output){

	filteredData <- reactive({df_cluster_unscalled %>% 
		group_by(estado, model) %>% count() %>% arrange(model)
	})

	boxplotData <- reactive({
		df_cluster_unscalled
	})

	output$clusters <- renderPlotly({
		embeddings %>% 
		ggplot(aes(x = emb2,y = emb5, color = model+runif(5360,0,0.999)))+
			geom_jitter(width=0.3,height=0.3, alpha=0.4)+
			labs(color='clusters')+
			labs(x = "Embedding 2", y = 'Embedding 5', fill="Cluster")+
			scale_color_viridis(option='rocket', direction = -1, begin=0,end=1)+
			tema2+
			theme(panel.border = element_blank(),
			      axis.line.x.bottom = element_line(size=0.2,colour='grey'),
			      panel.grid.major.y = element_line(size=0.1, colour = "grey70"),
			      axis.text.x=element_text(angle=0,hjust=1,face=2,size=10,colour="grey30")) -> gp
		gp <- ggplotly(gp)
		gp
	})

	output$qtd_regiao <- renderPlotly({
		ggplot(filteredData(), aes(x =n,y = estado, fill= factor(model)))+
		geom_col()+
		labs(x = "n", y = 'UF', fill="Cluster")+
		scale_fill_viridis(discrete=TRUE, option='rocket', direction = -1, begin=0.18,end=.9)+
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


	output$hist2d <- renderPlotly({
		embeddings %>%
		 ggplot( aes(emb2, emb5))+ 
  		 stat_density_2d(aes(fill = ..density..), geom = "raster", contour = FALSE) +
  		 scale_x_continuous(expand = c(0, 0)) +
  		 scale_y_continuous(expand = c(0, 0)) +
  		 scale_fill_viridis(option = 'rocket', direction = 1)+
  	     theme(panel.border = element_blank(),
		       axis.line.x.bottom = element_line(size=0.2,colour='grey'),
			   panel.grid.major.y = element_line(size=0.1, colour = "grey70"),
			   axis.text.x=element_text(angle=0,hjust=1,face=2,size=10,colour="grey30"),
			   panel.background = element_rect(fill = '#00082f')) -> h3
  	     h3

	})


	output$densidade3d <- renderPlotly({
		yaxis <- list(
			title = 'Y-axis Title',
		  	ticktext = list('long label','Very long label','3','label'),
  			tickvals = list(1, 2, 3, 4),
		    tickmode = "array",
  			automargin = TRUE,
  			titlefont = list(size=30)
  		)

		kd <- with(embeddings, MASS::kde2d(emb2, emb5, n = 50))

		plot_ly(x = kd$x, y = kd$y, z = kd$z, 
			colors = rocket(50, alpha = 1, begin = 0, end = 1, direction = 1)) %>% 
			add_surface() %>%
			layout(autosize = T,yaxis = yaxis)
	})

  output$contents <- renderTable({
  	req(input$file1)
  	df <- read.csv(input$file1$datapath,
  		header = input$header,
  		sep = input$sep,
        quote = input$quote)
    if (input$disp == "head") {
    	return(head(df))
    }
    else {
    	return(df)
    }})

	
}

