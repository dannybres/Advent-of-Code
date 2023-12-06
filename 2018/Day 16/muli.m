function out = muli(ins,data)
out = data;
out(ins(4)+1) = prod(getVals("ri",ins,data));
end