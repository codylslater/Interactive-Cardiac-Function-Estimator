function updateUnits(src,evt)
%UPDATEUNITS When the calibration is set, update all labels from then on

% Access relevant variables
global calibration_set;
global specified_units;
global scale_factor;

% When you double-click the ROI label, the example opens a popup dialog box
% to get information about the actual distance. Use this information to
% scale all line ROI measurements.
if strcmp(evt.SelectionType,'double') && strcmp(evt.SelectedPart,'label') ...
        && calibration_set == false

    % Display the popup dialog box.
    answer = inputdlg({'Known distance','Distance units'},...
        'Specify known distance',[1 20],{'5','cm'});

    % Determine the scale factor based on the inputs.
    num = str2double(answer{1});

    % Get the length of the current line ROI.
    pos = src.Position;
    diffPos = diff(pos);
    mag = hypot(diffPos(1),diffPos(2));

    % Calculate the scale factor by dividing the known length value by the
    % current length, measured in pixels.
    scale = num/mag;

    % Store the scale factor and the units information in the |Data|
    % structure.
    Data.Units = answer{2};
    Data.MaxValue = src.UserData.MaxValue;
    Data.Colormap = src.UserData.Colormap;
    Data.ScaleFactor = scale;

    % Reset the data stored in the |UserData| property of all existing line
    % ROI objects. Use |findobj| to find all line ROI objects in the axes.
    hAx = src.Parent;
    hROIs = findobj(hAx,'Type','images.roi.Line');
    set(hROIs,'UserData',Data);

    % Update the label in each line ROI object, based on the information
    % collected in the input dialog.
    for i = 1:numel(hROIs)

        pos = hROIs(i).Position;
        diffPos = diff(pos);
        mag = hypot(diffPos(1),diffPos(2));

        set(hROIs(i),'Label',[num2str(mag*scale,'%30.1f') ' ' answer{2}]);

    end

    % Reset the |ButtonDownFcn| callback function with the current |Data|
    % value.
    hIm = findobj(hAx,'Type','image');
    hIm.ButtonDownFcn = @(~,~) startDrawing(hAx,Data);

    calibration_set = true;
    specified_units = Data.Units;
    scale_factor = Data.ScaleFactor;
end

end