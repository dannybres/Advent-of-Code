%% day13puzzle1 - Daniel Breslan - Advent Of Code 2018
clc
data = char(readlines("inputDemo.txt"));
data = char(readlines("input.txt"));
map = data;

di = '>v<^';

dlu = dictionary(di',{[1 0];[0 1];[-1 0];[0 -1]});

cart = any(data == reshape(di,1,1,4),3);
[r,c] = ind2sub(size(data),find(cart));

stateofCart = ones(1,numel(r));
stateLU = [-1 0 1];
locationOfCarts = [r c];

for idx = 1:numel(r)
    if r(idx) == 1
        map(r(idx),c(idx)) = '-';
    elseif c(idx) == 1
        map(r(idx),c(idx)) = '|';
    else
        if(all(any(data(r(idx)+[-1 1], c(idx)) == '+|\',2)))
            map(r(idx),c(idx)) = '|';
        else
            map(r(idx),c(idx)) = '-';
        end
    end
end
map;
go = true;
% for step = 1:100
while go
    cart = any(data == reshape(di,1,1,4),3);
    [r,c] = ind2sub(size(data),find(cart));

    [~,idx] = sort(r);

    r = r(idx);
    c = c(idx);
    for idx = 1:numel(r)
        rCart = r(idx);
        cCart = c(idx);
        diCart = data(rCart,cCart);
        directionVector = dlu(diCart);
        directionVector = directionVector{:};
        rCartNew = rCart + directionVector(2);
        cCartNew = cCart + directionVector(1);
        cartNumber = ismember(locationOfCarts,[rCart, cCart],"rows");
        if data(rCartNew,cCartNew) == '+'
            stateChange = stateLU(stateofCart(cartNumber));
            currentDir = find(di == data(rCart,cCart));
            newDir = currentDir + stateChange;
            if newDir == 0
                newDir = 4;
            elseif newDir == 5
                newDir = 1;
            end
            data(rCartNew,cCartNew) = di(newDir);
            stateofCart(cartNumber) = stateofCart(cartNumber) + 1;
            if stateofCart(cartNumber) == 4
                stateofCart(cartNumber) = 1;
            end
        elseif data(rCartNew,cCartNew) == '/'
            switch find(di == data(rCart,cCart))
                case 1
                    data(rCartNew,cCartNew) = '^';
                case 2
                    data(rCartNew,cCartNew) = '<';
                case 3
                    data(rCartNew,cCartNew) = 'v';
                case 4
                    data(rCartNew,cCartNew) = '>';
            end        
        elseif data(rCartNew,cCartNew) == '\'
            switch find(di == data(rCart,cCart))
                case 1
                    data(rCartNew,cCartNew) = 'v';
                case 2
                    data(rCartNew,cCartNew) = '>';
                case 3
                    data(rCartNew,cCartNew) = '^';
                case 4
                    data(rCartNew,cCartNew) = '<';
            end
        elseif any(data(rCartNew,cCartNew) == di')
            data(rCartNew,cCartNew) = 'X';
            go = false;
        else
            data(rCartNew,cCartNew) = data(rCart,cCart);
        end
        data(rCart,cCart) = map(rCart,cCart);
        
        locationOfCarts(cartNumber,:) = [rCartNew,cCartNew];
    end
%      data
end

[r,c] = ind2sub(size(data),find(data == 'X'));
compose("%i,%i",c-1,r-1)