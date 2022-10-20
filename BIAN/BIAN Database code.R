library(devtools)
library(nstandr)
library(dplyr)
library(igraph)

top_100_database <- read.csv(file = "/Users/zygimantaskrasauskas/Desktop/BIAN/Group Project/top_100_database.csv", sep = ",")
sdc_database <- read.csv(file = "/Users/zygimantaskrasauskas/Desktop/BIAN/Group Project/sdc_database.csv", sep = ",")

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

plot(company_deals_network_clean, vertex.size = 7, vertex.label.cex = 2,
     vertex.color = ifelse(igraph::degree(company_deals_network_clean) >= 5, 
                           "green", "orange"), vertex.label.font=2, vertex.label.color= "black",
     vertex.label = ifelse(igraph::degree(company_deals_network_clean) >= 5, 
                           V(company_deals_network_clean)$name, NA))

values <- c()
names <- c(V(company_deals_network_clean)$name)



for (value in degree(company_deals_network_clean)){
  
  values <- append(values, value)
  
}

df <- data.frame(names, values)
df <- df[with(df, order(values)),]

values_1 <- c(df$values)
names_1 <- c(df$names)

df_1 <- data.frame(names_1, values_1)

write.csv(df_1,"/Users/zygimantaskrasauskas/Desktop/2020_2022.csv", row.names = FALSE)
