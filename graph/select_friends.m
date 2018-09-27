function [ selected_friends ] = select_friends( deg, num_friends )

selected_friends = ones(0,1);
for k = 1:num_friends
    prob = deg/sum(deg);
    target_interval = cumsum(prob);
    index = find( (target_interval>rand()) & (deg>0) );% actually deg>0 not needed    
    index = min(index);   
    selected_friends(end+1) = index;
    deg(index) = 0;
end
    
    


end

