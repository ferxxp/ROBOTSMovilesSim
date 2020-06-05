function [robot] = Explorer(robot)
minC=0;
breaks=0;
Sight=ceil(2*robot.Mapa.Resolution);
[Height,Width]=size(getOccupancy(robot.Mapa));
Visited=zeros(Height,Width);




while (sum(sum(Visited))+(breaks*robot.Mapa.Resolution)^2)<(Height*Width)/1.5
    
    Values=conv2(Visited+getOccupancy(robot.Mapa),ones(Sight),'same');
    
    [GX,GY]=find(Values<=(min(min(Values))+minC));
    indices = randperm(length(GX));
    
    indices = indices(1:min([100,size(indices)]));
    
    GOALS=[GX(indices)/robot.Mapa.Resolution,GY(indices)/robot.Mapa.Resolution];
    disp(GOALS)
    path=Path(robot,GOALS,0.2,1,robot.GraphicsOn,0);
    [Psize,~]=size(path);
    goal=path(Psize,:);
    broken=true;
    while (abs(norm(robot.Posicion(1:2)+robot.InitPos(1:2)-goal,2)))>0.3 && broken
        
        if path~=inf
            minC=0;
            [robot,path]=moverRobotA2(robot,path);
            [distancia, angulo] =  escanearAlrededores(robot);
            Visited=AddVisited(robot,Visited,Sight);
            robot=mostrarScan(robot,distancia,angulo);
            robot=unirEscaneo(robot,distancia,angulo);
            robot=updatePlotRobot(robot);
            path=Path(robot,goal,0.2,1,robot.GraphicsOn,0);
        elseif checkCollided(robot)
            robot=moverRobot(robot,2,0);
            disp('ROB obstructed')
            robot=updatePlotRobot(robot);
            Visited=AddVisited(robot,Visited,Sight);
            path=Path(robot,goal,0.2,1,robot.GraphicsOn,0);
        else
            minC=minC+1;
            broken=false;
        end
    end
    if path==inf
        breaks=breaks+1;
        minC=minC+1;
        disp('No path so checking with C=')
        disp(minC)
    end
    beep
    figure(50)
    mesh(Visited)
    view(0,90)
    axis equal
    disp('LO Que buscas:')
    disp(sum(sum(Visited))+(breaks*robot.Mapa.Resolution)^2)
    disp((Height*Width)/1.5)
end
robot=updatePlotRobot(robot,true);
disp ('done')