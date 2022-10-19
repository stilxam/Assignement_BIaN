library(devtools)
library(nstandr)
library(dplyr)
library(igraph)

top_100_database <- read.csv(file = "C:/Users/Felipe Cintra/Documents/TUE_2223/JBE140-Bussiness Insights and Networks/top_100_database.csv", sep = ",")
sdc_database <- read.csv(file = "C:/Users/Felipe Cintra/Documents/TUE_2223/JBE140-Bussiness Insights and Networks/sdc_database.csv", sep = ",")

sdc_database$date_announced <- substr((sdc_database$date_announced), 1, 4)
sdc_2019_2021 <- sdc_database[sdc_database$date_announced %in% c("2020", "2021"), ]

top_100_names <- top_100_database$Company.name.Latin.alphabet

selected_names_db <- sdc_2019_2021[sdc_2019_2021$participants %in% top_100_names, ]
relevant_deal_numbers <- unique(c(selected_names_db$deal_number))

db_based_on_deal <- sdc_2019_2021[sdc_2019_2021$deal_number %in% relevant_deal_numbers, ]
unique_common_names <- unique(c(db_based_on_deal$participants))

company_matrix <- matrix(, nrow = length(unique_common_names), ncol = length(unique_common_names))
rownames(company_matrix) <- unique_common_names
colnames(company_matrix) <- unique_common_names

for(row in 1:nrow(company_matrix)) {
  for(col in 1:ncol(company_matrix)) {
    
    if (row == col){
      
      company_matrix[row, col] = 0
      
    }else{
      
      company_matrix[row, col] = 2
      
    }
  }
}

for (value in db_based_on_deal$deal_number){
  
  deal_df <- db_based_on_deal[db_based_on_deal$deal_number == value, ]
  deal_participants <- c(deal_df$participants)
  
  repeats_vector <- c()
  
  for (name_1 in deal_participants){
    
    for(name_2 in deal_participants){
      
      if (company_matrix[name_1, name_2] != 0){
        
        company_matrix[name_1, name_2] = 1
        
      }
    }
  }
}

for(row in 1:nrow(company_matrix)){
  
  for(col in 1:ncol(company_matrix)){
    
    if (company_matrix[row, col] == 2){
      
      company_matrix[row, col] = 0
    }
  }
}

for(row in 1:nrow(company_matrix)){
  
  for(col in 1:ncol(company_matrix)){
    
    if (company_matrix[row, col] == 1){
      
      company_matrix[col, row] = 0
    }
  }
}


company_deals_network <- igraph::graph.incidence(company_matrix)

isolated = which(igraph::degree(company_deals_network)==0)
company_deals_network_clean = igraph::delete.vertices(company_deals_network, isolated)

#centrality calculations
g=graph.adjacency(company_matrix)
degree=degree(g,mode='total',normalized=FALSE)
closeness=closeness(g,normalized = TRUE)
betweenness=betweenness(g,normalized=FALSE)

centrality_new=matrix(data=c(degree,closeness,betweenness),nrow=159,ncol=3)
rownames(centrality_new)=unique_common_names
colnames(centrality_new)=c('degree','closeness','betweenness')
# plot(company_deals_network, vertex.size = 1, vertex.label = NA)


sdc_database$date_announced <- substr((sdc_database$date_announced), 1, 4)
sdc_2017_2018 <- sdc_database[sdc_database$date_announced %in% c("2017", "2018"), ]

top_100_names <- top_100_database$Company.name.Latin.alphabet

selected_names_db <- sdc_2017_2018[sdc_2017_2018$participants %in% top_100_names, ]
relevant_deal_numbers <- unique(c(selected_names_db$deal_number))

db_based_on_deal <- sdc_2017_2018[sdc_2017_2018$deal_number %in% relevant_deal_numbers, ]
unique_common_names <- unique(c(db_based_on_deal$participants))

company_matrix <- matrix(, nrow = length(unique_common_names), ncol = length(unique_common_names))
rownames(company_matrix) <- unique_common_names
colnames(company_matrix) <- unique_common_names

for(row in 1:nrow(company_matrix)) {
  for(col in 1:ncol(company_matrix)) {
    
    if (row == col){
      
      company_matrix[row, col] = 0
      
    }else{
      
      company_matrix[row, col] = 2
      
    }
  }
}

for (value in db_based_on_deal$deal_number){
  
  deal_df <- db_based_on_deal[db_based_on_deal$deal_number == value, ]
  deal_participants <- c(deal_df$participants)
  
  repeats_vector <- c()
  
  for (name_1 in deal_participants){
    
    for(name_2 in deal_participants){
      
      if (company_matrix[name_1, name_2] != 0){
        
        company_matrix[name_1, name_2] = 1
        
      }
    }
  }
}

for(row in 1:nrow(company_matrix)){
  
  for(col in 1:ncol(company_matrix)){
    
    if (company_matrix[row, col] == 2){
      
      company_matrix[row, col] = 0
    }
  }
}

for(row in 1:nrow(company_matrix)){
  
  for(col in 1:ncol(company_matrix)){
    
    if (company_matrix[row, col] == 1){
      
      company_matrix[col, row] = 0
    }
  }
}


company_deals_network <- igraph::graph.incidence(company_matrix)

isolated = which(igraph::degree(company_deals_network)==0)
company_deals_network_clean = igraph::delete.vertices(company_deals_network, isolated)
#centrality calculations
g=graph.adjacency(company_matrix)
degree=degree(g,mode='total',normalized=FALSE)
closeness=closeness(g,normalized = TRUE)
betweenness=betweenness(g,normalized=FALSE)

centrality_old=matrix(data=c(degree,closeness,betweenness),nrow=159,ncol=3)
rownames(centrality_old)=unique_common_names
colnames(centrality_old)=c('degree','closeness','betweenness')



centrality_new_median <- apply(centrality_new,2, median)
centrality_new_means <- colMeans(centrality_new)
centrality_old_median <- apply(centrality_old,2, median)
t.test(data.frame(centrality_old)$degree, data.frame(centrality_new)$degree)
