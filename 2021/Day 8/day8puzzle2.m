%% day8puzzle1 - Daniel Breslan - Advent Of Code 2021
data = readtable("input.txt",TextType="string", ...
    ReadVariableNames=false);
data = data(:,[1:10 12:end]);
map = table((0:9)',["abcefg","cf","acdeg","acdfg","bcdf","abdfg", ...
    "abdefg","acf","abcdefg","abcdfg"]');
for didx = 1:height(data)
    t = table(string(('a':'g')'),repmat("",7,1));

    charsToCheck = char(data{didx,1:10}.join.erase(" "));
    dbl = [charsToCheck; charsToCheck];
    indexs = charsToCheck == ('a':'g')';
    lettersWithKnownLength = ["e","b","f","dg","ac"];
    knownLength = [4 6 9 7 8];
    for idx = 1:numel(knownLength)
        if lettersWithKnownLength(idx).strlength == 1
            letterFound = charsToCheck(find(indexs(sum(indexs,2) == ...
                knownLength(idx),:),1));
            t.Var2(t.Var1 == letterFound) = lettersWithKnownLength(idx);
        else
            t.Var2(any(t.Var1 == ...
                string(unique(dbl(indexs(sum(indexs,2) == knownLength(idx), ...
                :))))',2)) = lettersWithKnownLength(idx);
        end
    end
    CandF = data{didx,data{didx,1:10}.strlength() == 2}.split("");
    CandF = CandF(2:end-1);
    C = CandF(CandF ~= t{t.Var2 == "f",1});
    t.Var2(t.Var1 == C) = "c";
    t.Var2(t.Var2 == "ac") = "a";
    findD = data{didx,data{didx,1:10}.strlength() == 4}.split("");
    findD = findD(2:end-1);
    t.Var2(any(t.Var1 == findD',2) & t.Var2.strlength == 2) = "d";
    t.Var2(t.Var2 == "dg") = "g";

    for idx = 11:width(data)
        number = data{didx,idx}.split("");
        number = number(2:end-1)';
        data{didx,idx} = map.Var1(map.Var2 == ...
            t.Var2(any(t.Var1 == number,2)).sort.join(""));
    end
end
day8puzzle1result = sum(double(data{:,end-3:end}.join("")))