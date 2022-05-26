library("ranger")
embeddings <- read.csv('../data/transformed/UMAP_embeddings.csv')
embeddings <- data.frame(embeddings[,c(4,7)], df_clusterizado[,'model'])


 
rf_grid <- expand.grid(mtry = c(1,2),
                      splitrule = c("gini", "extratrees"),
                      min.node.size = c(1, 3, 5, 7, 9, 10, 20, 30, 40, 50, 100))
 
 
cctrl2 <- trainControl(method = "cv", number=10, returnResamp="all",
                       classProbs = TRUE,                      
                       verboseIter = TRUE)
 
test_class_cv_model2 <- train(cluster~var1+var2, method = "ranger", 
                             trControl = cctrl2, metric = "ROC",
                             data = embeddings,
                            # preProc = c("center", "scale"),
                             tuneGrid =rf_grid )



colnames(embeddings) <- c("var1","var2","cluster")
embeddings$cluster <- as.character(embeddings$cluster)
embeddings$cluster <- gsub('0', 'A',embeddings$cluster)
embeddings$cluster <- gsub("1", 'B',embeddings$cluster)
embeddings$cluster <- gsub("2", 'C',embeddings$cluster)
embeddings$cluster <- gsub("3", 'D',embeddings$cluster)
embeddings$cluster <- gsub("4", 'E',embeddings$cluster)





