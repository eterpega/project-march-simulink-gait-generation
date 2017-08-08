function delete_lines(graphHandle)

    graphChildren = get(graphHandle, 'children');
    lineHandle = findobj(graphChildren,'-depth',1,'Type','Line','Marker','none');
    if ~isempty(lineHandle)
        delete(lineHandle);
    end
end
