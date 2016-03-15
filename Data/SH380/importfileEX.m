name = dir('*.txt');
starDate = datenum(2001,1,2);
endDate = datenum(2015,6,18);
dataMatrix = zeros(endDate - starDate + 1,length(name));
for i = 1 : length(name)
    stockname = name(i).name;
    stockname(3) = [];
    stockname(end-3:end) = [];
    %     eval([stockname,' = importfile(name(i).name);']);
    stock = importfile(name(i).name);
    %     starDate = datenum(2013,3,2);
    %     endDate = datenum(2013,3,12);
    if isempty(stock)
        continue;
    end
    %     stockPeriod = stock(stock(:,1)>=starDate&stock(:,1)<=endDate,2);
    for j = starDate : endDate
        if ~isempty(find(stock(:,1)==j, 1))
            dataMatrix(j-starDate + 1,i) = stock(stock(:,1)==j,2);
        else
            if j ~= starDate
                dataMatrix(j-starDate + 1,i) = dataMatrix(j-starDate + 1 -1,i);
            else
                for k = starDate:-1:stock(1,1)
                    if ~isempty(find(stock(:,1)==k,1))
                        dataMatrix(j-starDate + 1,i) = stock(stock(:,1)==k,2);
                        break;
                    end
                end
            end
        end
    end
end
timeLine = starDate:endDate;
save('dataCollection','dataMatrix','timeLine');