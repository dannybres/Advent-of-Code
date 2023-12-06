function out = banr(ins,data)
out = data;
vals = getVals("rr",ins,data);
out(ins(4)+1) = bitand(vals(1), vals(2));
end