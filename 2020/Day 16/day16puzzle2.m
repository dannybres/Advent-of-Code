data = readlines("input.txt");

blanks = find(data == "");

rules = data(1:blanks(1)-1);
my = data(blanks(1)+2).split(",").double';
nb = data(blanks(2)+2:end).split(",").double;

rules = "rule."+rules.replace("-",":").replace(": "," = [").replace(" or ",",").replace(" ","") + "]";
eval(rules.join(";") + ";");

fn = fieldnames(rule);
allNums = [];
for idx = 1:numel(fn)
    allNums = [allNums rule.(fn{idx})];
end
allNums = unique(allNums);

nb = nb(~any(nb < min(allNums) | nb > max(allNums),2),:);


res = false(size(nb,2), numel(fn));

for idx = 1:size(nb,2)
    for fidx = 1:numel(fn)
        res(idx, fidx) = all(any(rule.(fn{fidx}) == nb(:,idx),2));
    end
end

[~,fnidx] = sort(sum(res));

[~,nbidx] = sort(sum(res,2),'desc');

[~,fidx] = sort(nbidx);

ff = fn(fnidx);
ff = ff(fidx);

prod(my(:,string(ff).extractBefore(4) == "dep"))

