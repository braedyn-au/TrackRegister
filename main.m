% Take points from Trackmate, register them to super res image, and then
% overlay
% Braedyn Au August 2019
% ---------------------------------------------------------------------
% Load the XML file using parseXML and extractpoints functions
% Load the image using loadimage function
% In main.m select or input fiducial points
% Calculate tform matrix from input movingpoints and fixedpoints
% Register tracks using transformPointsForward function
% Plot the image with tracks overlayed with overlay function

% TODO
% ---------------------------------------------------------------------
% Add UI to load tracks and image, and select fiducials directly on the
% image --DONE
% Add time scaled rainbow tracks --DONE
% Fix brightness/contrast scaling on imshow with tifs --Use jpgs
% Drift correction on tracks -- in Trackmate?
% ---------------------------------------------------------------------

% INPUT FIDUCIAL POINTS
% ---------------------------------------------------------------------
% Instead of using the UI in MATLAB to select fiducial points, which can 
% be innacurate, you can find the points in the localization list first and
% input them as variables.

disp("Select XML file");
[xmlfile, tracksxmlpath] = uigetfile('*.xml','Load XML file');
disp("Loading XML file...");
tracks = parseXML(fullfile(tracksxmlpath,xmlfile));
conversion = input('Track unit conversion factor to pixels(tracks may not be in pixel units): ');
trackPoints = extractpoints(tracks,conversion);

disp("Select image file");
[imgfile, imgpath] = uigetfile({'*.tif;*.jpg;*.png'}, 'Load Image');
disp("Loading image...");
img = loadimage(fullfile(imgpath,imgfile));

choice = "";
while ~strcmp(choice,"select")&&~strcmp(choice,"input")
    disp("Choose fiducial coordinate input type by typing your choice: input/select");
    choice = input('-> ', 's');
    %choice = string(choice);
    if choice == "select"
        disp("Select fidcials on super res image");
        disp("Press return/enter when done");
        overlay(trackPoints,imcomplement(img));
        [fixedx,fixedy] = ginput;
        close;
        disp('Super Res Fiducial [x y] points');
        disp([fixedx,fixedy]);

        disp("Select fiducials on tracks");
        disp("Press return/enter when done");
        overlay(trackPoints,imcomplement(img));
        %ntracks = size(trackPoints,1);
        % minimum 3 points
        %for trknmbr = 1:ntracks
        %    detections = size(trackPoints{trknmbr,1}(1,:),2);
        %    if (detections > 2)
        %        xplot = trackPoints{trknmbr,1}(1,:);
        %        yplot = trackPoints{trknmbr,1}(2,:);
        %        tplot = trackPoints{trknmbr,1}(4,:);
                %plot(trackPoints{trknmbr,1}(1,:),trackPoints{trknmbr,1}(2,:),'color', cc(trknmbr,:));
        %        p = patch([xplot NaN],[yplot NaN], [tplot NaN], 'EdgeColor', 'interp');
                %rainbowplot(xplot,yplot)
        %        hold on
        %    end
        %end 
        %h = colorbar;
        %ylabel(h,'Time (frames)');

        [movingx,movingy] = ginput;
        close;
        disp('Track Fiducial [x y] points');
        disp([movingx,movingy]);
        break
    elseif choice == "input"
        disp('Input coordinates of fiducials on super res image: ');
        fixedx = transpose(input('Img X coordinates in []: '));
        fixedy = transpose(input('Img Y coordinates in []: '));
       
        disp('Input coordinates of fiducials on tracks: ');
        movingx = transpose(input('Tracks X coordinates in []: '));
        movingy = transpose(input('Tracks Y coordinates in []: '));
        %transpose(movingx);
        %transpose(movingy);
        break
        break
    else
        continue
    end
    
end
disp('Registering')
regPoints = register(trackPoints,[movingx,movingy],[fixedx,fixedy]);

overlay(regPoints,img);



