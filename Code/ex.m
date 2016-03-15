% load('clearData.mat')
% filename = '../Data/Random Selected Data/data(1-500)-date(2014-11-12-2014-11-22)';
% filename = '../Data/Random Selected Data/data(1-500)-date(2015-1-20-2015-1-29)'; 
% filename = '../Data/Random Selected Data/data(1-500)-date(2015-2-7-2015-2-17)';
% filename = '../Data/Random Selected Data/data(1-500)-date(2015-3-8-2015-3-18)';
% filename = '../Data/Random Selected Data/data(1-500)-date(2015-4-7-2015-4-17)';

% filename = '../Data/Special Event Data/data(1-500)-date(2014-12-18-2014-12-28)';
%  filename = '../Data/Special Event Data/data(1-500)-date(2015-2-27-2015-3-9)';
%  filename = '../Data/Special Event Data/data(1-500)-date(2015-5-8-2015-5-18)';
 filename = '../Data/Special Event Data/data(1-500)-date(2015-05-27-2015-06-05)';
% filename = '../Data/Special Event Data/data(1-500)-date(2015-1-30-2015-2-9)';

load([filename,'.mat']);

%% select time periods
% set parameters
period = 5;
beginDate = size(data,1) - period + 1;
% select data
selectData = data(beginDate:end,:);
selectLabel = label;
% check empty data
emptyIndex = find(sum(selectData,1)==0);
selectData(:,emptyIndex) = [];
selectLabel(:,emptyIndex) = [];

%% calculate distance between stock return rates
dist = 1 - corr(selectData);
dist = matrix2Dist(dist);
% %% Using MIC to calculate distance;
% selectData = selectData';
% dist = zeros(size(selectData,1),size(selectData,1));
% for i = 1 : size(selectData,1) - 1
%     for j = i + 1 : size(selectData,1)
%         mic = mine(selectData(i,:),selectData(j,:));
%         dist(i,j) = mic.mic;
%     end
% end
% dist = dist + dist' + eye(size(selectData,1));
% dist = 1 - dist;
% dist = matrix2Dist(dist);

%% obtain clustering result
[centerIndex,halo,classNUM] = cluster_dp(dist);

%% display results
for i = 1 : classNUM
    fprintf('The group %d has the following member:\n', i);
    selectLabel(halo==i)
    fprintf('The group %d center is:\n', i);
    selectLabel(centerIndex(i))
end
% 
%% save group information in every iteration
for i = 1 : classNUM
    groupData = selectLabel(halo==i);
    fid1=['result','.txt'];
    c=fopen(fid1,'a');    
    for j = 1 : length(groupData)
         fprintf(c,'%d ,', groupData(j));        %%%q为你要写入的数据，“'%f”为数据格式
    end
    fprintf(c,'\n');
    fclose(c);
end
