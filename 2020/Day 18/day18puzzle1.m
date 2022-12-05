data = readlines("input.txt");

res = zeros(numel(data),1);

for idx = 1:numel(data)
    res(idx) = evaluateLine(data(idx)).double();
end
sum(res)

function out = evaluateLine(d)
while true
    op = regexp(d,"(");
    cl = regexp(d,")");
    if isempty(op)
        break
    end
    opBr = op(end);
    validCloses = cl(cl > op(end));
    clBr = validCloses(1);
    for idx = 1:numel(op)-1
        validCloses = cl < op(idx+1);
        if any(cl > op(idx) & validCloses)
            opBr = op(idx);
            clBr = cl(find(validCloses,1));
            break
        end
    end
    newVal = simlifyMath(d.extractBetween(opBr+1,clBr-1));
    d = d.eraseBetween(opBr, clBr);
    d = d.insertAfter(opBr-1,newVal);
end
out = simlifyMath(d);
end

function d = simlifyMath(d)
sums = d.split("*");
sumsRes = zeros(size(sums));
for idx = 1:numel(sumsRes)
    sumsRes(idx) = calculateString(sums(idx)).double();
end
d = string(prod(sumsRes));
end

function d = calculateString(d)
d = erase(d," ");
while true
    [sumStart, sumEnd] = regexp(d,"\d+");
    if numel(sumStart) == 1
        break
    end
    result = process(d.extractBetween(sumStart(1),sumEnd(1)),...
        d.extractBetween(sumEnd(1)+1,sumStart(2)-1),...
        d.extractBetween(sumStart(2),sumEnd(2)));
    d = result + d.extractAfter(sumEnd(2));
end
end

function out = process(n1,op,n2)
if op == "+"
    out = sum([n1.double(),n2.double()]);
else
    out = prod([n1.double(),n2.double()]);
end
end