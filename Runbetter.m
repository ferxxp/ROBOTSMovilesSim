close all
clear all
addpath('Robot','exploracion')  

str1='maps/map';
str2='/map';
str3='.csv';
for a= 1:3
load(sprintf('%s%d%s%d%s',str1,a,str2,a,str3))
end
%% Creacion de los robots
Robot=RobotGen(map1,[2,2,0],[0,10],0.1,false,false,5,5);

%% escaneo inicial
[distancia, angulo] =  escanearAlrededores(Robot);
mostrarScan(Robot,distancia,angulo)
%% Prueba escaneo
%Robot.PosReal=[2,2,1];

[distancia, angulo] =  escanearAlrededores(Robot);
mostrarScan(Robot,distancia,angulo)
unirEscaneo(Robot,distancia,angulo)
updatePlotRobot(Robot);

getOccupancy(Robot.Mapa)

%% Pruebas de movimiento
% Robot=moverRobot(Robot,2,0);
% 
% [distancia, angulo] =  escanearAlrededores(Robot);
% mostrarScan(Robot,distancia,angulo)
% unirEscaneo(Robot,distancia,angulo)
% updatePlotRobot(Robot);
% 
% Robot=moverRobot(Robot,0,1);
% 
% [distancia, angulo] =  escanearAlrededores(Robot);
% mostrarScan(Robot,distancia,angulo)
% unirEscaneo(Robot,distancia,angulo)
% updatePlotRobot(Robot);
% 
% Robot=moverRobot(Robot,1,1);
% 
% [distancia, angulo] =  escanearAlrededores(Robot);
% mostrarScan(Robot,distancia,angulo)
% unirEscaneo(Robot,distancia,angulo)
% updatePlotRobot(Robot);
%% Prueba de movimiento
error=[0,0,0];
while abs(sum(Robot.PosReal(1:2)-[6,6]))>1
    Robot=moverRobotA(Robot,[8,8]);
    checkCollided(Robot)
    [distancia, angulo] =  escanearAlrededores(Robot);
    if Robot.GraphicsOn
        mostrarScan(Robot,distancia,angulo)
    end
    unirEscaneo(Robot,distancia,angulo)
    if Robot.GraphicsOn
        updatePlotRobot(Robot);
    end
    error=[error; Robot.PosReal-Robot.Posicion-Robot.InitPos];
end

while abs(sum(Robot.PosReal(1:2)-[3,3]))>0.1
    Robot=moverRobotA(Robot,[4,4]);
    [distancia, angulo] =  escanearAlrededores(Robot);
    checkCollided(Robot)
    if Robot.GraphicsOn
        mostrarScan(Robot,distancia,angulo)
    end
    unirEscaneo(Robot,distancia,angulo)
    if Robot.GraphicsOn
        updatePlotRobot(Robot);
    end
    error=[error; Robot.PosReal-Robot.Posicion-Robot.InitPos];
end
updatePlotRobot(Robot);
figure
plot(error)
legend('EX','EY','Eroll')