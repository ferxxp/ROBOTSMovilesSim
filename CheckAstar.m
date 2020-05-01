
%%
rob=Robot;

path=Path(rob,[4,4],0.2,false)

if path~=inf
    while abs(sum(rob.PosReal(1:2)-path(1,:)))>0.3
        rob=moverRobotA(rob,path);
        [distancia, angulo] =  escanearAlrededores(rob);
        checkCollided(Robot)
        if true
            mostrarScan(rob,distancia,angulo)
        end
        unirEscaneo(rob,distancia,angulo)
        if true
            updatePlotRobot(rob);
        end
     end
end

path=Path(Robot,[3,4],0.1,false)
if path~=inf
    while abs(sum(rob.PosReal(1:2)-path(1,:)))>0.3
        rob=moverRobotA(rob,path);
        [distancia, angulo] =  escanearAlrededores(rob);
        checkCollided(Robot)
        if true
            mostrarScan(rob,distancia,angulo)
        end
        unirEscaneo(rob,distancia,angulo)
        if true
            updatePlotRobot(rob);
        end
     end
end
