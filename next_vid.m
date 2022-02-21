function next_vid(src,~)
%NEXT_VID Update to next video for annotation
%   User selects 'next video' option in menu when they are ready to
%   annotate the images from the next video in the queue

% Access relevant variables
global next_video;
global video;

% Update to the next video and set the flag to true
next_video = true;
video = video + 1;

end