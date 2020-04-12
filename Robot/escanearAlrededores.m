function [distancia, angulo] =  escanearAlrededores(robot)

if robot.ruidoOn
    [distancia, angulo] = robot.Sensor(robot.PosReal, robot.MapaReal);
    distancia = distancia+distancia.*(-1+2*rand(size(distancia))).*robot.ruiLidar/100;
else
    [distancia, angulo] = robot.Sensor(robot.PosReal, robot.MapaReal);
end


