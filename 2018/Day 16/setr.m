function out = setr(ins,data)
out = data;
out(ins(4)+1) = getVals("r",ins,data);
end