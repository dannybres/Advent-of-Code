%% day3puzzle1 - Daniel Breslan - Advent Of Code 2023
data = char(readlines("input.txt"));
allChars = unique(data(:));
allChars = double(allChars);
allChars = allChars(allChars ~= double('.'));

symbols = any(data == permute( ...
    char(allChars(allChars < double('0') | allChars > double('9'))), ...
    [3 2 1]),3);
numbers = any(data == permute(char(double('0'):double('9'))', ...
    [3 2 1]),3);

c = ones(3);
c(5) = 0;
symbolNeighbour = conv2(symbols,c,'same');
res = repmat(' ',size(data));
toProcess = symbolNeighbour & numbers;
for idx = 1:height(toProcess)
    res(idx,toProcess(idx,:)) = data(idx,toProcess(idx,:));
    for x = 1:3
        tp = padarray(res(idx,:) ~= ' ',[0 1]);
        n = padarray(numbers(idx,:),[0 1]);
        for cidx = 2:width(tp)-1
            if(any(tp(cidx + [-1 1])) && n(cidx))
                res(idx,cidx-1) = data(idx,cidx-1);
            end
        end
    end
end
res = [res repmat(' ',height(res),1)];
res = res';
res = string(res(:)');
res = res.split(" ");
day3puzzle1result = sum(res(res~="").double) %#ok<NOPTS>