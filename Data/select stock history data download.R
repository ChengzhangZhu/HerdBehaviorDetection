  library('stockPortfolio')
  
  ##read stock code
  stockCode <- read.csv('D:/Experiments/Herd Behavior Detection/Data/stock information balance.csv')
  
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
  
  ##select stock
  beginStock <- 353;
  endStock <- 500;
  selectStock <- code[c(beginStock:endStock)]
  
  
  ##download stock history data
  beginDate <- '2014-11-12'
  endDate <- '2014-11-22'
  historyData <- getReturns(selectStock,freq = 'day',start= beginDate,end= endDate)
  R <- historyData[[1]]
  #R <- R[1,]
  
  ##write csv file
  fileName <- paste("D:/Experiments/Herd Behavior Detection/Data/data(",beginStock,"-",endStock,")-date(",beginDate,"-",endDate,").csv",sep="")
  write.csv(R, file = fileName)
  
