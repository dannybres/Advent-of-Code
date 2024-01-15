lines = open("Day10.txt").read().splitlines()
target = [17, 61]
rules = dict()
bots = [[] for x in range(500)]
outputs = [[] for x in range(500)]

for line in lines:
    type, rest = line.split(" ",1)
    if type == "value":
        parts = rest.split(" ")
        bots[int(parts[-1])].append(int(parts[0]))
    elif type == "bot":
        rest = rest.replace(" gives low to ",",").replace(" and high to ",",").replace(" and ",",").split(",")
        rules[int(rest[0])] = rest[1:]
withTwos = [n for n,bot in enumerate(bots) if len(bot) == 2]

while len(withTwos) > 0:
    for withTwo in withTwos:
        locationToAssign = rules[withTwo]
        chipToAssign = sorted(bots[withTwo])
        if chipToAssign == target:
            print(withTwo)
        for n,location in enumerate(locationToAssign):
            type,loc = location.split(" ")
            if type == "bot":
                bots[int(loc)].append(chipToAssign[n])
            else:
                outputs[int(loc)].append(chipToAssign[n])
        bots[withTwo] = []
        withTwos = [n for n,bot in enumerate(bots) if len(bot) == 2]
        if len(withTwos) == 0:
            break

print(outputs[0][0] * outputs[1][0] * outputs[2][0])