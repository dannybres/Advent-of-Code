import math
bd = open("21.txt").read().splitlines()
b = dict()
for line in bd: # make boss
    type, val = line.split(": ")
    b[type[0].lower()] = int(val)

def battle(b,p): # battle func
    bossWillLast = math.ceil(b["h"]/max(1,(p["d"] - b["a"])))
    playerWillLast = math.ceil(p["h"]/max(1,(b["d"] - p["a"])))
    victory = bossWillLast <= playerWillLast
    # if victory:
    #     print("VICTORY!!!!")
    #     print("Boss will last %i turns." % bossWillLast)
    #     print("Player will last %i turns." % playerWillLast)
    #     print("Player, hp: %i, d: %i, a:%i, c:%i" % (p["h"],p["d"],p["a"],p["c"]))
    #     print("Cost %i result in %s." % (p["c"], "victory" if victory else "defeat"))
    #     print()
    return victory

ds = open("21shop.txt").read().split("\n\n") # build shop
s = []
for d in ds:
    w = []
    for line in d.splitlines():
        if line.count(":"):
            continue
        line = line.replace("e ","e")
        while line.count("  "):
            line = line.replace("  "," ")
        nv,cv,dv,av = line.split(" ")
        w.append((int(cv),int(dv),int(av)))
    s.append(w)

ringPerms = [[0 for x in range(6)]] # make ring permutations
for a in range(6):
    p = ringPerms[0].copy()
    p[a] = 1
    ringPerms.append(p)
    for inc in range(a+1,6):
        pp = p.copy()
        pp[inc] = 1
        ringPerms.append(pp)


p = dict() # generic player
p["h"] = 100
p["d"] = 0
p["a"] = 0
p["c"] = 0

players = [] # make all players
for line in ringPerms:
    rp = p.copy()
    for i,inc in enumerate(line): # rings
        if inc:
            rp["d"] += s[2][i][1]
            rp["a"] += s[2][i][2]
            rp["c"] += s[2][i][0]
    players.append(rp)
    for c,d,a in s[0]: # weapon
        thisP = rp.copy()
        thisP["d"] += d
        thisP["a"] += a
        thisP["c"] += c
        players.append(thisP)
        for c,d,a  in s[1]: # armour
            thisPWithA = thisP.copy()
            thisPWithA["d"] += d
            thisPWithA["a"] += a
            thisPWithA["c"] += c
            players.append(thisPWithA)


minCost = float("inf")
maxCost = 0
for player in players:
    if battle(b,player):
        minCost = min(minCost,player["c"])
    else:
        maxCost = max(maxCost,player["c"])
print(minCost)
print(maxCost)