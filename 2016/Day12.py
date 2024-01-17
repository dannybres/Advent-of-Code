def runAssembunny(r):
    lines = open("Day12.txt").read().splitlines()
    i = 0
    while i < len(lines):
        type, *arg = lines[i].split(" ")
        # print(i,type,arg)
        if type == "cpy":
            if arg[0].isnumeric():
                r[arg[1]] = int(arg[0])
            else:
                r[arg[1]] = r[arg[0]]
        elif type == "inc":
            r[arg[0]] += 1
        elif type == "dec":
            r[arg[0]] -= 1
        else:
            if arg[0].isnumeric():
                x = int(arg[0])
            else:
                x = r[arg[0]]
            if x:
                i += int(arg[1])
                continue
        i += 1
    return r
r = dict()
for n in range(4):
    r[chr(ord('a')+n)] = 0

p1 = runAssembunny(r.copy())
r['c'] = 1
p2 = runAssembunny(r.copy())

print(p1['a'])
print(p2['a'])