function Ruta= Path(robot,Goal,Inflation,ideal)
if nargin==4 && ideal
    Grid=binaryOccupancyMap(getOccupancy(robot.MapaReal),robot.MapaReal.Resolution);
    Res=robot.MapaReal.Resolution;
else
    Grid=binaryOccupancyMap(getOccupancy(robot.Mapa),robot.Mapa.Resolution);
    Res=robot.Mapa.Resolution;
    inflate(Grid,Inflation);
end

Start=[round((robot.Posicion(1)+robot.InitPos(1))*Res+1),round((robot.Posicion(2)+robot.InitPos(2))*Res+1)];

MAP = getOccupancy(Grid);
[ejey,ejex] = size(MAP);

%Number of Neighboors one wants to investigate from each cell. A larger
%number of nodes means that the path can be alligned in more directions. 
%Connecting_Distance=1-> Path can  be alligned along 8 different direction.
%Connecting_Distance=2-> Path can be alligned along 16 different direction.
%Connecting_Distance=3-> Path can be alligned along 32 different direction.
%Connecting_Distance=4-> Path can be alligned along 56 different direction.
%ETC......

Connecting_Distance=1; %Avoid to high values Connecting_Distances for reasonable runtimes. 

% Running PathFinder
OptimalPath=DIJSTRA(Start,Grid,Goal,Connecting_Distance);
% End. 

if size(OptimalPath,2)>1
 figure
 hold on
imagesc([0.5,ejex-0.5],[0.5,ejey-0.5],(MAP))
%imagesc((MAP))
set(gca,'Ydir','normal')
    colormap(flipud(gray));

hold on
plot(OptimalPath(1,2),OptimalPath(1,1),'o','color','k')
plot(OptimalPath(end,2),OptimalPath(end,1),'o','color','b')
plot(OptimalPath(:,2),OptimalPath(:,1),'r')
daspect([1,1,1])
legend('Goal','Start','Path')

else 
 figure
 hold on
 imagesc((MAP))
    set(gca,'Ydir','normal')
    colormap(flipud(gray));
    plot(Goal(:,2).*Grid.Resolution+1,Goal(:,1).*Grid.Resolution+1,'o','color','b')
    plot(Start(1),Start(2),'o','color','k')
    daspect([1,1,1])
    legend('Goal','Start')

end

Ruta = OptimalPath./Grid.Resolution;
end
