function setApexShortAxes(src,~)
%SETAPEXSHORTAXES Store short axis value from apical view

% Access relevant variables
global measurements;
global scale_factor;

% Display the popup dialog box.
answer = questdlg(['Please indicate if this frame is at the end of ' ...
    'diastole or at the end of systole'], ...
	'Cardiac Cycle Selection', ...
	'End Diastole','End Systole','Go Back','Go Back');

% Get the length of the current line ROI.
hFig = ancestor(src,'figure');
hROIs = findobj(hFig,'Type','images.roi.Line');

pos = hROIs(1).Position;
diffPos = diff(pos);
mag = hypot(diffPos(1),diffPos(2));

% Calculate the scale factor by dividing the known length value by the
% current length, measured in pixels.
%scale = num/mag;

% Store the scale factor and the units information in the |Data|
% structure.
switch answer
    case 'End Diastole'
        measurements.A3.ED = mag*scale_factor;
    case 'End Systole'
        measurements.A3.ES = mag*scale_factor;
end

end
