function [robot]= RobotGen(map,pos,rangosensor,tp,gOn,rOn,rLidar,rOdo)

robot.MapaReal=binaryOccupancyMap(map,1);
        [mapdimx,mapdimy] = size(map);
robot.Mapa=binaryOccupancyMap(mapdimy,mapdimx,50);
robot.PosReal=pos;
robot.Posicion=[0,0,0];
robot.InitPos=pos;

pantallaSize=get(0,'ScreenSize');
robot.figMapaReal=figure('Position',[0,0,pantallaSize(3)/3,pantallaSize(4)/3]);
robot.figMapa=figure('Position',[0,pantallaSize(4)/3,pantallaSize(3)/3,pantallaSize(4)/3]);
robot.figSensor=figure('Position',[pantallaSize(3)/3,0,pantallaSize(3)/3,pantallaSize(4)/3]);

robot.Sensor = rangeSensor;
robot.Sensor.Range = rangosensor;

robot.TimeStep=tp;
robot.TotalTime=0;
if nargin > 4
  robot.GraphicsOn = gOn;
else
  robot.GraphicsOn = true;
end

if nargin > 7
  robot.ruidoOn=rOn;
  robot.ruiLidar=rLidar;
  robot.ruiOdo=rOdo;
else
  robot.ruidoOn=false;
  robot.ruiLidar=0;
  robot.ruiOdo=0;
end


updatePlotRobot(robot);