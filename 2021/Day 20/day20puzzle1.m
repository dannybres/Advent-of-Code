%% day20puzzle1 - Daniel Breslan - Advent Of Code 2021
data = readlines("input.txt").replace(["#" "."],["1","0"]);

alg = char(data(1));
img = char(data(3:end));
repStr = '0';
for idx = 1:50
    imgBig = char(padarray(double(img),[2 2],double(repStr)))';
    theIndexes = reshape(permute(reshape(((1:3) +...
        (0:size(imgBig,2):2*size(imgBig,2))')',[],9) +...
        (0:size(imgBig,1)-3)' + ...
        permute(0:size(imgBig,2):(size(imgBig,1)-3)*size(imgBig,2),[3,1,2]),[1 3 2]),[],9);
    img = reshape(alg(1+bin2dec(imgBig(theIndexes))),size(img,1)+2,[])';
    string(img).replace(["1","0"],["#" "."]);
    repStr = alg(bin2dec(repmat(repStr,1,9))+1);
end
out = nnz(img == double('1'));