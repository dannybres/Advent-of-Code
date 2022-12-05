function countOfOccupied = occupiedSeatsVisible(mapIn)
    countOfOccupied = zeros(size(mapIn));
    for r = 1:size(mapIn,1)
        for c = 1:size(mapIn,2)
            if mapIn(r,c) == "."
                continue
            end
            countOfOccupied(r,c) = occupiedSeatsVisibleFromRandC(mapIn,r,c);
        end
    end
end

function countOfOccupied = occupiedSeatsVisibleFromRandC(mapIn,row,col)
row = row + 1; col = col + 1;
mapIn = [repmat(".",1,size(mapIn,2)); mapIn; repmat(".",1,size(mapIn,2))];
mapIn = [repmat(".",size(mapIn,1),1) mapIn repmat(".",size(mapIn,1),1)];
u = join(flipud(mapIn(1:row-1,col)),"");
d = join(mapIn(row+1:end,col)',"");
l = join(fliplr(mapIn(row,1:col-1)),"");
r = join(mapIn(row,col+1:end),"");

dia1 = diagLine(size(mapIn),[row,col],false);
% dia1 = dia1(:,2:end-1);
col1 = find(sum(dia1));
col1 = col1(1);

dia2 = diagLine(size(mapIn),[row,col],true);
% dia2 = dia2(:,2:end-1);
col2 = find(sum(dia2));
col2 = col2(1);

d1 = mapIn(dia1);
d2 = mapIn(dia2);

ul = join(fliplr(d1(1:col-col1)'),"");
lr = join(d1(col-col1+2:end)',"");

ll = join(fliplr(d2(1:col-col2)'),"");
ur = join(d2(col-col2+2:end)',"");

allAngles = [u d l r ul ur ll lr]';
allAngles = allAngles.erase(".");
allAngles = allAngles + "......";
allAngles = allAngles.extractBefore(2);
countOfOccupied = sum(allAngles == "#");
end