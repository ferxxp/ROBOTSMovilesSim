function OptimalPath=DIJKSTRA(Start,MAPB,Goal,Connecting_Distance,inflation)

OptimalPath=inf;

if Goal==inf
    SGoal=0;
else
    [SGoal,~]=size(Goal);
end

MAP = (int8(getOccupancy(MAPB))); 
[Height,Width]=size(MAP);

for a = 1:SGoal
    DestinoY=Goal(a,1);
    DestinoX=Goal(a,2);
    MAP(round(DestinoX*MAPB.Resolution)+1,round(DestinoY*MAPB.Resolution)+1)=5;
end
Sight=ceil(inflation*MAPB.Resolution);
MAP((max([Start(2)-Sight,1]):min([Start(2)+Sight,Height])),max([Start(1)-Sight,1]):min([Start(1)+Sight,Width]))=0;

ParentMatrix=zeros(Height,Width,2);
ConectionNeighbours=[1,0;0,1;-1,0;0,-1;1,1;1,-1;-1,-1;-1,1];%[1,1;1,0;1,-1;0,-1;-1,-1;-1,0;-1,1;0,1];
QueueNodes=zeros(Height*Width,2);
QueueNodes(1,:)=[Start(2),Start(1)];
Queueindex=1;
Goal=0;
for a=1:Height*Width
    if QueueNodes(a,1)==0 || QueueNodes(a,2)==0 || Goal
        disp('No more candidates')
        break
    else
        for b =1:8
            MAP(QueueNodes(a,1),QueueNodes(a,2))=2;
            if  (QueueNodes(a,1)+ConectionNeighbours(b,1)>=Height || ...
                    QueueNodes(a,1)+ConectionNeighbours(b,1)<=0 || ...
                    QueueNodes(a,2)+ConectionNeighbours(b,2)>=Width || ...
                    QueueNodes(a,2)+ConectionNeighbours(b,2)<=0)
                continue
            elseif MAP(QueueNodes(a,1)+ConectionNeighbours(b,1),QueueNodes(a,2)+ConectionNeighbours(b,2))==5
                disp('Goal')
                Goal=1;
                ParentMatrix(QueueNodes(a,1)+ConectionNeighbours(b,1),QueueNodes(a,2)+ConectionNeighbours(b,2),:)=QueueNodes(a,:);
                OptimalPath=[QueueNodes(a,1)+ConectionNeighbours(b,1),QueueNodes(a,2)+ConectionNeighbours(b,2)];
                break
            
            elseif MAP(QueueNodes(a,1)+ConectionNeighbours(b,1),QueueNodes(a,2)+ConectionNeighbours(b,2))==0

                ParentMatrix(QueueNodes(a,1)+ConectionNeighbours(b,1),QueueNodes(a,2)+ConectionNeighbours(b,2),:)=QueueNodes(a,:);
                Queueindex=Queueindex+1;
                QueueNodes(Queueindex,:)=[QueueNodes(a,1)+ConectionNeighbours(b,1),QueueNodes(a,2)+ConectionNeighbours(b,2)];
                MAP(QueueNodes(a,1)+ConectionNeighbours(b,1),QueueNodes(a,2)+ConectionNeighbours(b,2))=3;
                
            end
        end
    end
    
end
if Goal
    i=1;
    while min(ParentMatrix(OptimalPath(i,1),OptimalPath(i,2),:)~=[0,0])
        i=i+1;
        OptimalPath(i,1)=ParentMatrix(OptimalPath(i-1,1),OptimalPath(i-1,2),1);
        OptimalPath(i,2)=ParentMatrix(OptimalPath(i-1,1),OptimalPath(i-1,2),2);
    end


    
end
%     figure (20)
%     mesh(MAP)
%     shading interp
%     colormap colorcube
%     view(0,90);

    
