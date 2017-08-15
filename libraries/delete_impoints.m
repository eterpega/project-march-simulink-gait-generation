%deletes all impoints (by searching for objects that are not "Line")
%from the graph defined by input graphHandle

function delete_impoints(graphHandle)

    %find all children of graph
    graphChildren = get(graphHandle, 'children');
    %select only impoint objects from children (by searching for objects
    %that are not 'line'
    impointHandle = findobj(graphChildren,'-depth',1,'-not','Type','Line');
    
    %if there are impoint objects on the graph, delete them
    if ~isempty(impointHandle)
        delete(impointHandle);
    end
end
