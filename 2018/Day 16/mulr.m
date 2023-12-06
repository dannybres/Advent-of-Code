function out = mulr(ins,data)
out = data;
out(ins(4)+1) = prod(getVals("rr",ins,data));
end