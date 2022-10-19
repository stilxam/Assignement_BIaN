library(devtools)
library(nstandr)
library(dplyr)
library(magrittr)
library(lubridate)

current_dir <- getwd()
setwd(current_dir)

company_stocks <- read.csv(file = "C:/Users/Felipe Cintra/Documents/TUE_2223/JBE140-Bussiness Insights and Networks/RTutorials and Quiz/ClosePrice10.csv", sep = ",")
late_stocks <- read.csv(file = "C:/Users/Felipe Cintra/Documents/TUE_2223/JBE140-Bussiness Insights and Networks/RTutorials and Quiz/compnew.csv", sep = ",")

company_stocks %<>%
  mutate(Date= as.Date(Date, format= "%Y-%m-%d"))

str(company_stocks)
precovid <- company_stocks[lapply(company_stocks$Date, year) < 2019, ]
precovid <- subset(precovid, select = -c(1, 12 ) )

str(precovid)

stock_median <- apply(precovid,2, median)
stock_means <- colMeans(precovid)
post_covid <- subset( precovid, select = -c(1, 2,3 ) )
post_covid_median <- apply(post_covid,2, median)
t.test(post_covid_median, stock_median)