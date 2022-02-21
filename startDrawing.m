function startDrawing(hAx,Data)
%STARTDRAWING Listen for updates to the image and run appropriate functions

% Create a line ROI object.
h = images.roi.Line('Color',[0, 0, 0.5625],'UserData',Data);

% Set up a listener for movement of the line ROI. 
addlistener(h,'MovingROI',@updateLabel);

% Set up a listener for clicks on the line ROI. 
addlistener(h,'ROIClicked',@updateUnits);

% Get the current mouse location from the |CurrentPoint| property of the
% axes and extract the _x_ and _y_ coordinates.
cp = hAx.CurrentPoint;
cp = [cp(1,1) cp(1,2)];

% Begin drawing the ROI from the current mouse location. 
h.beginDrawingFromPoint(cp);

% Add a custom option to the line ROI context menu
c = h.UIContextMenu;
uimenu(c,'Label','Delete All','Callback',@deleteAll);
uimenu(c,'Label','Define Long Axis','Callback',@setLongAxes);
uimenu(c,'Label','Define Mitral Valve Short Axis','Callback',@setMVShortAxes);
uimenu(c,'Label','Define Papillary Muscle Level Short Axis','Callback',@setPMShortAxes);
uimenu(c,'Label','Define Apex Short Axis','Callback',@setApexShortAxes);
uimenu(c,'Label','Next Video','Callback',@next_vid);

end