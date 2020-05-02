
% for angle=-6*pi:0.1:6*pi
%     if(abs(angle)>pi)
%         disp(mod(angle,pi)*sign(angle)*(-1)^(floor(angle/pi)))
%     end
% end
addpath('Robot','exploracion')  


close all
clear all

str1='maps/map';
str2='/map';
str3='.csv';
for a= 1:3
load(sprintf('%s%d%s%d%s',str1,a,str2,a,str3))
end
%%
Robot=RobotGen(map1,[2,2,0],[0,10],0.1,false,false,5,5);
Robot=updatePlotRobot(Robot);
while true
    figure(Robot.figMapa);
    p=drawpoint();
    p.Position;
    path=Path(Robot,p.Position,0.2,false);
    if path~=inf
        [Psize,~]=size(path);
        goal=path(Psize,:);
        while abs(sum(Robot.PosReal(1:2)-goal))>0.3
                %Robot=moverRobotA(Robot,path);
                [Robot,path]=moverRobotA2(Robot,path);
                [distancia, angulo] =  escanearAlrededores(Robot);
                
                if true
                    mostrarScan(Robot,distancia,angulo);
                end
                    unirEscaneo(Robot,distancia,angulo);
                if true
                    updatePlotRobot(Robot);
                end
        end
        Robot.Posicion(3);
    end
end