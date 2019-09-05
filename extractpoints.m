% Take points from Trackmate and return points from each individual track
% ---------------------------------------------------------------------
% Braedyn Au
%
% Load the XML file using parseXML function
% Load the image using image function
% Calculate tform matrix 
% Register tracks using transformPointsForward function

function trackPoints = extractpoints(tracks,conversion)
% Uses parseXML to load XML structure and then extracts data ino a cell
% Using a cell to contain each track
trackPoints = {};
% Not sure if required to preserve precision
format long
% In this case, nrows in the first children nodes is equal to 
% 2 times the number of tracks + 1
nrows = size(tracks.Children,2);
i = 0;
for row = 1:nrows
    firstChildName = string(getfield(tracks.Children(row),'Name'));
    if firstChildName=="particle"
        
        i = i+1;
        % arrays and for loops probably arent the most efficient way
        % initialize arrays to hold points of new track
        xpoints = [];
        ypoints = [];
        zpoints = [];
        tpoints = [];
        % In this case, nrows2 in the second child is equal to
        % 2 times the number of points per track + 1
        % 1 point per frame
        nrows2 = size(tracks.Children(row).Children,2);
        for row2 = 1:nrows2
            secondChildName = getfield(tracks.Children(row).Children(row2),'Name');
            if strcmp(secondChildName,'detection')
                xpoints = [xpoints, str2double(getfield(tracks.Children(row).Children(row2).Attributes(2),'Value'))./conversion];
                ypoints = [ypoints, str2double(getfield(tracks.Children(row).Children(row2).Attributes(3),'Value'))./conversion];
                zpoints = [zpoints, str2double(getfield(tracks.Children(row).Children(row2).Attributes(4),'Value'))./conversion];
                tpoints = [tpoints, str2double(getfield(tracks.Children(row).Children(row2).Attributes(1),'Value'))];
            end
        end
        trackPoints(i,:) = {[xpoints;ypoints;zpoints;tpoints]};    
    end
end
disp('Total tracks found: ');
disp(i);
end

% Now we have a cell with each row representing a different track's points


           
                

        
    
    

