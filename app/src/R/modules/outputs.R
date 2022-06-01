clst = withSpinner(plotlyOutput('clusters'),
    type = 3 , color = 'orange', color.background = 'orange')

clusters_reg = withSpinner(plotlyOutput('qtd_regiao'),
    type = 3 , color = 'orange', color.background = 'orange')

count_cluster = withSpinner(plotlyOutput('bar_cluster'), 
    type = 3 , color = 'orange', color.background = 'orange')

heatmap = withSpinner(plotlyOutput('hist2d'),
    type = 3 , color = 'orange', color.background = 'orange')

d2d = withSpinner(plotlyOutput('densidade3d'), 
    type = 3 , color = 'orange', color.background = 'orange')

#placeholder <- uiOutput('datapanel')
ExternalDatasetName <- textOutput('dataNames')
tab <- dataTableOutput('external_dataset')


