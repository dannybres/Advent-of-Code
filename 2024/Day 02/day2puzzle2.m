%% day2puzzle2 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt");
day2puzzle1result = 0;
day2puzzle2result = 0;
for idx = 1:numel(data)
    report = double(data(idx).extract(digitsPattern));
    day2puzzle1result = day2puzzle1result + isSafe(report);
    for pdIdx = 1:numel(report)
        dampedReport = report;
        dampedReport(pdIdx) = [];
        isDRSafe = isSafe(dampedReport);
        day2puzzle2result = day2puzzle2result + isSafe(dampedReport);
        if isDRSafe
            break
        end
    end
end

day2puzzle1result
day2puzzle2result

function result = isSafe(report)
arguments
    report (:,1) {mustBeNumeric}
end
deltas = diff(report);
result = double((all(deltas < 0) | all(deltas > 0)) & all(abs(deltas) <= 3));
end

day2puzzle1result = 0;
