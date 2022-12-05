data = readlines("inputDemo.txt")

data = data.split(" ")

d = data(:,2)
for idx = numel(d):-1:1
[mat,tok,ext] = regexp(d(idx),"x=(-*\d+)..(-*\d+),y=(-*\d+)..(-*\d+),z=(-*\d+)..(-*\d+)", 'match', ...
               'tokens', 'tokenExtents');
if any(tok{1}.double < -50 | tok{1}.double > 50)
    data(idx,:) = []
end
end

c = "foo(" + data(:,2).replace("..",":").replace(["x=","y=","z="],"") + ") = " + double(data(:,1) == "on")

eval(c.join(";"))