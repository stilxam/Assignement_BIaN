import yfinance as yf
import pandas as pd
from datetime import datetime
cmpnyLs = ["ASML", "AAPL"] # import list of company stock symbols
DF = pd.DataFrame()
output = pd.DataFrame()
for company in cmpnyLs:
    dateDF = pd.DataFrame()
    dateDF["Earnings Date"] = yf.Ticker(company).earnings_history["Earnings Date"] #pulls dates of earning
    for i in range(len(dateDF)): #creates columns of restructured Datetime as dt obj
        date = dateDF["Earnings Date"][i]
        dateLs = date.split(",")
        noHours = dateLs[:-1]
        dateDF["Earnings Date"][i] = datetime.strptime(f'{noHours[0]},{noHours[1]}', "%b %d, %Y").date()
    DF["Earnings Date"] = dateDF["Earnings Date"] #merges Date into DF
    DF[f'EPS {company}'] = yf.Ticker(company).earnings_history["Reported EPS"].copy() #pulls earnings per share into dataframe

output = DF.iloc[:12]
output.to_csv("earnings.csv", index = False)


dfClose = pd.DataFrame()
for company in cmpnyLs:
    quote = yf.download(tickers= company, interval= "3mo", period="3y").copy()
    dfClose[f"{company} Close"] = quote["Close"]

dfClose.to_csv("ClosePrice.csv")