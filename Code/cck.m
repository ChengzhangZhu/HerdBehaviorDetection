function [CSAD, beta1, beta2] =cck(data)
%Usage: [CSAD, beta1, beta2] = cck(data)
%
%Input: he stock history return rate matrix
%Output:CSAD, the CSAD vector for every day
 %            beta1, the coefficience of absolut average return rate
 %            beta2, the coefficience of average return rate squre
 
CSAD = zeros(size(data,1),1);
absAvgReturn = zeros(size(data,1),1);
squreAvgReturn = zeros(size(data,1),1);

for i = 1 : size(data,1)
returnRate = data(i,:);
avgRate = sum(returnRate,2)/size(returnRate,2);
CSAD(i,1) = sum(abs(returnRate - avgRate))/size(returnRate,2);
absAvgReturn(i,1) = abs(avgRate);
squreAvgReturn(i,1) = avgRate^2;
end

X = [ones(size(data,1),1), absAvgReturn, squreAvgReturn];
b = regress(CSAD,X);
beta1 = b(2);
beta2 = b(3);
