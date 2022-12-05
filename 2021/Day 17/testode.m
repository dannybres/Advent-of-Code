%% day17puzzle1 - Daniel Breslan - Advent Of Code 2021
data = readlines("inputDemo.txt").erase(["target area: x="," y="]).replace("..",",").split(",").double();
close all
clc
% p = [0 0]
hold on
rectangle('Position',[data(1) data(3) abs(diff(data(1:2))) abs(diff(data(3:4)))])



[~,a] = ode45(@falling_brick, 0:2, [0, 0, 7, 2],[])

plot(a(:,1),a(:,2),'-x')
shg

function dydt = falling_brick(t,y)
dydt = zeros(4,1); %x po, y pos, x vel, y vel

position = y(1:2);
velocity = y(3:4);
dydt(1) = velocity(1); % integrate next step of velocity to get next position
dydt(2) = velocity(2); % integrate 9.81 to get next velocity
dydt(3) = -1;
dydt(4) = -1 % gravity

% if position(2) < 0
%   dydt = zeros(4,1);
% end

end