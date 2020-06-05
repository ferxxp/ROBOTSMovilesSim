function Robot = bug (Robot)

% Robot escanea
% encuentra pared -> gira a la derecha
% no encuentra pared -> avanza
sampleTime = Robot.TimeStep;
t = 0;
girar = 5;
pi = 3.14;
[distancia, angulo] =  escanearAlrededores(Robot);
while t < 10
    if girar < 4
       Robot=moverRobot(Robot,0,pi);
       girar = girar +1;
    elseif distancia(129,1)<0.8
       %gira
       Robot=moverRobot(Robot,0,pi);
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
