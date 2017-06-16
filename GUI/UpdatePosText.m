function UpdatePosText(h)
pos = round(getPosition(h),2,'significant');
PointNumber=char(get(h, 'Tag')); %Get tag of impoint for Order
PointNumber=PointNumber(2:2); % take only 
PointNumber=str2num(PointNumber);
setString(h,[num2str(pos(1)) ', ' num2str(pos(2))]);
wait(h);
setString(h,'');
end