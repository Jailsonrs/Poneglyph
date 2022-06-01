## umap module
#' @ rtest 

library(uwot)

# Non-numeric columns are ignored, so in a lot of cases you can pass a data
# frame directly to umap

l = list(
	neighbors = 23 ,
	lr = 0.2,
	init_method = 'random',
	components = 3,
	m = 'correlation',
	seed = c() 
)

## a wrapper arround UMAP to handle shiny apps and all types of args
umap_fit <- function(d.f, ...){	
	L = list(...)
	SEED = set.seed(l$seed)
    d.f |> umap(
			n_neighbors = L$neighbors,
			learning_rate = L$lr,
	 		init = L$init_method,
	 		n_components = L$components,
	 		metric = L$m
	 		)
}
 

