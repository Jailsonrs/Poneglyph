
fit_umap_btn <- actionButton("go", "Fit model")

file_input_btn <- actionButton("external_data", "Caregar outro dataset")


db_input <- selectInput("file1", "Selecione o dataset", choices = c("Censo Municipal", "Dataset 2"),
    selected = "Censo Municipal")

umap_init_method <- radioButtons("quote", "Método de inicialização",
    choices = c("Random", "Spectral", "Laplacian"), selected = 'Laplacian')

umap_n_neighbors <- sliderInput("header", "# Vizinhos", min  = 2, max = 1000, value = 10)

umap_learning_rate <- sliderInput("sep", "Taxa de aprendizagem", min  = 0, max = 1, value = 0.2)

umap_ncomponents <- sliderInput("sep", "# Componentes", min  = 2, max = 100, value = 10)
    



