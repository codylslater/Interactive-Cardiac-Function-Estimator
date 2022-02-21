function eval_card_func(video_list)

% Access relevant variables
global video;

% Load the corresponding video (1-4)
vid = VideoReader(string(video_list(video)));

% Pass video frames to videofig function (downloaded from matlab
% central) and redraw function which will allow us to make our
% measurements
videofig(vid.NumberOfFrames, @(frm) redraw(frm, vid));
redraw(1, vid);
end