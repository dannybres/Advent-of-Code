def runAssembunny(r):
    lines = open("Day23a.txt").read().splitlines()
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
        elif type == "tgl":
            toggleIndex = i + r[arg[0]]
            instructionToToggle = lines[toggleIndex]
            print(instructionToToggle)
            if instructionToToggle.count(" ") == 1:
                print(1)
            else:
                print(2)
            # print((type,arg))
            # print(r)
            exit()
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