%% day24puzzle1 - Daniel Breslan - Advent Of Code 2023
clc
data = readlines("input.txt").replace(" @",",").split(", ").double

a = data(:,5)./data(:,4);
c = data(:,2) - a.*data(:,1);
b = -1*ones(size(c));

TA = [200000000000000 400000000000000];

t = 0;
for l1 = 1:numel(a)
    for l2 = 1:numel(a)
        [x,y] = intersect(a([l1 l2]),b([l1 l2]),c([l1 l2]));
        if x >= TA(1) && y >= TA(1) && x <= TA(2) && y <= TA(2)
            % t = t + 1;
            if all((diff([data(l1,1:2);x y]) > 0) == (data(l1,4:5) > 0)) && all((diff([data(l2,1:2);x y]) > 0) == (data(l2,4:5) > 0))
                t = t+1;
                % disp(compose("%s and %s intersect at %.2f,%.2f",...
                    % des(data,l1),des(data,l2),x,y))
            end
        end
    end
end

day24puzzle1result = t/2

function [x, y] = intersect(a,b,c)
x = (b(1)*c(2)-b(2)*c(1))/(a(1)*b(2)-a(2)*b(1));
y = (a(2)*c(1)-a(1)*c(2))/(a(1)*b(2)-a(2)*b(1));
end

function out = des(d,idx)
out = compose("%i [%i,%i @ %i,%i]",...
    idx,d(idx,1),d(idx,2),d(idx,4),d(idx,5));
end
