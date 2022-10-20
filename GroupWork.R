library(devtools)
library(nstandr)
library(dplyr)
library(magrittr)
library(lubridate)

current_dir <- getwd()
setwd(current_dir)

company_stocks <- read.csv(file = "C:/Users/Felipe Cintra/Documents/TUE_2223/JBE140-Bussiness Insights and Networks/RTutorials and Quiz/ClosePrice10.csv", sep = ",")
late_stocks <- read.csv(file = "C:/Users/Felipe Cintra/Documents/TUE_2223/JBE140-Bussiness Insights and Networks/RTutorials and Quiz/compnew.csv", sep = ",")
centrality_pre <-  read.csv(file = "C:/Users/Felipe Cintra/Documents/TUE_2223/JBE140-Bussiness Insights and Networks/2017_2019.csv", sep = ",")




company_stocks %<>%
  mutate(Date= as.Date(Date, format= "%Y-%m-%d"))

precovid <- company_stocks[lapply(company_stocks$Date, year) < 2019, ]
precovid <- subset(precovid, select = -c(1, 12 ) )
stock_median <- apply(precovid,2, median)

stock_means <- colMeans(precovid)
covid <- rep(-0.5, length(stock_means))

a = data.frame(stock_means, covid)

post_covid <- subset( precovid, select = -c(1, 2,3 ) )
post_covid_median <- apply(post_covid,2, median)
stock_means  <- colMeans(post_covid)
covid <- rep(1, length(post_covid))
b = data.frame(stock_means, covid)

c <- rbind(a,b)
centrality_pre <- c(3, 23, 23, 4, 2, 1, 1, 9, 2,  1)
centrality_pos <- c(1,1, 1, 1, 1, 1, 1)
d <- append(centrality_pre, centrality_pos)
c["centrality"] <- d

substr(test, 1, nchar(test)-6)

treated <- c[c["covid"] == 0.5]
c["did"] <- c["covid"]*c["centrality"]

didreg = lm(stock_means ~   centrality +covid+ did, data = c)
summary(didreg)

# split into high and low degree centrality
