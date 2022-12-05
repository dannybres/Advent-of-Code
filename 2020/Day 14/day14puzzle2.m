data = readlines("input.txt");
data = data.replace("mask", "mem[NaN]");
data(data.extractBefore(3) == "ma") = [];

data = data.split(["[","]"]).erase(" = ");
index = data(:,2).double(); number = data(:,3);
mem = sparse(2^35,1);

for idx = 1:numel(index)
    if isnan(index(idx))
        mask = char(number(idx));
        continue
    end
    addressTemp = dec2bin(index(idx));
    addressTemp = char(padarray(double(addressTemp),[0 36-numel(addressTemp)],double('0'),'pre'));
    address = mask;
    address(mask == '0') = addressTemp(mask == '0');
    idxOfX = address == 'X';
    numOfX = sum(idxOfX);
    dec2bin(0:(2^numOfX)-1);
    address = repmat(address,2^numOfX,1);
    address(:,idxOfX) = dec2bin(0:(2^numOfX)-1);

    numAds = bin2dec(address);
    mem(numAds) = number(idx).double;
end
a = sum(mem)
a(1,1)