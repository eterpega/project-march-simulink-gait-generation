function [angleHip, angleKnee, x, y, foot] = drawsplineGUI(handles)
[keyEvent1, keyEvent2, selected] = get_gait_data(handles);
[angleHip, angleKnee, x, y, foot] = drawspline(keyEvent1, keyEvent2, selected);