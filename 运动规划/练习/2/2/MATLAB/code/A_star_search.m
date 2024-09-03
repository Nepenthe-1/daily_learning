function path = A_star_search(map,MAX_X,MAX_Y)
%%

%This part is about map/obstacle/and other settings
    %pre-process the grid map, add offset
    size_map = size(map,1);
    Y_offset = 0;
    X_offset = 0;
    
    %Define the 2D grid map array.
    %Obstacle=-1, Target = 0, Start=1
    MAP=2*(ones(MAX_X,MAX_Y));
    
    %Initialize MAP with location of the target
    xval=floor(map(size_map, 1)) + X_offset;
    yval=floor(map(size_map, 2)) + Y_offset;
    xTarget=xval;
    yTarget=yval;
    MAP(xval,yval)=0;
    
    %Initialize MAP with location of the obstacle
    for i = 2: size_map-1
        xval=floor(map(i, 1)) + X_offset;
        yval=floor(map(i, 2)) + Y_offset;
        MAP(xval,yval)=-1;
    end 
    
    %Initialize MAP with location of the start point
    xval=floor(map(1, 1)) + X_offset;
    yval=floor(map(1, 2)) + Y_offset;
    xStart=xval;
    yStart=yval;
    MAP(xval,yval)=1;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %LISTS USED FOR ALGORITHM  用于算法的列表
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %OPEN LIST STRUCTURE
    %--------------------------------------------------------------------------
    %IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
    %--------------------------------------------------------------------------
    OPEN=[];
    %CLOSED LIST STRUCTURE
    %--------------
    %X val | Y val |
    %--------------
    % CLOSED=zeros(MAX_VAL,2);
    CLOSED=[];

    %Put all obstacles on the Closed list
    k=1;%Dummy counter
    for i=1:MAX_X
        for j=1:MAX_Y
            if(MAP(i,j) == -1)
                CLOSED(k,1)=i;
                CLOSED(k,2)=j;
                k=k+1;
            end
        end
    end
    CLOSED_COUNT=size(CLOSED,1);
    %set the starting node as the first node
    xNode=xval;
    yNode=yval;
    OPEN_COUNT=1;
    goal_distance=distance(xNode,yNode,xTarget,yTarget);
    path_cost=0;
    OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,xNode,yNode,goal_distance,path_cost,goal_distance);
    OPEN(OPEN_COUNT,1)=0;
    CLOSED_COUNT=CLOSED_COUNT+1;
    CLOSED(CLOSED_COUNT,1)=xNode;
    CLOSED(CLOSED_COUNT,2)=yNode;
    NoPath=1;

%%
%This part is your homework
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    while(1) %you have to dicide the Conditions for while loop exit 
        i_min=min_fn(OPEN,OPEN_COUNT,xTarget,yTarget);
       

        if i_min ==-1
            i_min=1;
            flag_i=1;
        end

        if i_min==-1 && flag_i~=1
            disp('FALSE')
            break
        end
        
        flag_i=0;

        
        if (OPEN(i_min,2)==xTarget && OPEN(i_min,3)==yTarget)
            disp('TRUE')
            OPEN(i_min,1)=0;
            break
        end

        

    
      
        OPEN(i_min,1)=0;
        exp_array=expand_array(OPEN(i_min,2),OPEN(i_min,3),OPEN(i_min,7),xTarget,yTarget,CLOSED,MAX_X,MAX_Y);
    
        for jdex=1:1:size(exp_array,1)
            OPEN_COUNT=OPEN_COUNT+1;
            CLOSED_COUNT=CLOSED_COUNT+1;
            OPEN(OPEN_COUNT,:)=insert_open(exp_array(jdex,1),exp_array(jdex,2),OPEN(i_min,2),OPEN(i_min,3),exp_array(jdex,3),exp_array(jdex,4),exp_array(jdex,5));
            CLOSED(CLOSED_COUNT,1)=exp_array(jdex,1);
            CLOSED(CLOSED_COUNT,2)=exp_array(jdex,2);
        end

    

     %
     %finish the while loop
     %
     
    end %End of While Loop
    idex_i=1;
    for idex=1:1:size(OPEN,1)
        if OPEN(idex,1)==0
            openlist(idex_i,:)=OPEN(idex,:);
            idex_i=idex_i+1;
        end
    end

    ddex=1;
    path(ddex,1)=openlist(end,2);
    path(ddex,2)=openlist(end,3);
    ddex=ddex+1;

    if (openlist(end,2) == xTarget)&& (openlist(end,3)==yTarget)
        parent_x=openlist(node_index(openlist,openlist(end,2),openlist(end,3)),4);
        parent_y=openlist(node_index(openlist,openlist(end,2),openlist(end,3)),5);

        while (parent_x~=xStart)&&(parent_y~=yStart)
                path(ddex,1)=parent_x;
                path(ddex,2)=parent_y;

                inode=node_index(openlist,parent_x,parent_y);
                parent_x=openlist(inode,4);
                parent_y=openlist(inode,5);
                ddex=ddex+1;
        end

    end

    path(ddex,1)=xStart;
    path(ddex,2)=yStart;



    
    %Once algorithm has run The optimal path is generated by starting of at the
    %last node(if it is the target node) and then identifying its parent node
    %until it reaches the start node.This is the optimal path
    
    %
    %How to get the optimal path after A_star search?
    %please finish it
    %
    
   
end
