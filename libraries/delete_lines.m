%deletes all lines from the graph defined by input graphHandle


function delete_lines(graphHandle)
    %find all children of graph
    graphChildren = get(graphHandle, 'children');
    %select only line objects from children (to filter out impoint objects)
    lineHandle = findobj(graphChildren,'-depth',1,'Type','Line','Marker','none');
    
    %if there are line objects on the graph, delete them
    if ~isempty(lineHandle)
        delete(lineHandle);
    end
end
