libs <- c("AER", "lmtest", "Hmisc", "dplyr", "tibble", "ivreg", "modelsummary",
          "summarytools")
for(pkg in libs){
  if(!require(pkg, character.only = TRUE))
  {
    install.packages(pkg, repos = 'http://cloud.r-project.org')
    library(pkg, character.only = TRUE)
  }
}
rm(list = ls())
setwd("/home/ovindare/Documents/Year 2/Business Insight and Networks/SNA/Git/Assignement_BIaN/Yapi/lowCent")
set.seed(689)
companies <- c("BB", "DELL", "DLB", "TSLA")

csvBB <- read.csv("preBB.csv", header = TRUE)
postdate <- as.Date(csvBB$Earnings.Date)
postBB <- csvBB$Reported.EPS
csvDELL <- read.csv("preDELL.csv", header = TRUE)
postDELL <- csvDELL$Reported.EPS
csvDLB <- read.csv("preDLB.csv", header = TRUE)
postDLB <- csvDLB$Reported.EPS
csvTSLA <- read.csv("preTSLA.csv", header = TRUE)
postTSLA <- csvTSLA$Reported.EPS

plot(x = postdate, y = postBB, type = "l", col = 1, ylab = "Earnings Per Share ($)", ylim = c(-5, 6), xlab = "Date", main = "Earning Per Share ($) of Low Degree Centrality Manufacturers Before The Start of COVID-19" )
lines(x = postdate, y = postDELL, col =2)
lines(x = postdate, y = postDLB, col =3)
lines(x = postdate, y = postTSLA, col =4)
legend(x = "topright", legend = companies, fill = 1:4)



closePre <- read.csv("preclose.csv", header = TRUE)
closePreDate <- as.Date(closePre$Date)
closeBB <- closePre$BB
closeDELL <- closePre$DELL
closeDLB <- closePre$DLB
closeTSLA <- closePre$TSLA

plot(x = closePreDate, y = closeBB, type ="l", ylim = c(-60, 150), xlab = "Date" ,ylab = "Stock Price Change (%)", main = "Stock Price Change (%) For Low Degree Centrality Manufacturers Before COVID-19")
lines(x = closePreDate, y = closeDELL, col = 2)
lines(x = closePreDate, y = closeDLB, col = 3)
lines(x = closePreDate, y = closeTSLA, col = 4)
legend(x = "topleft", legend = companies, fill = 1:4)
