function robot= updatePlotRobot(robot)

%% actualizar mapa Real

try
    figure(robot.figMapaReal);
catch
    warning('Problem using function');
    pantallaSize=get(0,'ScreenSize');
    robot.figMapaReal=figure('Position',[0,0,pantallaSize(3)/3,pantallaSize(4)/3]);
end
show(robot.MapaReal);
%conversion cordenadas
posRobot = [robot.PosReal(1:2)'; 0];
rotRobot = axang2quat([0 0 1 robot.PosReal(3)]);
%dibujo robot
plotTransforms(posRobot', rotRobot, 'MeshFilePath', 'groundvehicle.stl', 'View', '2D', 'FrameSize', 0.5, 'Parent', robot.figMapaReal.CurrentAxes);


%% actualizar mapa teorico

try
    figure(robot.figMapa);
catch
    warning('Problem using function.  Assigning a value of 0.');
    pantallaSize=get(0,'ScreenSize');
    robot.figMapa=figure('Position',[0,pantallaSize(4)/3,pantallaSize(3)/3,pantallaSize(4)/3]);
end


show(robot.Mapa);
%conversion cordenadas
posRobot = [(robot.Posicion(1:2)+robot.InitPos(1:2))'; 0];
rotRobot = axang2quat([0 0 1 robot.Posicion(3)]);
%dibujo robot
plotTransforms(posRobot', rotRobot, 'MeshFilePath', 'groundvehicle.stl', 'View', '2D', 'FrameSize', 0.5, 'Parent', robot.figMapa.CurrentAxes);
