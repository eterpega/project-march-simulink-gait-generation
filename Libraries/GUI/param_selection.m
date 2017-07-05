function [selected,type1,type2] = param_selection(handles)

%[angleHip, angleKnee, x, y]
contents = cellstr(get(handles.SelectionList,'String'));
selList=contents{get(handles.SelectionList,'Value')};

if strcmpi(selList,'Q Knee, X Foot')
    selected=[0, 1, 1, 0];
    type1='knee';
    type2='x';
    set(handles.keyEventPhaseHip, 'enable', 'off');
    set(handles.keyEventQHip, 'enable', 'off');
    set(handles.keyEventdQHip, 'enable', 'off');
    set(handles.keyEventPhaseKnee, 'enable', 'on');
    set(handles.keyEventQKnee, 'enable', 'on');
    set(handles.keyEventdQKnee, 'enable', 'on');
    set(handles.keyEventPhaseX, 'enable', 'on');
    set(handles.keyEventX, 'enable', 'on');
    set(handles.keyEventdYX, 'enable', 'on');
    set(handles.keyEventPhaseY, 'enable', 'off');
    set(handles.keyEventY, 'enable', 'off');
    set(handles.keyEventdYY, 'enable', 'off');
% elseif strcmpi(selList,'Q Hip, Q Knee');
%     selected=[1, 1, 0, 0];
%     type1='hip';
%     type2='knee';
%     set(handles.keyEventPhaseHip, 'enable', 'on');
%     set(handles.keyEventQHip, 'enable', 'on');
%     set(handles.keyEventdQHip, 'enable', 'on');
%     set(handles.keyEventPhaseKnee, 'enable', 'on');
%     set(handles.keyEventQKnee, 'enable', 'on');
%     set(handles.keyEventdQKnee, 'enable', 'on');
%     set(handles.keyEventPhaseX, 'enable', 'off');
%     set(handles.keyEventX, 'enable', 'off');
%     set(handles.keyEventdYX, 'enable', 'off');
%     set(handles.keyEventPhaseY, 'enable', 'off');
%     set(handles.keyEventY, 'enable', 'off');
%     set(handles.keyEventdYY, 'enable', 'off');
% elseif strcmpi(selList,'X Foot, Y Foot');
%     selected=[0, 0, 1, 1];
%     type1='x';
%     type2='y';s
%     set(handles.keyEventPhaseHip, 'enable', 'off');
%     set(handles.keyEventQHip, 'enable', 'off');
%     set(handles.keyEventdQHip, 'enable', 'off');
%     set(handles.keyEventPhaseKnee, 'enable', 'off');
%     set(handles.keyEventQKnee, 'enable', 'off');
%     set(handles.keyEventdQKnee, 'enable', 'off');
%     set(handles.keyEventPhaseX, 'enable', 'on');
%     set(handles.keyEventX, 'enable', 'on');
%     set(handles.keyEventdYX, 'enable', 'on');
%     set(handles.keyEventPhaseY, 'enable', 'on');
%     set(handles.keyEventY, 'enable', 'on');
%     set(handles.keyEventdYY, 'enable', 'on');
else
    msgbox('ERROR: Parameter selection is invalid','Error in param_selection')
end 