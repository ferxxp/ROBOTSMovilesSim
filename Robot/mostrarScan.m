function robot=mostrarScan(robot,distancia, angulo,force)
%MOSTRARSCAN Summary of this function goes here
%   Detailed explanation goes here
if (nargin>3 && force) || robot.GraphicsOn
    try
        figure(robot.figSensor);
    catch
        warning('Problem using function');
        pantallaSize=get(0,'ScreenSize');
        robot.figSensor=figure('Position',[pantallaSize(3)/3,0,pantallaSize(3)/3,pantallaSize(4)/3]);
    end
    
    clf;
    
    plotCircleGrid(min(robot.Sensor.Range)+0.1,max(robot.Sensor.Range),30,15)
    plot([0,max(robot.Sensor.Range)],[0,0],'r--')
    plot([0,0],[0,max(robot.Sensor.Range)],'g--')
    for a= 1:max(size(distancia))
        X = distancia(a)*cos(angulo(a));
        Y = distancia(a)*sin(angulo(a));
        plot(X,Y,'S','Color','red','MarkerSize',5,'MarkerFaceColor','red');
    end
    plotTransforms([0,0,0], axang2quat([0 0 1 0]), 'MeshFilePath', 'groundvehicle.stl', 'View', '2D', 'FrameSize', 1, 'Parent', robot.figSensor.CurrentAxes);
    
    view(-90,90)
end

