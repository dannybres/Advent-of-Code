data = readlines("inputDemo.txt")
data = data(2:end).split(",").double()

q = permute(data,[1 3 2])

meshgrid(q,q)
% diff(sort(sum(abs(data),2)))