G=addnode(G,1);
%random selection
CHOOSING_RATE = 0.60;
num_chosen = floor(N*CHOOSING_RATE);
nodes_chosen = randperm(N,num_chosen);
G=addedge(G,(N+1)*ones(1,num_chosen),nodes_chosen,ones(1,num_chosen));


N=N+1;



STARTING_NODE = N;%modify here everytime you add/remove platform
lambda = 0.0071;
MARKER_NORMALIZER = 2;
NUM_TRIALS = 30;


resultVec = zeros(NUM_TRIALS,N);
for k = 1:NUM_TRIALS
    is_colored = zeros(N,1);
    num_colored_neighbour = zeros(N,1);
    colored_nodes = ones(0,1);%empty
    colored_nodes(end+1) = STARTING_NODE;% starting node
    is_colored(STARTING_NODE)= 1;
    num_colored_neighbour( neighbors(G,STARTING_NODE) ) = num_colored_neighbour( neighbors(G,STARTING_NODE) ) +1;

    t_vec = zeros(1,N);
    looper = 1;
    t = 0;
    while (~isempty( find(1-is_colored, 1) ))
        frontier_nodes = find( (num_colored_neighbour>0)&(~is_colored) );
        t_vector = 1./(num_colored_neighbour(frontier_nodes)*lambda);
        t_vector = exprnd(t_vector);
        [delta_t,min_index]=min(t_vector);
        
        t = t+delta_t;
        t_vec(looper) = t;
        looper = looper+1;
        node_to_color = frontier_nodes(min_index);
        is_colored(node_to_color) = 1;
        colored_nodes(end+1) = node_to_color;
        num_colored_neighbour( neighbors(G,node_to_color) ) = num_colored_neighbour( neighbors(G,node_to_color) ) +1;
        
        %     H=plot(G,'MarkerSize',degree(G)/MARKER_NORMALIZER);%,'LineStyle','none');
        %     highlight(H, colored_nodes,'NodeColor','r');
        %     title(['t = ',num2str(t),' minutes']);
        %     set(gcf,'Position',[1000,1000,1000,1000]);
        %     pause(0.15);
    end
    resultVec(k,:) = t_vec;
end
vec_platform=mean(resultVec);


% load vec_nonplatform.mat;
% load vec_platform100.mat;
% load vec_platform70.mat;
% load vec_platform50.mat;
% load vec_platform30.mat;
% plot(vec_nonplatform(1:end-1),1:1199,'LineWidth',3)
% hold on
% plot(vec_platform100(2:end-1),1:1199,'LineWidth',3)
% plot(vec_platform70(2:end-1),1:1199,'LineWidth',3)
% plot(vec_platform50(2:end-1),1:1199,'LineWidth',3)
% plot(vec_platform30(2:end-1),1:1199,'LineWidth',3)
% 
% legend('Without platform. ','100% connection','70% connection','50% connection','30% connection');
% xlabel('Time in min')
% ylabel('Number of vertices informed')
% line([15,15],[0,1200],'LineStyle','--')
% 
% ylim=find(vec_nonplatform>15,1);
% line([0,15],[ylim,ylim],'LineStyle','--');
% 
% ylim=find(vec_platform100>15,1);
% line([0,15],[ylim,ylim],'LineStyle','--');
% 
% ylim=find(vec_platform70>15,1);
% line([0,15],[ylim,ylim],'LineStyle','--');
% 
% ylim=find(vec_platform50>15,1);
% line([0,15],[ylim,ylim],'LineStyle','--');
% 
% ylim=find(vec_platform30>15,1);
% line([0,15],[ylim,ylim],'LineStyle','--');
