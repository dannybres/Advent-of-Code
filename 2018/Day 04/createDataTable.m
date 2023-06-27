function t = createDataTable(data)
out = regexp(data,"\[(.+)\] (.*)", 'tokens');
result = cellfun(@processData,out);
t = struct2table(result);
t = sortrows(t, "date");
end