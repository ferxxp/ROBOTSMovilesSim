function  updatePlotRobot(robot)

%% actualizar mapa Real
figure(robot.figMapaReal);

show(robot.MapaReal);
%conversion cordenadas
posRobot = [robot.PosReal(1:2)'; 0];
rotRobot = axang2quat([0 0 1 robot.PosReal(3)]);
%dibujo robot
plotTransforms(posRobot', rotRobot, 'MeshFilePath', 'groundvehicle.stl', 'View', '2D', 'FrameSize', 0.5, 'Parent', robot.figMapaReal.CurrentAxes);


%% actualizar mapa teorico
figure(robot.figMapa);

show(robot.Mapa);
%conversion cordenadas
posRobot = [(robot.Posicion(1:2)+robot.InitPos(1:2))'; 0];
rotRobot = axang2quat([0 0 1 robot.Posicion(3)]);
%dibujo robot
plotTransforms(posRobot', rotRobot, 'MeshFilePath', 'groundvehicle.stl', 'View', '2D', 'FrameSize', 0.5, 'Parent', robot.figMapa.CurrentAxes);
