data = readmatrix("input.txt");

results = data + data' == 2020;

[r,c] = find(tril(results,-1));

day1puzzle1result = data(r) * data(c)