import numpy as np
import matplotlib.pyplot as plt

a = np.zeros((6,50))


lines = open("Day8.txt").read().splitlines()

for line in lines:
    type,rest = line.split(" ",1)
    print(type)
    if type == "rect":
        x,y = rest.split("x")
        a[:int(y),:int(x)] = 1
    elif type == "rotate":
        print(rest)
        dimension, index, _, n = rest.split(" ")
        _,index = index.split("=")
        if dimension == "row":
            a[int(index),:] = np.roll(a[int(index),:],int(n))
        else:
            a[:,int(index)] = np.roll(a[:,int(index)],int(n))

print(np.sum(a))

plt.imshow(a)
plt.show()