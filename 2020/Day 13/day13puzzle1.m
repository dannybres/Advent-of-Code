data = readlines("input.txt")
time = data(1).double();
buses = data(2).split(",");
buses(buses == "x") = [];
buses = buses.double();

finalTime = max(buses) + time;

t = table((time:finalTime)',VariableNames="time");
t = [t array2table(false(height(t), numel(buses)))];
t.Properties.VariableNames(2:end) = "bus " + buses;

nextBusTime = Inf;
id = 0;
for idx = 1:numel(buses)
    times = 0:buses(idx):finalTime;
    t{:,idx+1} = any(t.time == times,2);
end
head(t)
rowOfFirst = find(any(t{:,2:end},2),1,'first');
timeofBus = t.time(rowOfFirst);
name = t.Properties.VariableNames{t{rowOfFirst,:} == 1};
bus = str2double(name(5:end));

bus * (timeofBus - time)