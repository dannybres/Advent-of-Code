% day19puzzle1 - Daniel Breslan - Advent Of Code 2022
% profile on
clear
data = readlines("input.txt");
[~,blueprints] = regexp(data,"Blueprint \d+: Each ore robot costs" + ...
    " (\d+) ore. Each clay robot costs (\d+) ore. Each obsidian" + ...
    " robot costs (\d+) ore and (\d+) clay. Each geode robot" + ...
    " costs (\d+) ore and (\d+) obsidian.", 'match', ...
    'tokens'); % Parse input
blueprints = vertcat(blueprints{:});
blueprints = vertcat(blueprints{:});
tic
results = zeros(1,height(blueprints));
for idx = 1:height(blueprints)
    blueprint{1} = [blueprints(idx,1).double 0 0 0];
    blueprint{2} = [blueprints(idx,2).double 0 0 0];
    blueprint{3} = [blueprints(idx,3).double blueprints(idx,4).double 0 0];
    blueprint{4} = [blueprints(idx,5).double 0 blueprints(idx,6).double 0];

    maxVals = [max(blueprints(idx,[1 2 3 5]).double) ...
        blueprints(idx,4).double ...
        blueprints(idx,6).double ...
        Inf];

    resources = zeros(1,4);
    robots = [1 0 0 0];
    tRemaining = 24;

    results(idx) = search(resources, robots, tRemaining, blueprint, ...
        maxVals, 0);% run
end

day19puzzle1result = sum(results .* (1:numel(results)))
toc
% profile viewer

function maxGeodes = search(resources, robots, tRemaining, blueprint, ...
    maxVals, maxGeodesSoFar)

maxGeodes = resources(end);

if maxGeodesSoFar >= resources(end) + (robots(end) * tRemaining)...
        + ((tRemaining * (tRemaining-1)) / 2)
    return
end

robotsAvailableToBuild = min(4,nnz(robots)+1);

for robIdx = robotsAvailableToBuild(end):-1:1 % Next robot to build
    if robots(robIdx) == maxVals(robIdx)
        continue
    end
    iresources = resources;
    irobots = robots;
    neededToBuildRobot = blueprint{robIdx};

    daysToWait = 0;
    
    for resIdx = 1:numel(neededToBuildRobot) % loop res and calc longest wait
        if neededToBuildRobot(resIdx) == 0
            continue
        end
        totalNumberOfThisResourceNeeded = neededToBuildRobot(resIdx);
        needToCollect = totalNumberOfThisResourceNeeded - ...
            iresources(resIdx);
        daysToWait = max(daysToWait, ceil(needToCollect/irobots(resIdx)));
    end
    daysToWait = daysToWait + 1;

    if tRemaining - daysToWait <= 0 % no time to bld the robot (cap time)
        maxGeodes = max(maxGeodes, iresources(end) + irobots(end) * ...
            tRemaining);
        continue
    end
    % update resources based on days waiting
    iresources = iresources + irobots * daysToWait;

    % remove resources to build
    iresources = iresources - neededToBuildRobot;
    
    % build it
    irobots(robIdx) = irobots(robIdx) + 1;
    maxGeodes = max(maxGeodes, search(iresources, irobots, ...
        tRemaining - daysToWait, blueprint, maxVals, maxGeodes));
end
end