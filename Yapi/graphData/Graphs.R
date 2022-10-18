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
EPSpost <- read.csv("EPSpost.csv", header = TRUE)
rdate <- as.Date(EPSpost$Earnings.Date, "%Y-%m-%d")

AMD <- EPSpost$EPS.AMD
INTC <- EPSpost$EPS.INTC
HTHIY <- EPSpost$EPS.HTHIY
STM <- EPSpost$EPS.STM
IBM <- EPSpost$EPS.IBM
TXN <- EPSpost$EPS.TXN

plot(x = rdate, y =AMD,type = "l",
     col = 1, xlab = "date", ylab = "Earnings Per Share ($)", ylim = c(-5,5), main = "Earning Per Share ($) of Key Chip Manufacturers During COVID-19")
lines(x = rdate,y =INTC, col=2)
lines(x = rdate,y =HTHIY, col=3)
lines(x = rdate,y =STM, col=4)
lines(x = rdate,y =IBM, col=5)
lines(x = rdate,y = TXN, col= 6)
legend(x= "bottomleft", legend = c("AMD", "INTC", "HTHIY", "STM", "IBM", "TXN"), fill = 1:6)

#EPSPre
csvAMD <- read.csv("preAMD.csv", header = TRUE)
predate <- as.Date(csvAMD$Earnings.Date)
preAMD<- csvAMD$Reported.EPS
csvINTC <- read.csv("preINTC.csv", header = TRUE)
preINTC<- csvINTC$Reported.EPS
csvHTHIY <- read.csv("preHTHIY.csv", header = TRUE)
preHTHIY<- csvHTHIY$Reported.EPS
csvSTM <- read.csv("preSTM.csv", header = TRUE)
preSTM<- csvSTM$Reported.EPS
csvIBM <- read.csv("preIBM.csv", header = TRUE)
preIBM<- csvIBM$Reported.EPS
csvTXN <- read.csv("preTXN.csv", header = TRUE)
preTXN<- csvTXN$Reported.EPS

plot(x = predate, y = preAMD, type = "l", col = 1,ylim = c(-0.5, 5), xlab = "Date", ylab = "Earnings Per Share ($)", main = "Earnings Per Share ($) of Key Chip Manufactures Pre-COVID19")
lines(x = predate, y = preINTC, col = 2 )
lines(x = predate, y = preHTHIY, col = 3 )
lines(x = predate, y = preSTM, col = 4 )
lines(x = predate, y = preIBM, col = 5)
lines(x = predate, y = preTXN, col = 6)
legend(x = "topright", legend = c("AMD", "INTC", "HTHIY", "STM", "IBM", "TXN"), fill = 1:6)








# STOCKS pre covid
closePre <- read.csv("closePre.csv", header = TRUE)
closePreDate <- as.Date(closePre$Date)
closePreTOSYY <- closePre$TOSYY.Stock.Value.Change....
closePreINTC <- closePre$INTC.Stock.Value.Change....
closePreTXN <- closePre$TXN.Stock.Value.Change....
closePreSHCAY <- closePre$SHCAY.Stock.Value.Change....
closePreHTHIY <- closePre$HTHIY.Stock.Value.Change....
closePreFJTSY <- closePre$FJTSY.Stock.Value.Change....
closePreAMD <- closePre$AMD.Stock.Value.Change....
closePreSTM <- closePre$STM.Stock.Value.Change....
closePreIBM <- closePre$IBM.Stock.Value.Change....

plot(x = closePreDate, y = closePreTOSYY, type = "l", ylim = c(-100, 200) , col = 1,  xlab = "Date", ylab = "Stock Price Change (%)", main = "Change in Stock Price (%) Before COVID-19" )
lines(x = closePreDate, y = closePreINTC, col =2)
lines(x = closePreDate, y = closePreTXN, col =3)
lines(x = closePreDate, y = closePreSHCAY, col =4)
lines(x = closePreDate, y = closePreHTHIY, col =5)
lines(x = closePreDate, y = closePreFJTSY, col =6)
lines(x = closePreDate, y = closePreAMD, col =7)
lines(x = closePreDate, y = closePreSTM, col =8)
lines(x = closePreDate, y = closePreIBM, col =9)
legend(x ="topleft", legend = c("TOSYY", "INTC", "TXN", "SHCAY", "HTHIY", "FJTSY", "AMD", "STM", "IBM"), fill = 1:9)


#Stocks Post Covid
closePost <- read.csv("closePost.csv", header = TRUE)
closePostDate <- as.Date(closePost$Date)
closePostTOSYY <- closePost$TOSYY.Stock.Value.Change....
closePostINTC <- closePost$INTC.Stock.Value.Change....
closePostTXN <- closePost$TXN.Stock.Value.Change....
closePostSHCAY <- closePost$SHCAY.Stock.Value.Change....
closePostHTHIY <- closePost$HTHIY.Stock.Value.Change....
closePostFJTSY <- closePost$FJTSY.Stock.Value.Change....
closePostAMD <- closePost$AMD.Stock.Value.Change....
closePostSTM <- closePost$STM.Stock.Value.Change....
closePostIBM <- closePost$IBM.Stock.Value.Change....

plot(x = closePostDate, y = closePostTOSYY, type = "l", ylim = c(-100, 250) , col = 1,  xlab = "Date", ylab = "Stock Price Change (%)", main = "Change in Stock Price (%) During COVID-19" )
lines(x = closePostDate, y = closePostINTC, col =2)
lines(x = closePostDate, y = closePostTXN, col =3)
lines(x = closePostDate, y = closePostSHCAY, col =4)
lines(x = closePostDate, y = closePostHTHIY, col =5)
lines(x = closePostDate, y = closePostFJTSY, col =6)
lines(x = closePostDate, y = closePostAMD, col =7)
lines(x = closePostDate, y = closePostSTM, col =8)
lines(x = closePostDate, y = closePostIBM, col =9)
legend(x ="topleft", legend = c("TOSYY", "INTC", "TXN", "SHCAY", "HTHIY", "FJTSY", "AMD", "STM", "IBM"), fill = 1:9)




