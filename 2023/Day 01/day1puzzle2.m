%% day1puzzle2 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt");
day1puzzle1result = sum(arrayfun(@getNums,data)) %#ok<NOPTS> 

function out = getNums(data)
ogdata = data;
idx =sort([regexp(data, "one") regexp(data, "two") regexp(data, "three")...
    regexp(data, "four") regexp(data, "five") regexp(data, "six") ...
    regexp(data, "seven") regexp(data, "eight") regexp(data, "nine") ...
    regexp(data,string(1:9).join("|"))]);
idx = idx([1 end]);
start = repmat(data,1,2).extract(idx);
areNum = ~cellfun(@isempty,regexp(start,"\d"));
nums = repmat("",1,2);
nums(areNum) = start(areNum);
for nidx = find(nums == "")
    nums(nidx) = ogdata.extractBetween(idx(nidx),idx(nidx)+2).replace(...
        ["one", "two", "thr", "fou", "fiv", "six", "sev", "eig", "nin", ...
        "ten"],...
        string(1:10));
end
out = nums.join("").double;
end