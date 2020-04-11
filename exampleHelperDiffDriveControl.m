function exampleHelperDiffDriveControl(diffDrive,ppControl,initPose,goal,map1,map2,fig1,fig2,lidar)
sampleTime = 0.05;             % Sample time [s]
t = 0:sampleTime:100;         % Time array
poses = zeros(3,numel(t));    % Pose matrix
poses(:,1) = initPose';

% Set iteration rate
r = rateControl(1/sampleTime);

% Get the axes from the figures
ax1 = fig1.CurrentAxes;
ax2 = fig2.CurrentAxes;

    for idx = 1:numel(t)
        position = poses(:,idx)';
        currPose = position(1:2);
        
        % End if pathfollowing is vehicle has reached goal position within tolerance of 0.2m
        dist = norm(goal'-currPose);
        if (dist < .2)
            disp("Goal position reached")
            break;
        end
        
        % Update map by taking sensor measurements
        figure(2)
        [ranges, angles] = lidar(position, map1);
        scan = lidarScan(ranges,angles);
        %validScan = removeInvalidData(scan,'RangeLimits',[0,lidar.Range(2)]);
        insertRay(map2,position,scan,lidar.Range(2));
        show(map2);
        
        % Run the Pure Pursuit controller and convert output to wheel speeds
        [vRef,wRef] = ppControl(poses(:,idx));
    
        % Perform forward discrete integration step
        vel = derivative(diffDrive, poses(:,idx), [vRef wRef]);
        poses(:,idx+1) = poses(:,idx) + vel*sampleTime; 
    
    
        % Update visualization
        plotTrvec = [poses(1:2, idx+1); 0];
        plotRot = axang2quat([0 0 1 poses(3, idx+1)]);
        
        % Delete image of the last robot to prevent displaying multiple robots
        if idx > 1
           items = get(ax1, 'Children');
           delete(items(1)); 
        end
    
        %plot robot onto known map
        plotTransforms(plotTrvec', plotRot, 'MeshFilePath', 'groundvehicle.stl', 'View', '2D', 'FrameSize', 1, 'Parent', ax1);
        %plot robot on new map
        plotTransforms(plotTrvec', plotRot, 'MeshFilePath', 'groundvehicle.stl', 'View', '2D', 'FrameSize', 1, 'Parent', ax2);
    
        % waiting to iterate at the proper rate
        waitfor(r);
    end
end