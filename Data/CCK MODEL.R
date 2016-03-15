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
selectStock <- code[c(1:120)]


##download stock history data
historyData <- getReturns(selectStock,freq = 'month',start='2015-05-27',end='2015-06-5')
R <- historyData[[1]]
R <- R[1,]

##calculate CSAD value
CSAD <- mean(abs(R -mean(R)))


##
# R <- numeric()
# for(i in 1:3)
# {
#  
#   selectStock <- code[i*10-9:i*10]
#   
#   historyData <- getReturns(selectStock,freq = 'month',start='2015-01-01',end='2015-03-01')
#   crossData <- historyData[[1]]
#   R[i*10-9:i*10] <- crossData[1,]
# }
# #
# CSAD <- mean(abs(R -mean(R)))