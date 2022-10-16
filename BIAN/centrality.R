library(igraph)

#centrality calculations
g=graph.adjacency(company_matrix)
degree=degree(g,mode='total',normalized=FALSE)

#FOR SORTED DEG.CENT
View(as.matrix(sort(degree, decreasing = TRUE)[1:20]))

closeness=closeness(g,normalized = TRUE)
betweenness=betweenness(g,normalized=FALSE)

centrality=matrix(data=c(degree,closeness,betweenness),nrow=159,ncol=3)
rownames(centrality)=unique_common_names
colnames(centrality)=c('degree','closeness','betweenness')
# plot(company_deals_network, vertex.size = 1, vertex.label = NA)
