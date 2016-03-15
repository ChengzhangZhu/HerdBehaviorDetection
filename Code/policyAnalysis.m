function [CSAD,B2,B3,B4] = policyAnalysis(data, timeLine, t, policy)
%Usage: [CSAD,B2,B3,B4] = policyAnalysis(data, timeLine, t, policy)
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
returnRate = zeros(length(policyPoint),size(data,2));
for i = 1 : length(policyPoint)
startDay = policyPoint(i);
endDay = policyPoint(i) + t;
returnRate(i,:) = (data(timeLine == endDay) - data(timeLine == startDay,:))./data(timeLine == startDay,:);
end

%% construct analysis model
CSAD = zeros(length(policyPoint),1);
absAvgReturn = zeros(length(policyPoint),1);
squreAvgReturn = zeros(length(policyPoint),1);

for i = 1 : length(policyPoint)
returnRatePoint = returnRate(i,:);
returnRatePoint(isinf(returnRatePoint)) = [];
avgRate = sum(returnRatePoint,2)/size(returnRatePoint,2);
CSAD(i,1) = sum(abs(returnRatePoint - avgRate))/size(returnRatePoint,2);
absAvgReturn(i,1) = abs(avgRate);
squreAvgReturn(i,1) = avgRate^2;
end

X = [ones(length(policyPoint),1), absAvgReturn, squreAvgReturn, policy(:,3)];
b = regress(CSAD,X);
B2 = b(2);
B3 = b(3);
B4 = b(4);
% B5 = b(5);









