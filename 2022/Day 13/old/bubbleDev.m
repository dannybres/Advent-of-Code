a = [5 3 2 1 4]

for idx = numel(a)-1:-1:1
    for b = 1:idx
        if a(b) > a(b+1)
            temp = a(b);
            a(b) = a(b+1);
            a(b+1) = temp;
        end
    end
end

a