function deleteAll(src,~)
%DELETEALL Deletes all hROIs
%   Deletes all drawn lines when the user right clicks and selects

hFig = ancestor(src,'figure');
hROIs = findobj(hFig,'Type','images.roi.Line');
delete(hROIs)

end