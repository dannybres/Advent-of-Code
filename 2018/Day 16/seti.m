function out = seti(ins,data)
out = data;
out(ins(4)+1) = getVals("i",ins,data);
end