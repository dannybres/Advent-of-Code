trains = readmatrix("input.txt");
train_rem = mod( trains-(0:numel(trains)-1), trains);

train_rem = cast(train_rem(~isnan(trains)), 'uint64');
trains = cast(trains(~isnan(trains)), 'uint64');

[trains, idx] = sort(trains, 'descend');
train_rem = train_rem(idx);

result = train_rem(1);
for i = 1:numel(trains)-1
    while mod(result, trains(i+1)) ~= train_rem(i+1)
        result = result + uint64((1:100))*prod(trains(1:i));
        isRem = mod(result, trains(i+1)) == train_rem(i+1);
        if any(isRem)
            result = result(find(isRem, 1, 'first'))
        end
    end 
end