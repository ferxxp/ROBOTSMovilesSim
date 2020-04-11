str1='maps/map';
str2='/map';
str3='.csv';
for a= 1:3
load(sprintf('%s%d%s%d%s',str1,a,str2,a,str3))
end

%% readrealmap
refMap = binaryOccupancyMap(map1,1);
refFigure = figure('Name','SimpleMap');
show(refMap);

%% create robot map
[mapdimx,mapdimy] = size(map1);
map = binaryOccupancyMap(mapdimy,mapdimx,50);
mapFigure = figure('Name','Unknown Map');
show(map);

%% robot
diffDrive = differentialDriveKinematics("VehicleInputs","VehicleSpeedHeadingRate");
controller = controllerPurePursuit('DesiredLinearVelocity',2,'MaxAngularVelocity',3);
sensor = rangeSensor;
sensor.Range = [0,10];


path = [2 8; 6 8;4 2];
figure(refFigure);
hold on
plot(path(:,1),path(:,2), 'o-');
hold off
controller.Waypoints = path;

initPose = [path(1,1) path(1,2), 0];
goal = [path(end,1) path(end,2)]';
poses(:,1) = initPose';

exampleHelperDiffDriveControl(diffDrive,controller,initPose,goal,refMap,map,refFigure,mapFigure,sensor)

path = [2 8; 6 8;4 2];
exampleHelperDiffDriveControl(diffDrive,controller,initPose,goal,refMap,map,refFigure,mapFigure,sensor)





