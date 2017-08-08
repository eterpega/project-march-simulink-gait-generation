% Open old figures.
gu = open('10_Trim_RW_StairsUp_Right_Air_HipAngles.fig');
gu_ax = gca;
lu = open('10_Trim_RW_StairsUp_Right_Air_KneeAngles.fig');
lu_ax = gca;



F = figure; % New figure
P1 = subplot(2,1,2); % Plot a subplot.
P1_pos = get(P1,'position'); % get its position.
delete(P1) % Delete the subplot
P2 = subplot(2,1,1);
P2_pos = get(P2,'position');
delete(P2);
P = copyobj(gu_ax,F); % Copy the gu_ax to new fig
set(P,'position',P2_pos) % Set its position to the deleted subplot's position, duh!
P = copyobj(lu_ax,F);
set(P,'position',P1_pos) 