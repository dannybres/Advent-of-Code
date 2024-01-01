lines = open("6.txt").read().replace("turn ","").replace(" through ",",").replace(" ",",").splitlines()

on = set();
for line in lines:
    type,fx,fy,tx,ty = line.split(",")
    if type == "on":
        for x in range(int(fx),int(tx)+1):
            for y in range(int(fy),int(ty)+1):
                on.add((x,y))
    elif type == "off":
        for x in range(int(fx),int(tx)+1):
            for y in range(int(fy),int(ty)+1):
                if (x,y) in on:
                    on.remove((x,y))
    elif type == "toggle":
        for x in range(int(fx),int(tx)+1):
            for y in range(int(fy),int(ty)+1):
                if (x,y) in on:
                    on.remove((x,y))
                else:
                    on.add((x,y))
print(len(on))


on = dict()
for line in lines:
    type,fx,fy,tx,ty = line.split(",")
    if type == "on":
        for x in range(int(fx),int(tx)+1):
            for y in range(int(fy),int(ty)+1):
                if (x,y) in on:
                    on[(x,y)] = on[(x,y)] + 1
                else:
                    on[(x,y)] = 1
    elif type == "off":
        for x in range(int(fx),int(tx)+1):
            for y in range(int(fy),int(ty)+1):
                if (x,y) in on:
                    on[(x,y)] = max(0,on[(x,y)] - 1)
    elif type == "toggle":
        for x in range(int(fx),int(tx)+1):
            for y in range(int(fy),int(ty)+1):
                if (x,y) in on:
                    on[(x,y)] = on[(x,y)] + 2
                else:
                    on[(x,y)] = 2
t = 0
for k in on.keys():
    t += on[k]

print(t)