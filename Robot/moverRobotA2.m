function [robot,camino] = moverRobotA2(robot,camino)

if robot.ruidoOn
    Pose=robot.Posicion+robot.InitPos;
else
    Pose=robot.PosReal;
end
currentGoal=Pose(1:2);
while norm(Pose(1:2)-currentGoal)<1 && ~isempty(camino)
    currentGoal=camino(1,:);
    camino(1,:)=[];
    
end

angleofattack=atan2(currentGoal(2)-Pose(2),currentGoal(1)-Pose(1));
anglerob=Pose(3);
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
   robot=moverRobot(robot,3,0);
end

if isempty(camino)
    camino=currentGoal;
end 
end