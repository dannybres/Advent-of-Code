lines = open("Day22.txt").read().splitlines()[2:]
lines = [l.replace("/dev/grid/node-x","").replace("-y",",").replace(" ",",",1).replace(" ","").replace("T",",").replace("%","") for l in lines]
x,y,*_ = lines[-1].split(",")
used = [[0 for yi in range(int(y)+1)] for xi in range(int(x)+1)]
available = [[0 for yi in range(int(y)+1)] for xi in range(int(x)+1)]

a = []
for line in lines:
    x,y,_,u,a,_ = line.split(",")
    print(x,y)
    used[int(x)][int(y)] = int(u)
    available[int(x)][int(y)] = int(a)

viablePairs = 0
for x in range(len(used)):
    for y in range(len(used[0])):
        for xx in range(len(used)):
            for yy in range(len(used[0])):
                if used[x][y] != 0 and (x,y) != (xx,yy) and used[x][y] <= available[xx][yy]:
                    viablePairs += 1

print(viablePairs)