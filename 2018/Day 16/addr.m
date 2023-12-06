function out = addr(ins,data)
out = data;
out(ins(4)+1) = sum(getVals("rr",ins,data));
end