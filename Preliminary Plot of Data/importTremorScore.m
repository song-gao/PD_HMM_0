function [epoch,timestamp,Value] = importTremorScore(filename, startRow, endRow)
%IMPORTFILE ???????????????????
%   [EPOCH,TIMESTAMP,VALUE] = importTremorScore(FILENAME) 
%
%   [EPOCH,TIMESTAMP,VALUE] = importTremorScore(FILENAME, STARTROW, ENDROW) 
%
% Example:
%   [epoch,timestamp,Value] = importTremorScore('Tremor_Score_5539_1712016_Sample_parsed.csv',2, 68656);
%


%% ??????
delimiter = ',';
if nargin<=2
    startRow = 2;
    endRow = inf;
end

%% ???????????:
%   ?1: ???? (%f)
%	?2: ?? (%s)
%   ?3: ???? (%f)
% ?????????? TEXTSCAN ???
formatSpec = '%f%s%f%[^\n\r]';

%% ???????
fileID = fopen(filename,'r');

%% ?????????????
% ??????????????????????????????????????????????
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% ???????
fclose(fileID);

%% ???????????????
% ????????????????????????????????????????????????????????????????????????

%% ??????????????
epoch = dataArray{:, 1};
timestamp = dataArray{:, 2};
Value = dataArray{:, 3};


