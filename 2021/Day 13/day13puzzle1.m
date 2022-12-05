data =readmatrix("input.txt");
data = data(~all(isnan(data),2),:) + 1
foo = false(max(data(:,2)),max(data(:,1)));
for idx = 1:size(data,1)
    foo(data(idx,2),data(idx,1)) = true;
end

inst =readlines("input.txt");
inst = inst(size(data,1)+2:end).split("=");

for idx = 1:size(inst,1)
    index = inst(idx,2).double()
    if inst(idx,1) == "fold along x"
        foo = foo(:,1:index) | fliplr(foo(:,index+2:end));
    else
        foo = foo(1:index,:) | flipud(padarray(foo(index+2:end,:),[index * 2 + 1 - size(foo,1) 0],false,'post'));
    end
end
imshow(~foo)

