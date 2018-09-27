clc;clear all;close all;
G = graph([0 1;1 0]);

m0 = 15;
m  = m0;

N = 50; %Num people

for k = 3:m0
    deg = degree(G);
    num_friends =  ceil( rand()*(k-1) ) ;
    friends = select_friends(deg,num_friends);
    G = addnode(G,1);
    G = addedge(G,k*ones(num_friends,1)',friends',ones(num_friends,1));
end

for k = m0+1:N
    deg = degree(G);
    num_friends = m0 ;
    friends = select_friends(deg,num_friends);
    G = addnode(G,1);
    G = addedge(G,k*ones(num_friends,1)',friends',ones(num_friends,1));
end


%graph can be plotted here


    
        
          
   

    
    