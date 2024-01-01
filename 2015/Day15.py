lines = open("15.txt").read().replace(" capacity ","").replace(" durability ","").replace(" flavor ","").replace(" texture ","").replace(" calories ","").replace(":",",").splitlines()

g = list()
for line in lines:
    na,c,d,f,t,ca = line.split(",")
51    g.append([int(c),int(d),int(f),int(t),int(ca)])

p1 = 0
p2 = 0
for a1 in range(101):
    for a2 in range(101 - a1):
        for a3 in range(101 - a1 - a2):
            a4 = 100 - a1 - a2 - a3
            t = 1
            c = 1
            for i in range(4):
                t = t * max(0,a1 * g[0][i] +  a2 * g[1][i] +  a3 * g[2][i] +  a4 * g[3][i])
            c = (a1 * g[0][-1] +  a2 * g[1][-1] +  a3 * g[2][-1] +  a4 * g[3][-1])
            p1 = max(p1,t)
            if c == 500:
                p2 = max(p2,t)

print(p1)
print(p2)