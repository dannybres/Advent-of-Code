%% day3puzzle2 - Daniel Breslan - Advent Of Code 2023
clc
data = char(readlines("input.txt"));
data = char(padarray(double(data),[1 1],double('.')));
allChars = unique(data(:));
allChars = double(allChars);
allChars = allChars(allChars ~= double('.'));
numbers = any(data == permute(char(double('0'):double('9'))', ...
    [3 2 1]),3);
gears = find(data == '*');
n = nan(numel(gears),1);
res = 0;
for idx = 1:numel(gears)
    [r,c]=ind2sub(size(data),gears(idx));
    isn = false(5,3);
    isn(1:2:end,:) = numbers(r+(-1:1), c+(-1:1));
    o = bwconncomp(isn);
    n(idx) = o.NumObjects;
    if o.NumObjects == 2
        isn = false(5,3);
        for cidx = 1:2
            isn(o.PixelIdxList{cidx}(1)) = 1;
        end
        isn = isn(1:2:end,:);
        [ri,ci] = ind2sub([3 3],find(isn));
        ri = ri + r - 2;
        ci = ci + c - 2;
        n1 = data(ri(1),ci(1));
        n2 = data(ri(2),ci(2));
        sh = ones(1,4);
        for idx = 1:2
            if any(data(ri(1),ci(1)-sh(1)) == char(double('0'):double('9')))
                n1 = [data(ri(1),ci(1)-sh(1)) n1];
                sh(1) = sh(1) + 1;
            end
            if any(data(ri(1),ci(1)+sh(2)) == char(double('0'):double('9')))
                n1 = [n1 data(ri(1),ci(1)+sh(2))];
                sh(2) = sh(2) + 1;
            end
            if any(data(ri(2),ci(2)-sh(3)) == char(double('0'):double('9')))
                n2 = [data(ri(2),ci(2)-sh(3)) n2];
                sh(3) = sh(3) + 1;
            end
            if any(data(ri(2),ci(2)+sh(4)) == char(double('0'):double('9')))
                n2 = [n2 data(ri(2),ci(2)+sh(4))];
                sh(4) = sh(4) + 1;
            end
        end
    res = res + prod([string(n1).double,string(n2).double]);
    if isnan(res)
        % disp(1)
    end
    end
end
day3puzzle2result = res %#ok<NOPTS>
