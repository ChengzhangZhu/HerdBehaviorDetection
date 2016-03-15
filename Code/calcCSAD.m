function [CSAD] = calcCSAD(data)
%Usage: [CSAD] = calcCSAD(data)
%
%Input: the stock history return rate matrix
%Output: CSAD vector for every day

CSAD = zeros(size(data,1),1);
for i = 1 : size(data,1)
returnRate = data(i,:);
avgRate = sum(returnRate,2)/size(returnRate,2);
CSAD(i,1) = sum(abs(returnRate - avgRate))/size(returnRate,2);
end