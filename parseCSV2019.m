function trackPoints = parseCSV(csvfile,conversion)
%parseCSV Reads CSV files from Mosaic tracker 
%   Braedyn Au

%data = readmatrix(csvfile);
data = dlmread(csvfile,',',1,0);
trackPoints = {};
start = 2; %skip the header of CSV file
for row = 2:(size(data,1)-1)
    xpoints = [];
    ypoints = [];
    zpoints = [];
    tpoints = [];
    % parse the trajectory column to keep different particles seperate
    % once trajectory number changes, add the localizations to the array
    % data(row,n) where n is the column of trajectories
    % IF CHANGING THIS MAKE SURE TO CHANGE THE BOTTOM LINE TOO
    if data(row,1) ~= data(row+1,1) 
        % data(start:row,n) where n is the column with the data to be read
        xpoints = [xpoints,data(start:row,3)].'./conversion; % x column
        ypoints = [ypoints,data(start:row,4)].'./conversion; % y column
        zpoints = [zpoints,data(start:row,5)].'./conversion; % z column
        tpoints = [tpoints,data(start:row,2)].'; % frames column
        trackPoints(data(row,1),:) = {[xpoints;ypoints;zpoints;tpoints]}; 
        start = row + 1; % update starting point for next trajectory
    end
end
% LAST TRACK
% Get the last track
xpoints = [];
ypoints = [];
zpoints = [];
tpoints = [];
% UPDATE THESE COLUMN POINTS
xpoints = [xpoints,data(start:size(data,1),3)].'./conversion;
ypoints = [ypoints,data(start:size(data,1),4)].'./conversion;
zpoints = [zpoints,data(start:size(data,1),5)].'./conversion;
tpoints = [tpoints,data(start:size(data,1),2)].';
% UPDATE
trackPoints(data(start,1),:) = {[xpoints;ypoints;zpoints;tpoints]};
end

