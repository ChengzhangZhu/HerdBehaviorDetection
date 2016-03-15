%%pre-process data

%% Random Selected Data
filename = '../Data/Random Selected Data/data(1-500)-date(2014-11-12-2014-11-22)';
% filename = '../Data/Random Selected Data/data(1-500)-date(2015-1-20-2015-1-29)';
% filename = '../Data/Random Selected Data/data(1-500)-date(2015-2-7-2015-2-17)';
% filename = '../Data/Random Selected Data/data(1-500)-date(2015-3-8-2015-3-18)';
% filename = '../Data/Random Selected Data/data(1-500)-date(2015-4-7-2015-4-17)';

%% Special Event Data
% filename = '../Data/Special Event Data/data(1-500)-date(2014-12-18-2014-12-28)';
% filename = '../Data/Special Event Data/data(1-500)-date(2015-2-27-2015-3-9)';
% filename = '../Data/Special Event Data/data(1-500)-date(2015-5-8-2015-5-18)';
% filename = '../Data/Special Event Data/data(1-500)-date(2015-05-27-2015-06-05)';
% filename = '../Data/Special Event Data/data(1-500)-date(2015-1-30-2015-2-9)';



%% Load Data
data = csvread([filename,'.csv'],1,1);
load('../Data/label.mat');

%% clear empty data
data(sum(data,2)==0 , :) = [];
label(:,sum(data,1)==0) = [];
data(:,sum(data,1)==0) = [];

%%save data
save([filename,'.mat'],'data','label');
