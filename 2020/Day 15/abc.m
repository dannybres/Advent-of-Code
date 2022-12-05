Day15Input=uint32([7,14,0,17,11,1,2]);
LastSpoken=[Day15Input(end),length(Day15Input)];
SpokenMap=containers.Map(Day15Input,1:LastSpoken(2));
while LastSpoken(2)<2020
    if SpokenMap.isKey(LastSpoken(1))
        NextSpoken=[LastSpoken(2)-SpokenMap(LastSpoken(1)),LastSpoken(2)+1];
    else
        NextSpoken=[0,LastSpoken(2)+1];
    end
    SpokenMap(LastSpoken(1))=LastSpoken(2);
    LastSpoken=NextSpoken;
end
Day15Part1=LastSpoken(1)
while LastSpoken(2)<30000000
    if SpokenMap.isKey(LastSpoken(1))
        NextSpoken=[LastSpoken(2)-SpokenMap(LastSpoken(1)),LastSpoken(2)+1];
    else
        NextSpoken=[0,LastSpoken(2)+1];
    end
    SpokenMap(LastSpoken(1))=LastSpoken(2);
    LastSpoken=NextSpoken;
end
Day15Part2=LastSpoken(1)