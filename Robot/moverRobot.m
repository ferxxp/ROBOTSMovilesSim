function robot = moverRobot(robot,velL,velR)

diffDrive = differentialDriveKinematics("VehicleInputs","VehicleSpeedHeadingRate");


if robot.ruidoOn
    
    vreal = derivative(diffDrive, robot.PosReal', [velL+(-1+2*rand())*robot.ruiOdo/100 velR+(-1+2*rand())*robot.ruiOdo/100]);
    robot.PosReal = robot.PosReal + vreal'*robot.TimeStep; 
    
    vreal = derivative(diffDrive, robot.Posicion', [velL velR]);
    robot.Posicion = robot.Posicion + vreal'*robot.TimeStep;
else
    vreal = derivative(diffDrive, robot.PosReal', [velL velR]);
    robot.PosReal = robot.PosReal + vreal'*robot.TimeStep; 
    robot.Posicion=robot.PosReal-robot.InitPos;
end
robot.TotalTime=robot.TotalTime+robot.TimeStep;

