data = readlines("input.txt");
data = data.split("");
data = data (:,2:end-1);

data = double(data);

day3puzzle1result = bin2dec(string(mode(data)).join(""))...
    * bin2dec(string(double(~mode(data))).join(""))