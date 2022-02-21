function updateLabel(src,evt)
%UPDATELABEL Label is applied to each line after it is drawn

% Get the current line position.
pos = evt.Source.Position;

% Determine the length of the line.
diffPos = diff(pos);
mag = hypot(diffPos(1),diffPos(2));

% Choose a color from the colormap based on the length of the line. The
% line changes color as it gets longer or shorter.
color = src.UserData.Colormap(ceil(500*(mag/src.UserData.MaxValue)),:);

% Apply the scale factor to line length to calibrate the measurements.
mag = mag*src.UserData.ScaleFactor;

% Update the label.
set(src,'Label',[num2str(mag,'%30.1f') ' ' src.UserData.Units],'Color',color);

end