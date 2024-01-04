# b = dict()
# b["h"] = 71
# b["d"] = 10

# p = dict()
# p["h"] = 50
# p["m"] = 500
# p["a"] = 0

# b = dict()
# b["h"] = 13
# b["d"] = 8

# p = dict()
# p["h"] = 10
# p["m"] = 250
# spellsToCase = ["po","mm"]


b = dict()
b["h"] = 14
b["d"] = 8

p = dict()
p["h"] = 10
p["m"] = 250
spellsToCase = ["re","sh","dr","po","mm"]

spells = dict()

spells["mm"] = [53, 4, 0, 0, 0, 0, 0] # cost instantD instantH duration armourBuff effectD mantraGain
spells["dr"] = [73, 2, 2, 0, 0, 0, 0]
spells["sh"] = [113, 0, 0, 6, 7, 0, 0]
spells["po"] = [173, 0, 0, 6, 0, 3, 0]
spells["re"] = [229, 0, 0, 5, 0, 0, 101]

# activeSpells = dict(re = 5)
activeSpells = dict()

def castSpell(spellCast):
    details = spells[spellCast]
    activeSpells[spellCast] = spells[spellCast][3]
    p["m"] -= spells[spellCast][0]
    p["h"] += details[2]
    b["h"] -= details[1]  

roundNum = -1
# for roundNum in range(4):
while b["h"] and b["h"]:
    roundNum += 1
    print()

    effect = [0 for x in range(3)];
    for spell in activeSpells.keys():
        activeSpells[spell] -= 1
        effect = [x + y for x, y in zip(effect, spells[spell][-3:])]
    activeSpells = {key:val for key, val in activeSpells.items() if val > 0}
    if roundNum % 2: # boss turn
        print("# Boss turn")
    else:
        print("# Player turn")
    print("Player has %i hit points, %i armor, %i mana"%(p["h"],effect[0],p["m"]))
    print("Boss has %i hit points"%(b["h"]))
    
    p["m"] += effect[2]
    b["h"] -= effect[1]

    if b["h"] < 1 or b["h"] < 1:
        break

    if roundNum % 2: # boss turn
        p["h"] -= max(1, b["d"] - effect[0])
    else: # player turn
        castSpell(spellsToCase.pop(0))

        


print("final score:")
print("Player has %i hit points, %i armor, %i mana"%(p["h"],effect[0],p["m"]))
print("Boss has %i hit points"%(b["h"]))