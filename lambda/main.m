filename = 'raw_data.csv';
fid = fopen(filename);
raw_data = textscan(fid,'%s','delimiter',',');
SAMPLE_SIZE = 95;
NUM_ITEMS = 24;
raw_data = raw_data{1};
data=cell(SAMPLE_SIZE,3);
% we care 15,16,17th item
for k=1:SAMPLE_SIZE
    for kk = 1:3
        coordinate = kk+14+(k-1)*NUM_ITEMS;
        data{k}{kk} = raw_data{coordinate};
    end
end

% is_qualified = ones(SAMPLE_SIZE,1);
% for k=1:SAMPLE_SIZE
%     instance = data{k};
%     extracted_num=regexp(instance, '.*?(\d+(\.\d+)*)', 'tokens' );
%     if ( isempty(extracted_num{1}) || isempty(extracted_num{2}) || isempty(extracted_num{3}) )
%         is_qualified(k)=0;
%         continue;
%     end
% end

cleaned_data = clean_data(data);
t = cleaned_data(:,1)+cleaned_data(:,2);
t=t/2;
D = t'* cleaned_data(:,3);
N = size(cleaned_data,1);
lambda = N/D;

fclose(fid);