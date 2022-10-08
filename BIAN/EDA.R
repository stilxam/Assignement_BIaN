set.seed(69)
file.url <- "https://drive.google.com/file/d/1CFyU7ELdB602DldMh6RjxxWtJXiqItWJ/view"
download.file(file.url, destfile = "BIData.rds", mode = "wb")
DT = readRDS("SDC_data_2021.rds")


#directed
adjm <- as.matrix(DT)
graph <- graph_from_adjacency_matrix(adjm, mode = "directed")
plot(graph)
#edge list
el <- as.matrix(DT)
graphEL <- graph_from_edgelist(el, directed = FALSE)
plot(graphEL)