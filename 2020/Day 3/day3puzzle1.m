data = readlines("input.txt");
data = data.split("");
data = data(:,2:end-1);
startPosition = [1 1];
routes = [1 1; 1 3; 1 5; 1 7; 2 1]';

trees = zeros(1,size(routes,2))
for idx = 1:size(routes,2)
    route = routes(:,idx)';

    stepsNeeded = ceil((size(data,1) -startPosition(1))/ route(1));

    widthNeeded = stepsNeeded * route(2);

    dataForIdx = repmat(data, 1, ceil(widthNeeded/size(data,2)));

    steps = cumsum([startPosition;repmat(route, stepsNeeded,1)]);

    trees(idx) = sum(dataForIdx(sub2ind(size(dataForIdx), ...
        steps(:,1),steps(:,2))) == "#")
end

format long g
day3puzzle2result = prod(trees)
format short