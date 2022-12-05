data = readlines("input.txt");
data = data.split(": ");
data = data(:,2).double;

rolls = reshape(repmat(1:100,1,30),3,[])';

p1 = mod(cumsum(sum(rolls(1:2:end,:),2)) + data(1),10);
p1(p1==0) = 10;
p1 = cumsum(p1);

p2 = mod(cumsum(sum(rolls(2:2:end,:),2)) + data(2),10);
p2(p2==0) = 10;
p2 = cumsum(p2);

p1win = find(p1>=1000,1);
p2win = find(p2>=1000,1);

if p1win < p2win
    rolls = (p1win * 2 - 1) * 3;
    loser = p2(p1win - 1);
else
    rolls = (p2win * 2) * 3;
    loser = p1(p2win);
end

result = rolls * loser