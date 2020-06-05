close all
clear
addpath('exploracion','Robot','navegacion')
str1='maps/map';
str2='/map';
str3='.csv';
load(sprintf('%s%d%s%d%s',str1,1,str2,1,str3))
%% Creacion de los robots
global Robot;
Robot=RobotGen(map1,[2,2,0],[0,10],0.1,10,true,false,5,5);

for a = 1:100
    [Robot]=moverRobot(Robot,1,1);
    [distancia, angulo] =  escanearAlrededores(Robot);
    Robot=mostrarScan(Robot,distancia,angulo);
    Robot=unirEscaneo(Robot,distancia,angulo);
    Robot=updatePlotRobot(Robot);
end