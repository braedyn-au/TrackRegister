function trackPoints = parseCSV(csvfile,conversion)
%parseCSV Reads CSV files from Mosaic tracker 
%   Braedyn Au

data = readmatrix(csvfile);
trackPoints = {};
start = 2;
for row = 2:(size(data,1)-1)
    xpoints = [];
    ypoints = [];
    zpoints = [];
    tpoints = [];
    if data(row,2) ~= data(row+1,2) 
        xpoints = [xpoints,data(start:row,4)].'./conversion;
        ypoints = [ypoints,data(start:row,5)].'./conversion;
        zpoints = [zpoints,data(start:row,6)].'./conversion;
        tpoints = [tpoints,data(start:row,3)].';
        trackPoints(data(row,2),:) = {[xpoints;ypoints;zpoints;tpoints]}; 
        start = row + 1;
    end
end
% Get the last track
xpoints = [];
ypoints = [];
zpoints = [];
tpoints = [];

xpoints = [xpoints,data(start:size(data,1),4)].'./conversion;
ypoints = [ypoints,data(start:size(data,1),5)].'./conversion;
zpoints = [zpoints,data(start:size(data,1),6)].'./conversion;
tpoints = [tpoints,data(start:size(data,1),3)].';

trackPoints(data(start,2),:) = {[xpoints;ypoints;zpoints;tpoints]};
end

