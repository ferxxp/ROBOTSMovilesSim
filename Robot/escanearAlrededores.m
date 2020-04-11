function [distancia, angulo] =  escanearAlrededores(robot)
[distancia, angulo] = robot.Sensor(robot.PosReal, robot.MapaReal);

