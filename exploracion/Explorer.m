function [robot] = Explorer(robot)
Sight=ceil(2*robot.Mapa.Resolution);
[Height,Width]=size(getOccupancy(robot.Mapa));
Visited=zeros(Height,Width);


while sum(sum(Visited))<Height*Width/2
    Values=conv2(Visited+getOccupancy(robot.Mapa),ones(Sight),'same');

    [GX,GY]=find(Values==min(min(Values)));
    indices = randperm(length(GX));

    indices = indices(1:10);
    GOALS=[GX(indices)/robot.Mapa.Resolution,GY(indices)/robot.Mapa.Resolution];
   
    path=Path(robot,GOALS,0.2,false);
    [Psize,~]=size(path);
    goal=path(Psize,:);
     
    while (abs(sum(robot.Posicion(1:2)+robot.InitPos(1:2)-goal,2)))>0.3
        
        if path~=inf
            [robot,path]=moverRobotA2(robot,path);
            [distancia, angulo] =  escanearAlrededores(robot);
            Visited=AddVisited(robot,Visited,Sight);
            
            if true
                robot=mostrarScan(robot,distancia,angulo);
            end
            unirEscaneo(robot,distancia,angulo);
            if true
                robot=updatePlotRobot(robot);
            end
            path=Path(robot,goal,0.2,false);
        else
            robot=moverRobot(robot,2,0);
            disp('No more places to explore')
            Visited=AddVisited(robot,Visited,Sight);
            path=Path(robot,goal,0.2,false);
        end
    end
    figure;
    surf(Visited)
    shading interp
    colormap colorcube
    daspect([1,1,1])
    view(0,90)
end
disp ('done')