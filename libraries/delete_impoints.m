function delete_impoints(graphHandle)

    graphChildren = get(graphHandle, 'children');
    impointHandle = findobj(graphChildren,'-depth',1,'-not','Type','Line');
    if ~isempty(impointHandle)
        delete(impointHandle);
    end
end
