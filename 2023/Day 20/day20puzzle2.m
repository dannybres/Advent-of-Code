%% day20puzzle2 - Daniel Breslan - Advent Of Code 2023
clc
data = readlines("input.txt");

bc = data(data.contains("broadcaster")).extractAfter(" -> ").split(", ");
data = data(~data.contains("broadcaster"));

data = [data.extract(1) data.extractAfter(1).split(" -> ")];

for idx = 1:height(data) % build devices
    d = data(idx,:);
    dev.(d(2)).type = d(1);
    dev.(d(2)).destination = d(3).split(", ");
    if dev.(d(2)).type == "%"
        dev.(d(2)).state = false;
    end
end

fn = string(fieldnames(dev));  % set state on conj per input
for idx = 1:numel(fn)
    thisDevice = dev.(fn(idx));
    if thisDevice.destination == "output"
        continue
    end
    for didx = 1:numel(thisDevice.destination)
        if ~fn.contains(thisDevice.destination(didx))
            continue
        end
        if dev.(thisDevice.destination(didx)).type == "&"
            dev.(thisDevice.destination(didx)).state.(fn(idx)) = false;
        end
    end
end
hc = 0;
lc = 0;
stop = false;

need = data(data(:,3).contains(data(data(:,3).contains("rx"),2)),2);
cycle = nan(numel(need),1);

buttonNum = 0;
while any(isnan(cycle))
    buttonNum = buttonNum + 1;
    lc = lc + 1;
    queue = {}; % built initial q from bc
    for idx = 1:numel(bc)
        queue = [queue {{"broadcaster" 0 bc(idx)}}];
    end
    while ~isempty(queue)
        job = queue{1};
        from = job{1} ;
        type = job{2};
        to = job{3};
        t = "low";
        if type
            t = "high";
        end
        if type
            hc = hc + 1;
        else
            lc = lc + 1;
        end
        queue(1) = [];

        if to == "output"
            continue
        end
        if ~fn.contains(to)
            continue
        end
        for cyid = 1:numel(cycle)
        if to == need(cyid) && ~type
            if isnan(cycle(cyid))
                cycle(cyid) = buttonNum;
            end
        end
        end
        switch dev.(to).type
            case "%"
                if ~type
                    dev.(to).state = ~dev.(to).state;
                    d = dev.(to).destination;
                    for idx = 1:numel(d)
                        queue = [queue {{to dev.(to).state d(idx)}}];
                    end
                end
            case "&"
                dev.(to).state.(from) = type;
                fnn = string(fieldnames(dev.(to).state));
                allHigh = true;
                for idx = 1:numel(fnn)
                    allHigh = allHigh && dev.(to).state.(fnn(idx));
                end
                d = dev.(to).destination;
                for idx = 1:numel(d)
                    queue = [queue {{to ~allHigh d(idx)}}];
                end

        end
    end

end

day20puzzle2result = lcm(lcm(lcm(cycle(1),cycle(2)),cycle(3)),cycle(4))%#ok<NOPTS>