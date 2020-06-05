function robot = unirEscaneo(robot,Distancia,Angulos)

scan = lidarScan(Distancia,Angulos);
LastMAtrix=getOccupancy(robot.Mapa);
insertRay(robot.Mapa,robot.Posicion+robot.InitPos,scan,robot.Sensor.Range(2));
NexMatrix=getOccupancy(robot.Mapa);
max(max(LastMAtrix+NexMatrix))
robot.Mapa=binaryOccupancyMap(LastMAtrix+NexMatrix,robot.Mapa.Resolution);