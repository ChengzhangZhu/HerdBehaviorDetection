library('stockPortfolio')

##read stock code
stockCode <- read.csv('D:/Experiments/Herd Behavior Detection/Data/stock information.csv')

##get stock information
stockInfo <- data.frame()
for (i in 1:length(stockCode))
{
  domainName <- names(stockCode[i])
  domainCode <- stockCode[[i]]
  domainCode <- as.character(domainCode)
  domainCode <- domainCode[complete.cases(domainCode)]
  domainCode <- paste(domainCode,'.ss',sep="")
  ticker <- domainCode
  industry <- rep(domainName, length(domainCode))
  domainInfo <- data.frame(ticker,industry)
  stockInfo <- rbind.data.frame(stockInfo,domainInfo)
}

##add index
ticker <- '1A0001.ss'
industry <- 'Index'
indexInfo <- data.frame(ticker,industry)
stockInfo <- rbind.data.frame(stockInfo,indexInfo)

##delete same stock
freq <- table(stockInfo$ticker)
reClass <- names(freq[which(freq > 1)])
for (i in 1:length(reClass))
{
  reStock <- stockInfo[stockInfo$ticker %in% reClass[1],]
  reStockLoc <- rownames(reStock)
  reStockLoc <- as.integer(reStockLoc)
  reStockLoc <- reStockLoc[-1]
  stockInfo <- stockInfo[-reStockLoc,]
}

##transform stock tickes
code <- as.character(stockInfo$ticker)

##download stock history data and excute stockportfolio analysis
selectStock <- code[sample(20)]
historyData <- getReturns(selectStock,start='2014-01-01',end='2014-06-30')
non <- stockModel(historyData, drop=20, model='CCM')
opNon <- optimalPort(non)
historyData <- getReturns(selectStock,start='2014-07-01',end='2014-12-31')
tpNon <- testPort(historyData, opNon)
plot(tpNon)
tpNon
historyData <- getReturns(selectStock,start='2015-01-01',end='2015-12-31')
tpNon <- testPort(historyData, opNon)
plot(tpNon)
tpNon
