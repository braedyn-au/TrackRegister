function overlayed = overlay(regPoints,img)
%OVERLAY overlays tracks onto super res image
% Braedyn Au
% Rainbow lines does not seem to work when overlayed on the grayscale
% image :( ---FIXED
% Convert the grayscale image to pseudo rgb
% The 'EdgeColor' only goes from blue to yellow, try to find another way to
% plot rainbows or just use solid colours 
ntracks = size(regPoints,1);

if size(img,3) == 1
    img = cat(3,img,img,img);
end 
imshow(img);
hold on
for trknmbr = 1:ntracks
    detections = size(regPoints{trknmbr,1}(1,:),2);
    if (detections > 2)
        xplot = regPoints{trknmbr,1}(1,:);
        yplot = regPoints{trknmbr,1}(2,:);
        tplot = regPoints{trknmbr,1}(4,:);
        % Use the plot function to use solid colours 
        %plot(regPoints{trknmbr,1}(1,:),regPoints{trknmbr,1}(2,:),'color', cc(trknmbr,:));
        p = patch([xplot NaN],[yplot NaN],[tplot NaN], 'EdgeColor', 'interp');
        h = colorbar;
        %rainbowplot(xplot,yplot)
        hold on
    end


ylabel(h,'Time (frames)');

end


