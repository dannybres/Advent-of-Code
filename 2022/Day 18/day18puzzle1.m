%% day18puzzle1 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").split(",").double();
adder = reshape([-1 0 0;1 0 0;0 -1 0;0 1 0;0 0 -1;0 0 1]',1,3,[]);
neighbours = permute(data + adder,[3,2,1]);
neighbours = reshape(pagetranspose(neighbours),3,[])';

day18puzzle1result = sum(~ismember(neighbours,data,"rows")) %#ok<NOPTS> 
