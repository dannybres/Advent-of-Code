function pl = powerLevel(sn)
[x,y] = meshgrid(1:300);
ID = x + 10;
pl = mod(floor((ID .* y + sn) .* ID./100),10) - 5;
end