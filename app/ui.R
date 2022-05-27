source("./src/R/libs.R")
options(spinner.size=0.5)

htmlTemplate("index.html",
            ##inputs
            

            ##outputs
            out_df_clusterizado = DT::dataTableOutput("dt_clusterizado"),
            clusters_reg = plotlyOutput('qtd_regiao'),
            count_cluster = plotlyOutput('bar_cluster')
)



