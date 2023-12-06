function out = gtrr(ins,data)
out = data;
vals = getVals("rr",ins,data);
out(ins(4)+1) = vals(1) > vals(2);
end