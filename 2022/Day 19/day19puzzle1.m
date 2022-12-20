%% day19puzzle1 - Daniel Breslan - Advent Of Code 2022
clc
tic
data = readlines("input.txt");
[~,blueprints] = regexp(data,"Blueprint \d+: Each ore robot costs" + ...
    " (\d+) ore. Each clay robot costs (\d+) ore. Each obsidian" + ...
    " robot costs (\d+) ore and (\d+) clay. Each geode robot" + ...
    " costs (\d+) ore and (\d+) obsidian.", 'match', ...
    'tokens'); % Parse input
blueprints = vertcat(blueprints{:});
blueprints = vertcat(blueprints{:});
global cache

results = zeros(1,height(blueprints));
for idx = 1:height(blueprints)
    blueprint.ore.ore = blueprints(idx,1).double; % Define ini conditions
    blueprint.clay.ore = blueprints(idx,2).double;
    blueprint.obsidian.ore = blueprints(idx,3).double;
    blueprint.obsidian.clay = blueprints(idx,4).double;
    blueprint.geode.ore = blueprints(idx,5).double;
    blueprint.geode.obsidian = blueprints(idx,6).double;

    maxVals.ore = max(blueprints(idx,[1 2 3 5]).double);
    maxVals.clay = blueprints(idx,4).double;
    maxVals.obsidian = blueprints(idx,6).double;
    maxVals.geode = Inf;

    %% t0
    resources.ore = 0;
    resources.clay = 0;
    resources.obsidian = 0;
    resources.geode = 0;

    robots.ore = 1;
    robots.clay = 0;
    robots.obsidian = 0;
    robots.geode = 0;

    tRemaining = 24;

    cache = dictionary(string.empty,double.empty);
    
    results(idx) = search(resources, robots, tRemaining, blueprint, ...
        maxVals);% run
    
end

day19puzzle1result = sum(results .* (1:numel(results)))
toc
function maxGeodes = search(resources, robots, tRemaining, blueprint, ...
    maxVals)
cKey = resources.ore + "_" + resources.clay + "_" + ...
    resources.obsidian + "_" + robots.ore + "_" + ...
    robots.clay + "_" + robots.obsidian + "_" + robots.geode +...
    "_" + tRemaining;
global cache
if isKey(cache,cKey)
    maxGeodes = cache(cKey);
    return
end
robotTypes = string(fieldnames(blueprint)); % What robots can you build?
robotsAvailableToBuild = robotTypes(1:min(4,(sum(cellfun(@(x)(robots.(x))...
    ,fieldnames(robots)) ~= 0)+1)));

maxGeodes = resources.geode;

% if robots.geode ~= 0
%     1
% end
if numel(robotsAvailableToBuild) == 0
    error("no robots to build")
end
for robIdx = 1:numel(robotsAvailableToBuild) % Next robot to build
    if robots.(robotsAvailableToBuild(robIdx)) == maxVals.( ...
            robotsAvailableToBuild(robIdx))
        continue
    end
    iresources = resources;
    irobots = robots;

    neededToBuildRobot = blueprint.(robotsAvailableToBuild(robIdx));
    resourcesNeeded = string(fieldnames(neededToBuildRobot));
    daysToWait = 0;
    for resIdx = 1:numel(resourcesNeeded) % loop res and calc longest wait
        totalNumberOfThisResourceNeeded = neededToBuildRobot...
            .(resourcesNeeded(resIdx));
        needToCollect = totalNumberOfThisResourceNeeded - ...
            iresources.(resourcesNeeded(resIdx));
        daysToWait = max(daysToWait, ceil(needToCollect/...
            irobots.(resourcesNeeded(resIdx))));
    end
    daysToWait = daysToWait + 1;
    if daysToWait < 1
        1
    end

    if tRemaining - daysToWait <= 0 % no time to bld the robot (cap time)
        maxGeodes = max(maxGeodes, iresources.geode + irobots.geode * ...
            tRemaining);
        continue
    end
    % update resources based on days waiting
    iresources.ore = iresources.ore + irobots.ore * daysToWait;
    iresources.clay = iresources.clay + irobots.clay * daysToWait;
    iresources.obsidian = iresources.obsidian + irobots.obsidian * 
    daysToWait;
    iresources.geode = iresources.geode + irobots.geode * daysToWait;

    for resIdx = 1:numel(resourcesNeeded) % remove resources
        totalNumberOfThisResourceNeeded = neededToBuildRobot...
            .(resourcesNeeded(resIdx));
        iresources.(resourcesNeeded(resIdx)) = iresources...
            .(resourcesNeeded(resIdx)) - ...
            totalNumberOfThisResourceNeeded;
    end
    irobots.(robotsAvailableToBuild(robIdx)) =... % build it
        irobots.(robotsAvailableToBuild(robIdx)) + 1;
    maxGeodes = max(maxGeodes, search(iresources, irobots, ...
        tRemaining - daysToWait, blueprint, maxVals));


end
cache(cKey) = maxGeodes;
end