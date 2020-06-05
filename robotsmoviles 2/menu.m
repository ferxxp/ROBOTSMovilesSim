function menu
addpath('exploracion','Robot','navegacion')
global Robot;

% Crear figura
fig = uifigure('Name', 'Menú de selección','Position',[20 230 440 400]);

%Crear paneles del menu
p1 = uipanel(fig,'Title','Elige el mapa e inicio','FontSize',14,...
             'BackgroundColor','white',...
             'Position',[20 210 190 170]);
p2 = uipanel(fig,'Title','Algoritmos de planificación','FontSize',14,...
             'BackgroundColor','white',...
             'Position',[230 45 190 95]);
p3 = uipanel(fig,'Title','Configuración del robot','FontSize',14,...
             'BackgroundColor','white',...
             'Position',[230 155 190 225]);
p = uipanel(fig,'Title','Algoritmos de exploración','FontSize',14,...
             'BackgroundColor','white',...
             'Position',[20 20 190 170]);
%Mapa e inicio
mapas = uidropdown(p1,'Position',[20 115 150 22],'Items',{'map1','map2','map3'});
x = uieditfield(p1,'numeric','RoundFractionalValues','on','Position',[120 90 50 22],'Value',2);
coordx = uilabel(p1,'Position',[20 90 100 22],'Text','Coordenada x:');
y = uieditfield(p1,'numeric','RoundFractionalValues','on','Position',[120 65 50 22],'Value',2);
coordy = uilabel(p1,'Position',[20 65 100 22],'Text','Coordenada y:');
rot = uieditfield(p1,'numeric','RoundFractionalValues','off','Position',[120 40 50 22],'Value',0);
rotacion = uilabel(p1,'Position',[20 40 100 22],'Text','Rotación:');

%Configuracion robot
rangosup = uieditfield(p3,'numeric','RoundFractionalValues','on','Position',[145 165 25 22],'Value',10);
rangoinf = uieditfield(p3,'numeric','RoundFractionalValues','on','Position',[115 165 25 22],'Value',0);
rango = uilabel(p3,'Position',[20 165 100 22],'Text','Rango lidar:');
step = uieditfield(p3,'numeric','RoundFractionalValues','off','Position',[115 140 55 22],'Value',0.1);
timestep = uilabel(p3,'Position',[20 140 100 22],'Text','Timestep:');
ruido = uicheckbox(p3, 'Text','Ruido','Value', 0,'Position',[20 115 100 22]);
graficos = uicheckbox(p3, 'Text','Gráficos','Value', 0,'Position',[100 115 100 22]);
lidar = uieditfield(p3,'numeric','RoundFractionalValues','on','Position',[145 90 25 22],'Value',3);
ruidolidar = uilabel(p3,'Position',[20 90 100 22],'Text','Ruido lidar (%):');
odometria = uieditfield(p3,'numeric','RoundFractionalValues','on','Position',[145 65 25 22],'Value',3);
ruidoodometria = uilabel(p3,'Position',[20 65 130 22],'Text','Ruido odometria (%):');
resolucion = uieditfield(p3,'numeric','RoundFractionalValues','on','Position',[145 40 25 22],'Value',3);
resolucionmapa = uilabel(p3,'Position',[20 40 100 22],'Text','Resolucion mapa:');

%crear botones
cerrar = uibutton(fig,'push',...
               'Text', 'Cerrar',...
               'Position',[250, 15, 150, 22],...
               'ButtonPushedFcn', @(cerrar,event) cerrar_funcion() );
actualizar = uibutton(p3,'push',...
               'Text', 'Actualizar robot',...
               'Position',[20, 15, 150, 22],...
               'ButtonPushedFcn', @(actualizar,event) actualizar_funcion(rangosup.Value,rangoinf.Value,step.Value,...
               ruido.Value,graficos.Value,lidar.Value,odometria.Value,resolucion.Value,mapas.Value,x.Value,y.Value,rot.Value) );
visualizar = uibutton(p1,'push',...
               'Text', 'Visualizar mapa',...
               'Position',[20, 15, 150, 22],...
               'ButtonPushedFcn', @(visualizar,event) visualizar_funcion(mapas.Value,x.Value,y.Value,rot.Value,resolucion.Value) );
bug = uibutton(p,'push',...
               'Text', 'Bug',...
               'Position',[20, 15, 150, 22],...
               'ButtonPushedFcn', @(bug,event) bug_funcion(mapas.Value,x.Value,y.Value,rot.Value,resolucion.Value) );
bug_int = uibutton(p,'push',...
               'Text', 'Bug inteligente',...
               'Position',[20, 40, 150, 22],...
               'ButtonPushedFcn', @(bug_int,event) bug_int_funcion(mapas.Value,x.Value,y.Value,rot.Value,resolucion.Value) );
bug_semi = uibutton(p,'push',...
               'Text', 'Bug semi-inteligente',...
               'Position',[20, 65, 150, 22],...
               'ButtonPushedFcn', @(bug_semi,event) bug_semi_funcion(mapas.Value,x.Value,y.Value,rot.Value,resolucion.Value) );
esquinas = uibutton(p,'push',...
               'Text', 'Buscador de esquinas',...
               'Position',[20, 90, 150, 22],...
               'ButtonPushedFcn', @(esquinas,event) esquinas_funcion(mapas.Value,x.Value,y.Value,rot.Value,resolucion.Value) );
explorer = uibutton(p,'push',...
               'Text', 'Explorer',...
               'Position',[20, 115, 150, 22],...
               'ButtonPushedFcn', @(explorer,event) explorer_funcion(mapas.Value,x.Value,y.Value,rot.Value,resolucion.Value) );
astar = uibutton(p2,'push',...
               'Text', 'A*',...
               'Position',[20, 40, 150, 22],...
               'ButtonPushedFcn', @(astar,event) astar_funcion() );
dijkstra = uibutton(p2,'push',...
               'Text', 'Dijkstra',...
               'Position',[20, 15, 150, 22],...
               'ButtonPushedFcn', @(astar,event) dijkstra_funcion() );
end


% Funciones Callback de los botones
function cerrar_funcion()
        close all
        clear
        closereq(); 
end
function actualizar_funcion(rangosup,rangoinf,step,ruido,graficos,lidar,odometria,resolucion,mapita,x,y,rot)
        global Robot
        Robot.Sensor.Range = [rangoinf,rangosup];
        Robot.TimeStep=step;
        Robot.GraphicsOn = graficos;
        if ruido
            Robot.ruidoOn=ruido;
            Robot.ruiLidar=lidar;
            Robot.ruiOdo=odometria;
        else
            Robot.ruidoOn=ruido;
            Robot.ruiLidar=0;
            Robot.ruiOdo=0;
        end
        visualizar_funcion(mapita,x,y,rot,resolucion) 
end
function visualizar_funcion(mapita,x,y,rot,resolucion)
        global Robot;
        str1='maps/';
        str2=mapita;
        str3='.csv';
        [mapa] = load(sprintf('%s%s%s%s%s',str1,str2,'/',str2,str3));
        Robot.MapaReal=binaryOccupancyMap(mapa,1);
        [mapdimx,mapdimy] = size(mapa);
        Robot.Mapa=binaryOccupancyMap(mapdimy,mapdimx,resolucion);
        Robot.PosReal=[x,y,rot];
        Robot.Posicion=[0,0,0];
        Robot.InitPos=[x,y,rot];
        Robot = updatePlotRobot(Robot,true);
end
function bug_funcion(mapita,x,y,rot,resolucion)
        global Robot;
        visualizar_funcion(mapita,x,y,rot,resolucion)
        Robot=bug(Robot)
end

function bug_int_funcion(mapita,x,y,rot,resolucion)
        global Robot;
        visualizar_funcion(mapita,x,y,rot,resolucion)
        Robot=bug_int(Robot)
end

function bug_semi_funcion(mapita,x,y,rot,resolucion)
        global Robot;
        visualizar_funcion(mapita,x,y,rot,resolucion)
        Robot=bug_semi(Robot)
end

function esquinas_funcion(mapita,x,y,rot,resolucion)
        global Robot;
        visualizar_funcion(mapita,x,y,rot,resolucion)
        Robot=esquinas(Robot)
end

function explorer_funcion(mapita,x,y,rot,resolucion)
        global Robot;
        visualizar_funcion(mapita,x,y,rot,resolucion)
        Robot=Explorer(Robot)
end

function astar_funcion()
        global Robot;
        Ruta = Path(Robot,Robot.InitPos,0.1,0,true,0)
        
        [Psize,~]=size(Ruta);
        goal=Ruta(Psize,:);
        
        while (abs(sum(Robot.Posicion(1:2)+Robot.InitPos(1:2)-goal,2)))>0.3
            [Robot,Ruta]=moverRobotA2(Robot,Ruta);
            Robot=updatePlotRobot(Robot,true);
        end
        
end

function dijkstra_funcion()
        global Robot;
        Ruta = Path(Robot,Robot.InitPos,0.1,1,true,0)
        
        [Psize,~]=size(Ruta);
        goal=Ruta(Psize,:);
        
        while (abs(sum(Robot.Posicion(1:2)+Robot.InitPos(1:2)-goal,2)))>0.3
            [Robot,Ruta]=moverRobotA2(Robot,Ruta);
            Robot=updatePlotRobot(Robot,true);
        end
end