function esquinas (Robot)

% Robot escanea
% encuentra pared -> mira si es una esquina
% si es una esquina gira a donde no hay pared
% si no es una esquina gira aleatorio
% no encuentra pared -> avanza
sampleTime = Robot.TimeStep;
t = 0;
girar = 5;
%pi = 3.14;
[distancia, angulo] =  escanearAlrededores(Robot);
esquinas =0;
lista = zeros(5,3);
while t < 100 && esquinas < 5
    
    %Comprueba si esta en una esquina
    %si es una esquina gira hacia donde no tiene pared
    %si no es esquina gira a donde tenga menos distancia
    %sino avanza
    
    if girar < 4
       Robot=moverRobot(Robot,0,pi);
       girar = girar +1;
    elseif distancia(129,1) < 0.8
        if distancia (65,1) < 1.2
            %Es una esquina
            %giro a la izquierda
            pi = pi * 1;
            Robot=moverRobot(Robot,0,pi);
            girar = 0;
            [nueva] = vista(Robot,lista);
            if nueva
                esquinas = esquinas +1;
                lista(esquinas,:)= Robot.Posicion;
            end
        elseif distancia (194,1) < 1.2
            %es otra esquina
            %giro a la derecha
            pi = pi * -1;
            Robot=moverRobot(Robot,0,pi);
            girar = 0;
            [nueva] = vista(Robot,lista);
            if nueva
                esquinas = esquinas +1;
                lista(esquinas,:)= Robot.Posicion;
            end
        elseif distancia (65,1) > distancia (194,1)
            %giro a la derecha que hay mas distancia
            pi = pi * -1;
            Robot=moverRobot(Robot,0,pi);
            girar = 0;
        else
            %giro a la izquierda que hay mas distancia
            pi = pi * 1;
            Robot=moverRobot(Robot,0,pi);
            girar = 0;
        end
    else
        %avanza
        girar = 5;
        Robot=moverRobot(Robot,1,0);
        pi = 3.14;
    end
    
    
    %guarda en mapa
    t = t + sampleTime;
    [distancia, angulo] =  escanearAlrededores(Robot);
    unirEscaneo(Robot,distancia,angulo)
    if Robot.GraphicsOn
        mostrarScan(Robot,distancia,angulo)
        updatePlotRobot(Robot);
    end
    disp(t);
    disp(esquinas);
end
lista
mostrarScan(Robot,distancia,angulo);
updatePlotRobot(Robot);
Robot.TotalTime