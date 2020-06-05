function Robot = bug_semi(Robot)

% Robot escanea
% encuentra pared -> busca el lado con obstáculos más lejanos y gira
% no encuentra pared -> avanza
sampleTime = Robot.TimeStep;
t = 0;
girar = 5;
pi = 3.14;
vel_g = 0;
[distancia, angulo] =  escanearAlrededores(Robot);
while t < 10
    if girar < 4
       Robot=moverRobot(Robot,0,vel_g);
       girar = girar +1;
    elseif distancia(129,1)<0.8
       %comprueba hacia que lado hay un camino más libre de obstáculos
       if distancia(65,1) < distancia(194,1)
            vel_g = pi;
            Robot=moverRobot(Robot,0,vel_g);
       else 
            vel_g = -pi;
            Robot=moverRobot(Robot,0,vel_g);
       end
       girar = 0;
    else
        girar = 5;
        %avanza
        Robot=moverRobot(Robot,1,0);
    end
    %guarda en mapa
    t = t + sampleTime;
    [distancia, angulo] =  escanearAlrededores(Robot);
    Robot = mostrarScan(Robot,distancia,angulo)
    Robot = unirEscaneo(Robot,distancia,angulo)
    Robot = updatePlotRobot(Robot);
    disp(t);
end
