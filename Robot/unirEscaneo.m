function unirEscaneo(robot,Distancia,Angulos)

scan = lidarScan(Distancia,Angulos);
insertRay(robot.Mapa,robot.Posicion+robot.InitPos,scan,robot.Sensor.Range(2));