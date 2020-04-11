function robot = moverRobot(robot,velL,velR)

diffDrive = differentialDriveKinematics("VehicleInputs","VehicleSpeedHeadingRate");
vreal = derivative(diffDrive, robot.PosReal', [velL velR]);
robot.PosReal = robot.PosReal + vreal'*robot.TimeStep; 
robot.Posicion=robot.PosReal-robot.InitPos;