data = readlines("input.txt");
data = data.split("");
data = data (:,2:end-1);

data = double(data);

searchForOGR = data;
searchForCSR = data;
for idx = 1:size(data,2)
    findValueOGR = sum(searchForOGR(:,idx)) >= size(searchForOGR,1)/2;
    findValueCSR = sum(searchForCSR(:,idx)) < size(searchForCSR,1)/2;
    if size(searchForOGR,1) ~= 1
        searchForOGR = searchForOGR(searchForOGR(:,idx) == findValueOGR,:);
    end
    if size(searchForCSR,1) ~= 1
        searchForCSR = searchForCSR(searchForCSR(:,idx) == findValueCSR,:);
    end
    if size(searchForOGR,1) == 1 && size(searchForCSR,1) == 1
        break
    end
end

day3puzzle2result = bin2dec(string(searchForCSR).join(""))...
    * bin2dec(string(searchForOGR).join(""))