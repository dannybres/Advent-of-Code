function out = gtir(ins,data)
out = data;
vals = getVals("ir",ins,data);
out(ins(4)+1) = vals(1) > vals(2);
end