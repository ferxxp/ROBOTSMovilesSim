function Ruta= Path(robot,Goal,Inflation,Mode,graphics,ideal)

if nargin==5 && ideal
    Grid=binaryOccupancyMap(flip(getOccupancy(robot.MapaReal)),robot.MapaReal.Resolution);
    Res=robot.MapaReal.Resolution;
else
    Grid=binaryOccupancyMap(flip(getOccupancy(robot.Mapa)),robot.Mapa.Resolution);
    Res=robot.Mapa.Resolution;
    inflate(Grid,Inflation);
end

Start=[round((robot.Posicion(1)+robot.InitPos(1))*Res+1),round((robot.Posicion(2)+robot.InitPos(2))*Res+1)];

MAP = getOccupancy(Grid);
[ejey,ejex] = size(MAP);

Connecting_Distance=8;
%%SWITCH
switch Mode
   case 0
      OptimalPath=ASTARPATH(Start,Grid,Goal,Connecting_Distance,Inflation);
   case 1
      OptimalPath=DIJKSTRA(Start,Grid,Goal,Connecting_Distance,Inflation);
    ...
   otherwise
      disp error in use
end


if graphics 
    if size(OptimalPath,2)>1
        figure(19)
        hold on
        imagesc([0.5,ejex-0.5],[0.5,ejey-0.5],(MAP))
        set(gca,'Ydir','normal')
        colormap(flipud(gray));
        
        hold on
        plot(OptimalPath(1,2),OptimalPath(1,1),'o','color','k')
        plot(OptimalPath(end,2),OptimalPath(end,1),'o','color','b')
        plot(OptimalPath(:,2),OptimalPath(:,1),'r')
        daspect([1,1,1])
        legend('Goal','Start','Path')
        
    else
        figure(19)
        hold on
        imagesc((MAP))
        set(gca,'Ydir','normal')
        colormap(flipud(gray));
        plot(Goal(:,2).*Grid.Resolution+1,Goal(:,1).*Grid.Resolution+1,'o','color','b')
        plot(Start(1),Start(2),'o','color','k')
        daspect([1,1,1])
        legend('Goal','Start')
        
    end
end

Ruta = flip(flip(OptimalPath./Grid.Resolution,2));
end
