function regPoints = register( trackPoints, movingPoints, fixedPoints )
%REGISTER Registers tracks points to super res image
% Braedyn Au
%   Takes fiducial points currently from user input 
%   Use ImageJ or SMAP to find the points for now
%   Display the super res image and tracks and find 
%   the points corresponding to fiducials.
%   For m points, movingPoints and fixedPoints will be 
%   x- and y-coordinates of control points in the image you want
%   to transform, specified as an m-by-2 double matrix.
%   For nonreflective similarity the minimum number of control
%   point pairs is 2

tform = fitgeotrans(movingPoints,fixedPoints,'nonreflectivesimilarity');
regPoints = {};
ntracks = size(trackPoints,1);
for trknmbr = 1:ntracks
    %time = size(trackPoints{trknmbr,1},2);
    %for t = 1:time
    [x,y] = transformPointsForward(tform,trackPoints{trknmbr,1}(1,:),trackPoints{trknmbr,1}(2,:));
    regPoints(trknmbr,:) = {[x;y;trackPoints{trknmbr,1}(3,:);trackPoints{trknmbr,1}(4,:)]};
end


end