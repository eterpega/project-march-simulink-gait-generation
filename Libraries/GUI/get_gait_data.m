function [phaseEvent1, phaseEvent2, selected] = get_gait_data(handles)

conversionFactor=(pi()/180);
phase1=str2num(get(handles.keyEventPhaseKnee,'String')).*conversionFactor;
phase2=str2num(get(handles.keyEventPhaseX,'String')).*conversionFactor;
y1=str2num(get(handles.keyEventQKnee,'String')).*conversionFactor;
y2=str2num(get(handles.keyEventX,'String')).*conversionFactor;
dY1=str2num(get(handles.keyEventdQKnee,'String')).*conversionFactor;
dY2=str2num(get(handles.keyEventdYX,'String')).*conversionFactor;
selected=[0 1 1 0];

phaseEvent1=[phase1; y1; dY1];
phaseEvent2=[phase2; y2; dY2]
