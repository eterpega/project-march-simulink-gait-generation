function [phaseEvent1, phaseEvent2, selected] = get_gait_data(handles)

phase1=str2num(get(handles.keyEventPhaseKnee,'String'));
phase2=str2num(get(handles.keyEventPhaseX,'String'));
y1=str2num(get(handles.keyEventQKnee,'String'));
y2=str2num(get(handles.keyEventX,'String'));
dY1=str2num(get(handles.keyEventdQKnee,'String'));
dY2=str2num(get(handles.keyEventdYX,'String'));
selected=[0 1 1 0];

phaseEvent1=[phase1; y1; dY1];
phaseEvent2=[phase2; y2; dY2];
