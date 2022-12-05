data = readmatrix("input.txt");

[x,y,z]=meshgrid(data,data,data);

idx = find(x+y+z == 2020);

day1puzzle2Result = x(idx(1)) * y(idx(1)) * z(idx(1))
