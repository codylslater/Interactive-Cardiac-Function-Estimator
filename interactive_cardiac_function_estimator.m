function [SV,EF,CO] = interactive_cardiac_function_estimator(HR,video_list)

% Set all required variables
global next_video;
global video;
global instructions;
global measurements;
global specified_units;
global scale_factor;
global calibration_set;
specified_units = 'pixels';
scale_factor = 1;
calibration_set = false;
next_video = true;
video = 1;

% Provide list of labels to overlay on video frames
instructions = string();
instructions(1) = sprintf(['Define Long Axis \n' ...
    'during Diastole and Systole \n']);
instructions(2) = sprintf(['Define Mitral Valve Short Axis \n' ...
    'during Diastole and Systole']);
instructions(3) = sprintf(['Define Papillary Muscle Short Axis \n' ...
    'during Diastole and Systole']);
instructions(4) = sprintf(['Define Apex Short Axis \n' ...
    'during Diastole and Systole']);

% Loop through all the videos that need to be labeled, wait for user to
% click on next video before showing next
while video <= 4
    if next_video == true
        eval_card_func(video_list);
        next_video = false;
    else
        pause(1);
        continue
    end
end

% Close figures when user exits last video
close all;

% Perform calculations with the measurements returned

% Calculate end diastolic volume using modified Simpson's rule
h_ED = measurements.L.ED/3;
A1 = pi*(measurements.A1.ED/2)^2;
A2 = pi*(measurements.A2.ED/2)^2;
A3 = pi*(measurements.A3.ED/2)^2;
EDV = (A1 + A2)*h_ED + ...
    (A3 * h_ED)/2 + (pi*h_ED^3)/6;

% Calculate end systolic volume using modified Simpson's rule
h_ES = measurements.L.ES/3;
A1 = pi*(measurements.A1.ES/2)^2;
A2 = pi*(measurements.A2.ES/2)^2;
A3 = pi*(measurements.A3.ES/2)^2;
ESV = (A1 + A2)*h_ES + ...
    (A3 * h_ES)/2 + (pi*h_ES^3)/6;

% Stroke volume
SV = EDV - ESV;
EF = SV/EDV;
CO = SV * HR;

display(SV)
display(EF)
display(CO)

end
