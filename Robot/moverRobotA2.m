function [robot,camino] = moverRobotA2(robot,camino)

currentGoal=robot.Posicion(1:2)+robot.InitPos(1:2);
while norm(robot.Posicion(1:2)+robot.InitPos(1:2)-currentGoal)<1 && ~isempty(camino)
    currentGoal=camino(1,:);
    camino(1,:)=[];
    
end

angleofattack=atan2(currentGoal(2)-robot.Posicion(2)-robot.InitPos(2),currentGoal(1)-robot.Posicion(1)-robot.InitPos(1));
anglerob=robot.Posicion(3)+robot.InitPos(3);
if(abs(anglerob)>pi)
        anglerob=(mod(angle,pi)*sign(angle)*(-1)^(floor(angle/pi)));
end
anglerror=angleofattack-anglerob;
disp('_')
disp(angleofattack)
disp(anglerror)
if abs(anglerror)>0.1 
   robot=moverRobot(robot,0,min([anglerror/robot.TimeStep,3]));
else
   robot=moverRobot(robot,1,0);
end

if isempty(camino)
    camino=currentGoal;
end 
end