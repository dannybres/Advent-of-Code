function out = gtri(ins,data)
out = data;
vals = getVals("ri",ins,data);
out(ins(4)+1) = vals(1) > vals(2);
end