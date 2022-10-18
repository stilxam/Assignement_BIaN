import yfinance as yf
import pandas as pd
import seaborn as sns
from datetime import datetime
sns.set(rc = {"figure.figsize" :(11.7, 8.27)})
cmpnyLs = [
    "TOSYY",
    "INTC",
    "TXN",
    "SHCAY",
    "HTHIY",
    "FJTSY",
    "AMD",
    "STM",
    "IBM"
]
DF = pd.DataFrame()
latest = pd.DataFrame()
dateDF = pd.DataFrame()
for company in cmpnyLs:
    dateDF["Earnings Date"] = yf.Ticker(company).earnings_history["Earnings Date"]
    for i in range(len(dateDF)):
        date = dateDF["Earnings Date"][i]
        dateLs = date.split(",")
        dateDF["Earnings Date"][i] = datetime.strptime(f'{dateLs[0]},{dateLs[1]}', "%b %d, %Y").date()
    type(dateDF["Earnings Date"][0])
    DF["Earnings Date"] = dateDF["Earnings Date"].copy()
    DF[f'EPS {company}'] = yf.Ticker(company).earnings_history["Reported EPS"].copy() #pulls earnings per share into dataframe

DF.head()

    
















