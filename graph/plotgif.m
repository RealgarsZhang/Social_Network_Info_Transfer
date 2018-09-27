h = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'graphAnimate.gif';
% for n = 1:0.5:5
%     % Draw plot for y = x.^n
%     x = 0:0.01:1;
%     y = x.^n;
%     plot(x,y) 
%     drawnow 
%       % Capture the plot as an image 
%       frame = getframe(h); 
%       im = frame2im(frame); 
%       [imind,cm] = rgb2ind(im,256); 
%       % Write to the GIF File 
%       if n == 1 
%           imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
%       else 
%           imwrite(imind,cm,filename,'gif','WriteMode','append'); 
%       end 
% end
  
% G=addnode(G,1);
% G=addedge(G,(N+1)*ones(1,N),1:N,ones(1,N));
% N=N+1;

is_colored = zeros(N,1);
num_colored_neighbour = zeros(N,1);
colored_nodes = ones(0,1);%empty

STARTING_NODE = 1;
lambda = 0.0071;
MARKER_NORMALIZER = 2;

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
    node_to_color = frontier_nodes(min_index);
    is_colored(node_to_color) = 1;
    colored_nodes(end+1) = node_to_color;
    num_colored_neighbour( neighbors(G,node_to_color) ) = num_colored_neighbour( neighbors(G,node_to_color) ) +1;
    
    H=plot(G,'MarkerSize',degree(G)/MARKER_NORMALIZER);%,'LineStyle','none');
    highlight(H, colored_nodes,'NodeColor','r');
    title(['t = ',num2str(t),' minutes']);
    set(gcf,'Position',[600,600,600,600]);
    %pause(0.15);
    drawnow 
      % Capture the plot as an image 
      frame = getframe(h); 
      im = frame2im(frame); 
      [imind,cm] = rgb2ind(im,256); 
      % Write to the GIF File 
      if looper == 1 
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
      else 
          imwrite(imind,cm,filename,'gif','WriteMode','append'); 
      end 
      looper = looper+1;

end