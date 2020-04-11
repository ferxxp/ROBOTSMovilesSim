str1='maps/map';
str2='/map';
str3='.csv';
for a= 1:3
load(sprintf('%s%d%s%d%s',str1,a,str2,a,str3))
end
%% Creacion de los robots
Robot=RobotGen(map1,[2,2,0],[0,10],0.1);
updatePlotRobot(Robot);

%% escaneo inicial
[distancia, angulo] =  escanearAlrededores(Robot);
mostrarScan(Robot,distancia,angulo)
%% Prueba escaneo
Robot.PosReal=[2,2,1];

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
while abs(sum(Robot.PosReal(1:2)-[8,8]))>1
    Robot=moverRobotA(Robot,[8,8]);
    [distancia, angulo] =  escanearAlrededores(Robot);
    mostrarScan(Robot,distancia,angulo)
    unirEscaneo(Robot,distancia,angulo)
    updatePlotRobot(Robot);
end