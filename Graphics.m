
%%
global Robot
Robot=updatePlotRobot(Robot,true)
while true
    figure(Robot.figMapa);
    p=drawpoint();
    goal=p.Position(1:2);
    disp(goal)
        while (abs(norm(Robot.Posicion(1:2)+Robot.InitPos(1:2)-goal,2)))>0.3 
                minC=0;
                [Robot,path]=moverRobotA2(Robot,goal);
                [distancia, angulo] =  escanearAlrededores(Robot);
                Robot=mostrarScan(Robot,distancia,angulo);
                Robot=unirEscaneo(Robot,distancia,angulo);
                Robot=updatePlotRobot(Robot);
        end
        disp('End reached')
        Robot=updatePlotRobot(Robot,true);
end