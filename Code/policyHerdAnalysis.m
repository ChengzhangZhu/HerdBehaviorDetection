function [CSADAll,B2,B3] = policyHerdAnalysis(data, timeLine, t, policy)
%Usage: [CSADAll,B2,B3] = policyHerdAnalysis(data, timeLine, t, policy)
%
%Input: data, the m*n data matrix, in which m is the number of trading day,
%n is the number of stock
%           t, the time window that set after the policy
%           policy, the k*2 policy matrix, in which k is the number of
%           policy. The first column is the policy time point in date
%           number, and the last two columns are the corresponding policy.
%           timeLine, the time line corresponding to the data
%
%Output: CSAD , the CSAD index
%              B2,B3 the coefficient of return rate and the square of
%              return rate
%              B4 the coefficient of policy

%% calculate the return rate in time window
policyPoint = policy(:,1);
for i = 1 : length(policyPoint)
startDay = policyPoint(i);
endDay = policyPoint(i) + t;
% returnRate(i,:) = (data(timeLine == endDay) - data(timeLine == startDay,:))./data(timeLine == startDay,:);
windowsData = data(timeLine>=startDay&timeLine<=endDay,:);
returnRate = (windowsData(2:end,:) - windowsData(1:end-1,:))./windowsData(1:end-1,:);

%% construct analysis model
CSAD = zeros(size(returnRate,1),1);
absAvgReturn = zeros(size(returnRate,1),1);
squreAvgReturn = zeros(size(returnRate,1),1);

for j = 1 : size(returnRate,1)
returnRatePoint = returnRate(j,:);
returnRatePoint(isinf(returnRatePoint)) = [];
returnRatePoint(isnan(returnRatePoint)) = [];
avgRate = sum(returnRatePoint,2)/size(returnRatePoint,2);
CSAD(j,1) = sum(abs(returnRatePoint - avgRate))/size(returnRatePoint,2);
absAvgReturn(j,1) = abs(avgRate);
squreAvgReturn(j,1) = avgRate^2;
end

X = [ones( size(returnRate,1),1), absAvgReturn, squreAvgReturn];
b = regress(CSAD,X);
B2(i) = b(2);
B3(i) = b(3);
returnRateAll = windowsData(end,:) - windowsData(1,:)./windowsData(1,:);
returnRateAll(isinf(returnRateAll)) = [];
returnRateAll(isnan(returnRateAll)) = [];
avgRateAll = sum(returnRateAll,2)/size(returnRateAll,2);
CSADAll(i,1) = sum(abs(returnRateAll - avgRateAll))/size(returnRateAll,2);
end









