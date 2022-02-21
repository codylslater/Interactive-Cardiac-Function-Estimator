function redraw(frame, vidObj)
%REDRAW Update frames and interactive measurements 
%   Redraw the relevant frames and interactive ROIs drawn by user when the
%   user scrolls through the video frames

% Access relevant variables
global calibration_set;
global specified_units;
global scale_factor;
global video;
global instructions;

% Read the next frame in the video
f = vidObj.read(frame);

% Data from this image stored as a structure that will be passed to
% callback functions
sz = size(f);
Data.MaxValue = hypot(sz(1),sz(2));
Data.Colormap = hot;

if calibration_set == false
    Data.Units = 'pixels';
    Data.ScaleFactor = 1;
else
    Data.Units = specified_units;
    Data.ScaleFactor = scale_factor;
end

% Show image in an axes
hIm = imshow(f); hold on
text(75,100, instructions(video),'color','white','FontSize',16);
%hold off


% Callback function for the image - pass structure data from above to
% function
hIm.ButtonDownFcn = @(~,~) startDrawing(hIm.Parent,Data);

end