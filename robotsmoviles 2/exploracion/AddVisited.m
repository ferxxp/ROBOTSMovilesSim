function VisitMAP = AddVisited(robot,VisitMAP,Sight)
Res=robot.Mapa.Resolution;
[Height,Width]=size(getOccupancy(robot.Mapa));
Start=[round((robot.Posicion(1)+robot.InitPos(1))*Res+1),round((robot.Posicion(2)+robot.InitPos(2))*Res+1)];
VisitMAP((max([Start(2)-Sight,1]):min([Start(2)+Sight,Height])),max([Start(1)-Sight,1]):min([Start(1)+Sight,Width]))=1;
end