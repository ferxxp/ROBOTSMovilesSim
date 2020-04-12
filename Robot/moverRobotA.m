function [robot] = moverRobotA(robot,Meta)

ControlRuta = controllerPurePursuit('DesiredLinearVelocity',2,'MaxAngularVelocity',3);
diffDrive = differentialDriveKinematics("VehicleInputs","VehicleSpeedHeadingRate");

if robot.ruidoOn
    ControlRuta.Waypoints=[robot.Posicion(1:2)'+robot.InitPos(1:2)' , Meta'];
    [velL, velR]=ControlRuta(robot.PosReal);
    
    vreal = derivative(diffDrive, robot.PosReal', [velL+(-1+2*rand())*robot.ruiOdo/100 velR+(-1+2*rand())*robot.ruiOdo/100]);
    robot.PosReal = robot.PosReal + vreal'*robot.TimeStep; 
    
    vreal = derivative(diffDrive, robot.Posicion', [velL velR]);
    robot.Posicion = robot.Posicion + vreal'*robot.TimeStep;
else
    ControlRuta.Waypoints=[robot.PosReal(1:2)' , Meta'];
    [velL, velR]=ControlRuta(robot.PosReal);

    vreal = derivative(diffDrive, robot.PosReal', [velL velR]);
    
    robot.PosReal = robot.PosReal + vreal'*robot.TimeStep; 
    robot.Posicion=robot.PosReal-robot.InitPos;

end
end

