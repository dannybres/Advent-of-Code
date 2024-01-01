import numpy as n
x = n.vectorize(int)(list(open('17.txt')))
c = 0
for i in range(1 << len(x)):
    t = i
    s = 0
    for j in x:
        if t % 2 == 1:
            s += j
        t //= 2
    if s == 150:
        c += 1
print(c)