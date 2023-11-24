function out = visualise(in)
x = in(:,1);
y = in(:,2);
x = x - min(x) + 1;
y = y - min(y) + 1;
out = repmat(' ',max(y),max(x));
idx = sub2ind(size(out),y,x);
out(idx) = '#';
end