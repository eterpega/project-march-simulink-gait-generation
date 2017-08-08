function st = cell2str(cellStr)
     [m,n]=size(cellStr);
     st='';
     for iter=1:n
        st = strcat(st,cellStr{1,iter},'\n');  %# Convert to string
     end
        st(end-1:end) = []; %# Remove last ','
 end