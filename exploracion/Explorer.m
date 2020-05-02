function [robot] = Explorer(robot)
Sight=2;
[Height,Width]=size(getOccupancy(robot.Mapa));
Visited=zeros(Height,Width);
SightMatrix=ones((Sight*2+1));

X=3;Y=3;
Visited(X-Sight:X+Sight,Y-Sight:Y+Sight)=SightMatrix;

Values=conv2(Visited+getOccupancy(robot.Mapa),ones(3),'same');

[GX,GY]=find(Values==min(min(Values)));
indices = randperm(length(GX));

indices = indices(1:10);

while sum(sum(SightMatrix))<Height*Width/10
    
    path=Path(robot,[GX(indices)/robot.Mapa.Resolution,GY(indices)/robot.Mapa.Resolution],0.2,false)
    
    if path~=inf  
        [robot,path]=moverRobotA2(robot,path);
        [distancia, angulo] =  escanearAlrededores(robot);
        if true
            robot=mostrarScan(robot,distancia,angulo);
        end
            unirEscaneo(robot,distancia,angulo);
        if true
            robot=updatePlotRobot(robot);
        end
    end
end
disp ('done')