function mark= ExploredData(Robot,debug)
if nargin==1
    debug=false;
end
if debug
    imagesc(getOccupancy(Robot.Mapa));
end
MAtrix=getOccupancy(Robot.Mapa);
MAtrix=conv2(MAtrix,ones(Robot.Mapa.Resolution*2),'same');
if debug
    figure;
    imagesc(MAtrix);
end
[h,w]=size(MAtrix);
if debug
    figure;
    imagesc(MAtrix(1:Robot.Mapa.Resolution:h,1:Robot.Mapa.Resolution:w));
    figure;
    imagesc(getOccupancy(Robot.MapaReal));
end
Result=MAtrix(1:Robot.Mapa.Resolution:h,1:Robot.Mapa.Resolution:w).*getOccupancy(Robot.MapaReal);

mark = size(find(Result~=0))/sum(sum(getOccupancy(Robot.MapaReal))) *100;
