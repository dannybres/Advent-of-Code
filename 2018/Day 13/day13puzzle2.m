%% day13puzzle2 - Daniel Breslan - Advent Of Code 2018
clc
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
    if r(idx) == 1 || r(idx) == size(map,1)
        map(r(idx),c(idx)) = '-';
    elseif c(idx) == 1 || c(idx) == size(map,2)
        map(r(idx),c(idx)) = '|';
    else
        if(all(any(data(r(idx)+[-1 1], c(idx)) == '+|\',2)))
            map(r(idx),c(idx)) = '|';
        else
            map(r(idx),c(idx)) = '-';
        end
    end
end
go = true;
while go
    cart = any(data == reshape(di,1,1,4),3);
    [r,c] = ind2sub(size(data),find(cart));
    [~,idx] = sort(r);
    r = r(idx);
    c = c(idx);
    if numel(r) == 1
        break
    end
    for idx = 1:numel(r)
        rem = false;
        rCart = r(idx);
        cCart = c(idx);
        diCart = data(rCart,cCart);
        if ~any(diCart == di)
            continue
        end
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
            data(rCartNew,cCartNew) = di(5-find(di == data(rCart,cCart)));       
        elseif data(rCartNew,cCartNew) == '\'
            next = [2 1 4 3];
            data(rCartNew,cCartNew) = di(next(di == data(rCart,cCart)));
        elseif any(data(rCartNew,cCartNew) == di')
            rem = true;
            data(rCartNew,cCartNew) = map(rCartNew,cCartNew);
        else
            data(rCartNew,cCartNew) = data(rCart,cCart);
        end
        data(rCart,cCart) = map(rCart,cCart);
        if rem 
            locationOfCarts(cartNumber,:) = nan(1,2);
            otherCartNumber = ismember(locationOfCarts,[rCartNew, cCartNew],"rows");
            locationOfCarts(otherCartNumber,:) = nan(1,2);
        else
            locationOfCarts(cartNumber,:) = [rCartNew,cCartNew];
        end
    end
end
compose("%i,%i",c-1,r-1)