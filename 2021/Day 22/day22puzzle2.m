data = readlines("inputDemo.txt");
% minR = -50;
% maxR = 50;

data = data.split(" ");

d = data(:,2);
ins = data(:,1);
[mat,tok,ext] = regexp(d,"x=(-*\d+)..(-*\d+),y=(-*\d+)..(-*\d+),z=(-*\d+)..(-*\d+)", 'match', ...
               'tokens', 'tokenExtents');
t = [tok{:}];
t = t';
t = reshape([t{:}],6,[]).double';

% ins = ins(all([t(:,1:2:end)<maxR t(:,2:2:end) > minR],2));
% t = t(all([t(:,1:2:end)<maxR t(:,2:2:end) > minR],2),:);

t = t - repelem(min(t(:,1:2:end)),1,2) + 1;

foo = zeros(max(t(:,2:2:end)));
f = "foo(%d:%d,%d:%d,%d:%d) = ";
eval(join(compose(f,t) + double(ins == "on"),";")+";");

sum(foo,'all')