data = readlines("inputDemo.txt").extractAfter(": ").double();
states = zeros(10,22,2); % square, score, player
states(data(1),1,1) = 1;
states(data(2),1,2) = 1;

c = sum(combinations(1:3,1:3,1:3).Variables,2)

cNums = min(c):max(c);
cCounts = sum(c == cNums);
for daniel = 1:2
% while sum(states(:,end,1)) == 0
[r,c] = find(states(:,:,1));
p1 = zeros(10,22);
for idx = 1:numel(r)
     for cidx = 1:numel(cNums)
         moveTo = mod(r(idx) + cNums(cidx),10);
         moveTo(moveTo == 0) = 10;
         newScore = c(idx)-1 + moveTo;
         p1(moveTo,newScore + 1) = p1(moveTo,newScore + 1) + states(r(idx),c(idx),1) * cCounts(cidx);
     end
end
states(:,:,1) = p1;
disp("Round: " + daniel)
disp(array2table(states(:,:,1),RowNames="p" + (1:10),VariableNames="s" + (0:21)))
sum(states(:,:,1),"all")
sum(states(:,:,1),"all") == 3^(3*daniel)
end
format longg
% sum(states(:,:,1),"all")