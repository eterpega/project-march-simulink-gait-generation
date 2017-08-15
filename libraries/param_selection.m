%enable or disable editing of text fields based on the parameter selection
%(upper right corner in the GUI).
%type1 & type2 are used to determine which graphs have to be updated
%(draw points are draw splines) 
%clearGraph1 & clearGraph2 represents the handles of the graphs that are 
%not editable and thus have to be cleared of draggable points
%selected is a vector way of representing the parameter selection and is 
%used for determining the 2 determinant splines.

function [selected,type1,type2,clearGraph1,clearGraph2] = param_selection(handles)
%handles=handles of all object in GUI

%Determine the parameter selection selected
contents = cellstr(get(handles.SelectionList,'String'));
selList=contents{get(handles.SelectionList,'Value')};

%Compare selList value to string and enable/disable relevant text
%fields/graphs accordingly

if strcmpi(selList,'Q Knee, X Foot')
    selected=[0, 1, 1, 0];
    type1='knee';
    type2='x';
    clearGraph1=handles.graphQHip;
    clearGraph2=handles.graphY;
    set(handles.keyEventPhaseHip, 'enable', 'off');%disable editing of Phase field of QHip
    set(handles.keyEventQHip, 'enable', 'off');
    set(handles.keyEventdQHip, 'enable', 'off');
    set(handles.keyEventPhaseKnee, 'enable', 'on');%enable editing of Phase field of QKnee
    set(handles.keyEventQKnee, 'enable', 'on');
    set(handles.keyEventdQKnee, 'enable', 'on');
    set(handles.keyEventPhaseX, 'enable', 'on');
    set(handles.keyEventX, 'enable', 'on');
    set(handles.keyEventdYX, 'enable', 'on');
    set(handles.keyEventPhaseY, 'enable', 'off');
    set(handles.keyEventY, 'enable', 'off');
    set(handles.keyEventdYY, 'enable', 'off');
elseif strcmpi(selList,'Q Hip, Q Knee');
    selected=[1, 1, 0, 0];
    type1='hip';
    type2='knee';
    clearGraph1=handles.graphX;
    clearGraph2=handles.graphY;
    set(handles.keyEventPhaseHip, 'enable', 'on');
    set(handles.keyEventQHip, 'enable', 'on');
    set(handles.keyEventdQHip, 'enable', 'on');
    set(handles.keyEventPhaseKnee, 'enable', 'on');
    set(handles.keyEventQKnee, 'enable', 'on');
    set(handles.keyEventdQKnee, 'enable', 'on');
    set(handles.keyEventPhaseX, 'enable', 'off');
    set(handles.keyEventX, 'enable', 'off');
    set(handles.keyEventdYX, 'enable', 'off');
    set(handles.keyEventPhaseY, 'enable', 'off');
    set(handles.keyEventY, 'enable', 'off');
    set(handles.keyEventdYY, 'enable', 'off');
elseif strcmpi(selList,'X Foot, Y Foot');
    selected=[0, 0, 1, 1];
    type1='x';
    type2='y';
    clearGraph1=handles.graphQHip;
    clearGraph2=handles.graphQKnee;
    set(handles.keyEventPhaseHip, 'enable', 'off');
    set(handles.keyEventQHip, 'enable', 'off');
    set(handles.keyEventdQHip, 'enable', 'off');
    set(handles.keyEventPhaseKnee, 'enable', 'off');
    set(handles.keyEventQKnee, 'enable', 'off');
    set(handles.keyEventdQKnee, 'enable', 'off');
    set(handles.keyEventPhaseX, 'enable', 'on');
    set(handles.keyEventX, 'enable', 'on');
    set(handles.keyEventdYX, 'enable', 'on');
    set(handles.keyEventPhaseY, 'enable', 'on');
    set(handles.keyEventY, 'enable', 'on');
    set(handles.keyEventdYY, 'enable', 'on');
else
    %Give error
    msgbox('ERROR: Parameter selection is invalid','Error in param_selection')
end 