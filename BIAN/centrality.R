library(devtools)
library(nstandr)
library(dplyr)
library(igraph)

top_100_database <- read.csv(file = "/home/igor/Documents/tue/business_insights/sdc_100.csv", sep = ",")
sdc_database <- read.csv(file = "/home/igor/Documents/tue/business_insights/sdc.csv", sep = ",")

sdc_database$date_announced <- substr((sdc_database$date_announced), 1, 4)
top_100_names <- top_100_database$Company.name.Latin.alphabet

#2020, 2021
sdc_2020_2021 <- sdc_database[sdc_database$date_announced %in% c('2020', '2021'), ]

selected_names_db_2020_2021 <- sdc_2020_2021[sdc_2020_2021$participants %in% top_100_names, ]
relevant_deal_numbers_2020_2021 <- unique(c(selected_names_db_2020_2021$deal_number))

db_based_on_deal_2020_2021 <- sdc_2020_2021[sdc_2020_2021$deal_number %in% relevant_deal_numbers_2020_2021, ]
unique_common_names_2020_2021 <- unique(c(db_based_on_deal_2020_2021$participants))

company_matrix_2020_2021 <- matrix(, nrow = length(unique_common_names_2020_2021), ncol = length(unique_common_names_2020_2021))
rownames(company_matrix_2020_2021) <- unique_common_names_2020_2021
colnames(company_matrix_2020_2021) <- unique_common_names_2020_2021

for(row in 1:nrow(company_matrix_2020_2021))
{
  for(col in 1:ncol(company_matrix_2020_2021))
  {
    if (row == col)
    {
      company_matrix_2020_2021[row, col] = 0
    }
    else
    {
      company_matrix_2020_2021[row, col] = 2
    }
  }
}

for (value in db_based_on_deal_2020_2021$deal_number)
{
  deal_df <- db_based_on_deal_2020_2021[db_based_on_deal_2020_2021$deal_number == value, ]
  deal_participants <- c(deal_df$participants)
  for (name_1 in deal_participants)
  {
    for(name_2 in deal_participants)
    {
      if (company_matrix_2020_2021[name_1, name_2] != 0)
      {
        company_matrix_2020_2021[name_1, name_2] = 1
      }
    }
  }
}

for(row in 1:nrow(company_matrix_2020_2021))
{
  for(col in 1:ncol(company_matrix_2020_2021))
  {
    if (company_matrix_2020_2021[row, col] == 2)
    {
      company_matrix_2020_2021[row, col] = 0
    }
  }
}

company_deals_network_2020_2021 <- igraph::graph.incidence(company_matrix_2020_2021)

g_2020_2021=graph.adjacency(company_matrix_2020_2021,mode='undirected')
degree=degree(g_2020_2021,normalized=FALSE)
closeness=closeness(g_2020_2021,normalized = TRUE)
betweenness=betweenness(g_2020_2021,normalized=FALSE)

centrality_2020_2021=matrix(data=c(degree,closeness,betweenness),nrow=length(unique_common_names_2020_2021),ncol=3)
rownames(centrality_2020_2021)=unique_common_names_2020_2021
colnames(centrality_2020_2021)=c('degree','closeness','betweenness')

show_2020_2021=unique_common_names_2020_2021

for (i in 1:length(unique_common_names_2020_2021))
{
  if (centrality_2020_2021[unique_common_names_2020_2021[i], 'degree']==1)
  {
    show_2020_2021[i]=NA
  }
}

graph_2020_2021=graph_from_adjacency_matrix(company_matrix_2020_2021,mode='undirected')

# dev.new(width=100,height=50)
# plot.igraph(graph_2020_2021,vertex.size=6,vertex.label=show_2020_2021)


# 2017, 2018
sdc_2017_2018 <- sdc_database[sdc_database$date_announced %in% c('2017', '2018'), ]

selected_names_db_2017_2018 <- sdc_2017_2018[sdc_2017_2018$participants %in% top_100_names, ]
relevant_deal_numbers_2017_2018 <- unique(c(selected_names_db_2017_2018$deal_number))

db_based_on_deal_2017_2018 <- sdc_2017_2018[sdc_2017_2018$deal_number %in% relevant_deal_numbers_2017_2018, ]
unique_common_names_2017_2018 <- unique(c(db_based_on_deal_2017_2018$participants))

company_matrix_2017_2018 <- matrix(, nrow = length(unique_common_names_2017_2018), ncol = length(unique_common_names_2017_2018))
rownames(company_matrix_2017_2018) <- unique_common_names_2017_2018
colnames(company_matrix_2017_2018) <- unique_common_names_2017_2018

for(row in 1:nrow(company_matrix_2017_2018))
{
  for(col in 1:ncol(company_matrix_2017_2018))
  {
    if (row == col)
    {
      company_matrix_2017_2018[row, col] = 0
    }
    else
    {
      company_matrix_2017_2018[row, col] = 2
    }
  }
}

for (value in db_based_on_deal_2017_2018$deal_number)
{
  deal_df <- db_based_on_deal_2017_2018[db_based_on_deal_2017_2018$deal_number == value, ]
  deal_participants <- c(deal_df$participants)
  for (name_1 in deal_participants)
  {
    for(name_2 in deal_participants)
    {
      if (company_matrix_2017_2018[name_1, name_2] != 0)
      {
        company_matrix_2017_2018[name_1, name_2] = 1
      }
    }
  }
}

for(row in 1:nrow(company_matrix_2017_2018))
{
  for(col in 1:ncol(company_matrix_2017_2018))
  {
    if (company_matrix_2017_2018[row, col] == 2)
    {
      company_matrix_2017_2018[row, col] = 0
    }
  }
}

company_deals_network_2017_2018 <- igraph::graph.incidence(company_matrix_2017_2018)

g_2017_2018=graph.adjacency(company_matrix_2017_2018,mode='undirected')
degree=degree(g_2017_2018,normalized=FALSE)
closeness=closeness(g_2017_2018,normalized = TRUE)
betweenness=betweenness(g_2017_2018,normalized=FALSE)

centrality_2017_2018=matrix(data=c(degree,closeness,betweenness),nrow=length(unique_common_names_2017_2018),ncol=3)
rownames(centrality_2017_2018)=unique_common_names_2017_2018
colnames(centrality_2017_2018)=c('degree','closeness','betweenness')

# plot(company_deals_network_2020_2021, vertex.size = 1, vertex.label = NA)

show_2017_2018=unique_common_names_2017_2018

for (i in 1:length(unique_common_names_2017_2018))
{
  if (centrality_2017_2018[unique_common_names_2017_2018[i], 'degree']==1)
  {
    show_2017_2018[i]=NA
  }
}

graph_2017_2018=graph_from_adjacency_matrix(company_matrix_2017_2018,mode='undirected')

dev.new(width=100,height=50)
plot(graph_2017_2018,vertex.size=6,vertex.label=show_2017_2018)


names_intersection=Reduce(intersect, list(unique_common_names_2017_2018,unique_common_names_2020_2021))

mean_degree_2017_2018=mean(centrality_2017_2018[,'degree'])
mean_degree_2020_2021=mean(centrality_2020_2021[,'degree'])
mean_closeness_2017_2018=mean(centrality_2017_2018[,'closeness'])
mean_closeness_2020_2021=mean(centrality_2020_2021[,'closeness'])

hist(centrality_2017_2018[,'closeness'],breaks=c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1))
hist(centrality_2020_2021[,'closeness'],breaks=c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1))

# hist(centrality_2017_2018[,'degree'])
# hist(centrality_2020_2021[,'degree'])

# hist(centrality_2017_2018[,'betweenness'])
# hist(centrality_2020_2021[,'betweenness'])
