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
clear map1 str1 str2 str3
%close all
menu