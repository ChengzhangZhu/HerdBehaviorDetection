function [CSADAll,B2,B3] = herdAfterPolicy(t)
%Usage: [CSADAll,B2,B3] = herdAfterPolicy(t)
%
%Input:
%           t, the time window that set after the policy
%Output: CSAD , the CSAD index
%              B2,B3 the coefficient of return rate and the square of
%              return rate


%% load data, defualt SH380 data, which can be changed to any other dataset
load('../Data/SH380/dataCollection.mat');
load('../Data/SH380/label.mat');
load('../Data/SH380/policy.mat');

%% analysis the result
[CSADAll,B2,B3] = policyHerdAnalysis(dataMatrix, timeLine, t, policy);