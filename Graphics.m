function Graphics
%%
global Robot
Robot=updatePlotRobot(Robot,true)
%%Seleccionamos el punto a desplazarse.
    disp("Seleccione un punto en el mapa del robot.")
    figure(Robot.figMapa);
    p=drawpoint();
    goal=p.Position(1:2);
    disp(goal)
    %comprobamos que no haya llegado
        while (abs(norm(Robot.Posicion(1:2)+Robot.InitPos(1:2)-goal,2)))>0.3 
                [Robot,~]=moverRobotA2(Robot,goal);
                [distancia, angulo] =  escanearAlrededores(Robot);
                Robot=mostrarScan(Robot,distancia,angulo);
                Robot=unirEscaneo(Robot,distancia,angulo);
                Robot=updatePlotRobot(Robot);
        end
        disp('End reached')
        Robot=updatePlotRobot(Robot,true);