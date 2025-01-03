data = readlines("input.txt").extractAfter(": ").double();
cyclesOfDie = 12;
n = sum(reshape(repmat(1:100,1,cyclesOfDie),3,[])',2);
s = mod(cumsum(reshape(n,2,[]),2) + data,10);
s(s == 0) = 10;
s = cumsum(s,2);
winningTurn = find(s(:)>=1000,1,"first");
p1 = s(winningTurn-1)*winningTurn*3