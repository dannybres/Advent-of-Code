fid = fopen('input.txt','rt');
fmt = repmat('%s',1,1);
M = textscan(fid,fmt,'Delimiter',',');
fclose(fid);
N = M{:};
earliest_departure = str2double(N{1});

earliest_bus = 0;
earliest_time = 0;

for i = 2:numel(N)
    if N{i} == 'x'
    else
        bus_id = str2double(N{i});
        t = earliest_departure;
        while mod(t,bus_id)
            t = t+1;
        end
        if earliest_bus == 0
            earliest_bus = bus_id;
            earliest_time = t;
        end
        if t < earliest_time
            earliest_bus = bus_id;
            earliest_time = t;
        end
    end
end
% Part 1
part1 = (earliest_bus) * (earliest_time - earliest_departure)
tic
% Part 2
t = 1;
K = cellfun(@str2double,(N(2:end)));
while ~check_pattern(t,K)
    t = t+1;
end
toc
function test = check_pattern(t,arr)
test = 0;
if numel(arr) == 1
    test = ~mod(t,arr(1));
    return
end
k = arr(1);
if isnan(k)
    t = t+1;
    test = check_pattern(t,arr(2:end));
else
    if ~mod(t,k)
        test = check_pattern(t+1,arr(2:end));
    end
end
end