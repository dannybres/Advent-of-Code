function out = borr(ins,data)
out = data;
vals = getVals("rr",ins,data);
out(ins(4)+1) = bitor(vals(1), vals(2));
end