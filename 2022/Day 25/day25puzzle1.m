%% day25puzzle1 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt");

res = nan(size(data));
for idx = 1:numel(data)
    res(idx) = snafu2dec(data(idx));
end

total = sum(res);
day25puzzle1result = dec2snafu(total)

function snafu = dec2snafu(dec)
snafu = "";
while dec ~= 0
    quo = floor(dec/5);
    re = rem(dec,5);
    if re > 2
        quo = quo + 1;
        if re == 3
            re = "=";
        else
            re = "-";
        end
    end
    dec = quo;
    snafu = re + snafu;
end
end

function dec = snafu2dec(snafu)
snafu = snafu.replace(["2","1","0","-","="],...
    ["2,","1,","0,","-1,","-2,"]);
ele = snafu.split(",");
ele = flipud(ele(1:end-1).double);
mul = 5.^(0:numel(ele)-1)';
dec = sum(ele .* mul);
end