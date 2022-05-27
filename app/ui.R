source("./src/R/libs.R")
options(spinner.size=0.5)

htmlTemplate("index.html",
              
            clusters_reg = withSpinner(plotlyOutput('qtd_regiao'),type = 3 , color='orange',color.background= 'orange'),
            count_cluster = withSpinner(plotlyOutput('bar_cluster'), type = 3 , color='orange',color.background= 'orange'),

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



