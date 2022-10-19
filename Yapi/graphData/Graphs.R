setwd("/home/ovindare/Documents/Year 2/Business Insight and Networks/SNA/Git/Assignement_BIaN/Yapi/graphData")
set.seed(689)
rm(list = ls())
libs <- c("AER", "lmtest", "Hmisc", "dplyr", "tibble", "ivreg", "modelsummary",
          "summarytools")
for(pkg in libs){
  if(!require(pkg, character.only = TRUE))
  {
    install.packages(pkg, repos = 'http://cloud.r-project.org')
    library(pkg, character.only = TRUE)
  }
}
install.packages("ggplot2")
library("ggplot2")

#graph PostEPS

csvAMD <- read.csv("postAMD.csv", header = TRUE)
predate <- as.Date(csvAMD$Earnings.Date)
postAMD<- csvAMD$Reported.EPS

csvHTHIY <- read.csv("postHTHIY.csv", header = TRUE)
postHTHIY <- csvHTHIY$Reported.EPS

csvIBM <- read.csv("postIBM.csv", header = TRUE)
postIBM <- csvIBM$Reported.EPS

csvINTC <- read.csv("postINTC.csv", header = TRUE)
postINTC <- csvINTC$Reported.EPS

csvMSFT <- read.csv("postMSFT.csv", header = TRUE)
postMSFT <- csvMSFT$Reported.EPS

csvNVDA <- read.csv("postNVDA.csv", header = TRUE)
postNVDA <- csvNVDA$Reported.EPS

csvNXPI <- read.csv("postNXPI.csv", header = TRUE)
postNXPI <- csvNXPI$Reported.EPS

csvSTM <- read.csv("postSTM.csv", header = TRUE)
postSTM <- csvSTM$Reported.EPS

csvTXN <- read.csv("postTXN.csv", header = TRUE)
postTXN <- csvTXN$Reported.EPS




plot(x = predate, y =postAMD,type = "l",
     col = 1, xlab = "date", ylab = "Earnings Per Share ($)", ylim = c(-5,5), main = "Earning Per Share ($) of Key Chip Manufacturers After The start of COVID-19")
lines(x = predate,y =postHTHIY, col=2)
lines(x = predate,y =postIBM, col=3)
lines(x = predate,y =postINTC, col=4)
lines(x = predate,y =postMSFT, col=5)
lines(x = predate,y = postNVDA, col= 6)
lines(x = predate, y = postNXPI, col = 7 )
lines(x = predate, y = postSTM , col = 8 )
lines(x = predate, y = postTXN, col = 19)
legend(x= "bottomright", legend = c("AMD", "HTHIY", "IBM", "INTC", "MSFT", "NVDA", "NXPI", "STM", "TXN"), fill = c(1,2,3,4,5,6,7,8,19))

#EPSPre
precsvAMD <- read.csv("preAMD.csv", header = TRUE)
predate <- as.Date(precsvAMD$Earnings.Date)
preAMD<- precsvAMD$Reported.EPS

precsvHTHIY <- read.csv("preHTHIY.csv", header = TRUE)
preHTHIY <- precsvHTHIY$Reported.EPS

precsvIBM <- read.csv("preIBM.csv", header = TRUE)
preIBM <- precsvIBM$Reported.EPS

precsvINTC <- read.csv("preINTC.csv", header = TRUE)
preINTC <- precsvINTC$Reported.EPS

precsvMSFT <- read.csv("preMSFT.csv", header = TRUE)
preMSFT <- precsvMSFT$Reported.EPS

precsvNVDA <- read.csv("preNVDA.csv", header = TRUE)
preNVDA <- precsvNVDA$Reported.EPS

precsvNXPI <- read.csv("preNXPI.csv", header = TRUE)
preNXPI <- precsvNXPI$Reported.EPS

precsvSTM <- read.csv("preSTM.csv", header = TRUE)
preSTM <- precsvSTM$Reported.EPS

precsvTXN <- read.csv("preTXN.csv", header = TRUE)
preTXN <- precsvTXN$Reported.EPS

plot(x = predate, y = preAMD, type = "l", col = 1,ylim = c(-1, 6.5), xlab = "Date", ylab = "Earnings Per Share ($)", main = "Earnings Per Share ($) of Key Chip Manufactures Pre-COVID-19")

lines(x = predate,y =preHTHIY, col=2)
lines(x = predate,y =preIBM, col=3)
lines(x = predate,y =preINTC, col=4)
lines(x = predate,y =preMSFT, col=5)
lines(x = predate,y = preNVDA, col= 6)
lines(x = predate, y = preNXPI, col = 7 )
lines(x = predate, y = preSTM , col = 8 )
lines(x = predate, y = preTXN, col = 19)
legend(x= "topright", legend = c("AMD", "HTHIY", "IBM", "INTC", "MSFT", "NVDA", "NXPI", "STM", "TXN"), fill = c(1,2,3,4,5,6,7,8,19))



# STOCKS pre covid
closePre <- read.csv("closePre.csv", header = TRUE)
closePreDate <- as.Date(closePre$Date)
closePreAMD <- closePre$AMD.Stock.Value.Change....
closePreHTHIY <- closePre$HTHIY.Stock.Value.Change....
closePreIBM <- closePre$IBM.Stock.Value.Change....
closePreINTC <- closePre$INTC.Stock.Value.Change....
closePreMSFT <- closePre$MSFT.Stock.Value.Change....
closePreNVDA <- closePre$NVDA.Stock.Value.Change....
closePreNXPI <- closePre$NXPI.Stock.Value.Change....
closePreSTM <- closePre$STM.Stock.Value.Change....
closePreTXN <- closePre$TXN.Stock.Value.Change....



plot(x = closePreDate, y = closePreAMD, type = "l", ylim = c(-50, 200) , col = 1,  xlab = "Date", ylab = "Stock Price Change (%)", main = "Change in Stock Price (%) Before COVID-19" )
lines(x = closePreDate, y = closePreHTHIY, col =2)
lines(x = closePreDate, y = closePreIBM, col =3)
lines(x = closePreDate, y = closePreINTC, col =4)
lines(x = closePreDate, y = closePreMSFT, col =5)
lines(x = closePreDate, y = closePreNVDA, col =6)
lines(x = closePreDate, y = closePreNXPI, col =7)
lines(x = closePreDate, y = closePreSTM, col =8)
lines(x = closePreDate, y = closePreTXN, col =9)
legend(x= "topleft", legend = c("AMD", "HTHIY", "IBM", "INTC", "MSFT", "NVDA", "NXPI", "STM", "TXN"), fill = c(1,2,3,4,5,6,7,8,19))



#Stocks Post Covid
closePost <- read.csv("closePost.csv", header = TRUE)
closePostDate <- as.Date(closePost$Date)
closePostAMD <- closePost$AMD.Stock.Value.Change....
closePostHTHIY <- closePost$HTHIY.Stock.Value.Change....
closePostIBM <- closePost$IBM.Stock.Value.Change....
closePostINTC <- closePost$INTC.Stock.Value.Change....
closePostMSFT <- closePost$MSFT.Stock.Value.Change....
closePostNVDA <- closePost$NVDA.Stock.Value.Change....
closePostNXPI <- closePost$NXPI.Stock.Value.Change....
closePostSTM <- closePost$STM.Stock.Value.Change....
closePostTXN <- closePost$TXN.Stock.Value.Change....

plot(x = closePostDate, y = closePostAMD, type = "l", ylim = c(-50, 250) , col = 1,  xlab = "Date", ylab = "Stock Price Change (%)", main = "Change in Stock Price (%) During COVID-19" )
lines(x = closePostDate, y = closePostHTHIY, col =2)
lines(x = closePostDate, y = closePostIBM, col =3)
lines(x = closePostDate, y = closePostINTC, col =4)
lines(x = closePostDate, y = closePostMSFT, col =5)
lines(x = closePostDate, y = closePostNVDA, col =6)
lines(x = closePostDate, y = closePostNXPI, col =7)
lines(x = closePostDate, y = closePostSTM, col =8)
lines(x = closePostDate, y = closePostTXN, col =9)
legend(x= "topleft", legend = c("AMD", "HTHIY", "IBM", "INTC", "MSFT", "NVDA", "NXPI", "STM", "TXN"), fill = c(1,2,3,4,5,6,7,8,19))




