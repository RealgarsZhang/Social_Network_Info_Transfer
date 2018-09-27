function [ cleaned_data ] = clean_data( data )
SAMPLE_SIZE = 95;
is_qualified = ones(1,95);

for k=1:SAMPLE_SIZE
    instance = data{k};
    x=regexp(instance, '.*?(\d+(\.\d+)*)', 'tokens' );
    if ( isempty(x{1}) || isempty(x{2}) || isempty(x{3}) )
        is_qualified(k)=0;
        continue;
    end
end

size_data = sum(is_qualified);
cleaned_data = zeros(size_data,3);

index=1;%current index of cleaned_data
for k=1:SAMPLE_SIZE
    if is_qualified(k)==1
        x=regexp(data{k}, '.*?(\d+(\.\d+)*)', 'tokens' );
        if size(x{1},2) == 1 
            cleaned_data(index,1) = str2num(x{1}{1}{1});
        end
        if size(x{1},2) == 2
            cleaned_data(index,1) = ( str2num(x{1}{1}{1})+str2num(x{1}{2}{1}) )/2;
        end
        
        if size(x{2},2) == 1 
            cleaned_data(index,2) = str2num(x{2}{1}{1});
        end
        if size(x{2},2) == 2
            cleaned_data(index,2) = ( str2num(x{2}{1}{1})+str2num(x{2}{2}{1}) )/2;
        end
        
        if size(x{3},2) == 1
            cleaned_data(index,3) = str2num(x{3}{1}{1});
            if str2num(x{3}{1}{1})==2 
                cleaned_data(index,3) = 120;
            end
        elseif size(x{3},2) == 2
            first = str2num(x{3}{1}{1});
            second= str2num(x{3}{2}{1});
            if second == 1
                cleaned_data(index,3) = 50;
            elseif second == 2
                cleaned_data(index,3) = 90;
            else
                cleaned_data(index,3) = (first+second)/2;
            end   
        end
        index = index+1;
    end
end

            
        
end




