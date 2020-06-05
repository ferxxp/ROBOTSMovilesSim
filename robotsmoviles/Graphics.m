
% for angle=-6*pi:0.1:6*pi
%     if(abs(angle)>pi)
%         disp(mod(angle,pi)*sign(angle)*(-1)^(floor(angle/pi)))
%     end
% end

%%
global Robot
Robot=updatePlotRobot(Robot,true)
while true
    figure(Robot.figMapa);
    p=drawpoint();
    disp(p.Position)
    broken=true;
    path=Path(Robot,p.Position,0.2,1,1,false);
    if path~=inf
        [Psize,~]=size(path);
        goal=path(Psize,:);
        while (abs(norm(Robot.Posicion(1:2)+Robot.InitPos(1:2)-goal,2)))>0.3 && broken
            
            if path~=inf
                minC=0;
                [Robot,path]=moverRobotA2(Robot,path);
                [distancia, angulo] =  escanearAlrededores(Robot);
                Robot=mostrarScan(Robot,distancia,angulo);
                Robot=unirEscaneo(Robot,distancia,angulo);
                Robot=updatePlotRobot(Robot);
                path=Path(Robot,goal,0.2,1,true,0);
            else
                broken=false;
            end
        end
        disp('End reached')
        Robot=updatePlotRobot(Robot,true);
    end
end