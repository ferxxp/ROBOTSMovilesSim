function collided = checkCollided(robot)
MapOnCheck= getOccupancy(robot.MapaReal);
Resolution=robot.MapaReal.Resolution;
PoseT=round(robot.PosReal/Resolution);
collided=(MapOnCheck(PoseT(2)+1,PoseT(1)+1)==1);