function [total] = DistanceMoved(Robot)
total=0;
[~,b]=size(Robot.histPos);
for a = 2:b
    total=total+ norm(Robot.histPos(:,a)-Robot.histPos(:,a-1));
end

end

