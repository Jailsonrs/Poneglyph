source("./src/R/libs.R")
options(spinner.size=0.5)

htmlTemplate("index.html",
            ## INPUTS

            n =  selectInput("variable", "Variável:",
                c("v1" = "cyl", "v2" = "am", "v3" = "gear")),

            n1 =  selectInput("variable", "Variável:",
                c("v1" = "cyl", "v2" = "am", "v3" = "gear")),

            n2 =  selectInput("variable", "Variável:",
                c("v1" = "cyl", "v2" = "am", "v3" = "gear")),

            n3 =  selectInput("variable", "Variável:",
                c("v1" = "cyl", "v2" = "am", "v3" = "gear")),

            ## OUTPUTS  
            clst = withSpinner(plotlyOutput('clusters'), 
                type = 3 , color = 'orange', color.background = 'orange'),
            
            clusters_reg = withSpinner(plotlyOutput('qtd_regiao'),
                type = 3 , color = 'orange', color.background = 'orange'),

            count_cluster = withSpinner(plotlyOutput('bar_cluster'), 
                type = 3 , color = 'orange', color.background = 'orange'),

            heatmap = withSpinner(plotlyOutput('hist2d'),
                type = 3 , color = 'orange', color.background = 'orange'),

            d2d = withSpinner(plotlyOutput('densidade3d'), 
                type = 3 , color = 'orange', color.background = 'orange'),





            teste =  tags$head(
                        tags$script("$('.tabbutton').click(function() {
                                          $('.tabbutton.active').removeClass('active');
                                          $(this).addClass('active');
                                          var tabNumber = $(this).attr('data-value');
                                          var tabToOpen = \".conteudo[data-value='\" + tabNumber + \"']\"; 
                                          $(tabToOpen).addClass('teste');
                                        })")
                                            )
)



