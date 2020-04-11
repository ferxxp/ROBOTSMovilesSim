function [robot] = moverRobotA(robot,Meta)

ControlRuta = controllerPurePursuit('DesiredLinearVelocity',2,'MaxAngularVelocity',3);
ControlRuta.Waypoints=[robot.PosReal(1:2)' , Meta'];

[velL, velR]=ControlRuta(robot.PosReal);

diffDrive = differentialDriveKinematics("VehicleInputs","VehicleSpeedHeadingRate");
vreal = derivative(diffDrive, robot.PosReal', [velL velR]);
robot.PosReal = robot.PosReal + vreal'*robot.TimeStep; 
robot.Posicion=robot.PosReal-robot.InitPos;

end

