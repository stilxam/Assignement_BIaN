import yfinance as yf
import pandas as pd
from datetime import datetime
from datetime import date
import seaborn as sns
import matplotlib as plt
sns.set(rc={'figure.figsize':(11.7,8.27)})
cmpnyLs = [
    "TOSYY",
    "INTC",
    "005930.KS",
    "TXN",
    "SHCAY",
    "HTHIY",
    "FJTSY",
    "AMD",
    "STM",
    "IBM"
]
dfClose = pd.DataFrame()
for company in cmpnyLs:
    quote = yf.download(tickers= company, interval= "1d", period="6y").copy()
    quote["day_time"] = quote.index
    quote["day_time"] = pd.to_datetime(quote["day_time"], format="%Y-%m-%d")
    quote = quote.loc[quote["day_time"] > "2017"]
    quote = quote.loc[quote["day_time"] < "2019"]
    value = quote["Close"][0]
    dfClose[f"{company}"] = (quote["Close"]/value - 1)*100

fig = sns.lineplot(data=dfClose);

fig.set(ylabel = "Stock Price Change (%)", title= "Stock Price Growth (%) of Key Chip Manufacturers 2017-2019")
fig.set_xlim(date(2017,1,1), date(2019,1,1))
spe = fig.get_figure()

spe.savefig("20172019Stocks.png")