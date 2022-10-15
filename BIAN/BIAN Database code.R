library(devtools)
library(nstandr)
library(dplyr)

top_100_database <- read.csv(file = "/Users/zygimantaskrasauskas/Desktop/BIAN/Group Project/top_100_database.csv", sep = ",")
sdc_database <- read.csv(file = "/Users/zygimantaskrasauskas/Desktop/BIAN/Group Project/sdc_database.csv", sep = ",")

sdc_database$date_announced <- substr((sdc_database$date_announced), 1, 4)
sdc_2019_2021 <- sdc_database[sdc_database$date_announced %in% c('2019', '2020', '2021'), ]

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

company_deals_network <- igraph::graph.incidence(company_matrix)
plot(company_deals_network, vertex.size = 1, vertex.label = NA)
