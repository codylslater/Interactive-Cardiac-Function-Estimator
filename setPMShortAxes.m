function setPMShortAxes(src,~)
%SETPMSHORTAXES set the papillary short axis when user defines it

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

% Store the scale factor and the units information in the |Data|
% structure.
switch answer
    case 'End Diastole'
        measurements.A2.ED = mag*scale_factor;
    case 'End Systole'
        measurements.A2.ES = mag*scale_factor;
end

end
