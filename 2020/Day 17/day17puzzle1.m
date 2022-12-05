data = readlines("input.txt").split("");
data = data(:,2:end-1)=="#";

finder = ones(3,3,3); finder(2,2,2) = 0;

for idx = 1:6
    data = padarray(data,[1 1 1], 0);
    countOfData = convn(data,finder,'same');
    newData = false(size(data));
    newData(data & (countOfData == 2 | countOfData == 3)) = true;
    newData(~data & countOfData == 3) = true;
    data = newData;
end
sum(data,'all')