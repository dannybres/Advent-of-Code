b = dict()
b["h"] = 71
b["d"] = 10

p = dict()
p["h"] = 50
p["m"] = 500

spells = dict()
spells["mm"] = [53, 4, 0, 0, 0, 0, 0] # cost instantD instantH duration armourBuff effectD mantraGain
spells["dr"] = [73, 2, 2, 0, 0, 0, 0]
spells["sh"] = [113, 0, 0, 6, 7, 0, 0]
spells["po"] = [173, 0, 0, 6, 0, 3, 0]
spells["re"] = [229, 0, 0, 5, 0, 0, 101]

activeSpells = dict()
def castSpell(spellCast,p,b,activeSpells):
    details = spells[spellCast]
    activeSpells[spellCast] = spells[spellCast][3]
    p["m"] -= spells[spellCast][0]
    assert(p["m"] > 0)
    p["h"] += details[2]
    b["h"] -= details[1] 
    return (p,b,activeSpells)


minMana = float("inf")
def play(p,b,activeSpells,firstTurn,manaUsed,spell = ""):
    global minMana
    if manaUsed > minMana:
        return float("inf")
    
    if spell != "":
        p,b,activeSpells = castSpell(spell,p,b,activeSpells)
        # if roundNum % 2: # player turn
    
    # p["h"] -= 1

    if p["h"] < 1:
        # print("boss wins")
        return float("inf")
    elif b["h"] < 1:
        # print("player wins")
        return 0    
    
    if firstTurn:
        roundNumStart = 1
    else:
        roundNumStart = 0
    
    for roundNum in range(roundNumStart,2):

        effect = [0 for x in range(3)];
        for spell in activeSpells.keys():
            # print(spell)
            activeSpells[spell] -= 1
            effect = [x + y for x, y in zip(effect, spells[spell][-3:])]
        activeSpells = {key:val for key, val in activeSpells.items() if val > 0}
        p["m"] += effect[2]
        b["h"] -= effect[1]
        
        if roundNum % 2: # player turn
            for spell in spells:
                if spell not in activeSpells and spells[spell][0] < p["m"]:
                    minMana = min(minMana, play(p.copy(),b.copy(),activeSpells.copy(),False,manaUsed+spells[spell][0],spell) + spells[spell][0])
        else: # boss turn
            p["h"] -= max(1, b["d"] - effect[0])
            if b["h"] < 1:
                # print("player wins")
                return 0
            if p["h"] < 1:
                # print("boss wins")
                return float("inf")
            
    return minMana 
  
print(play(p,b,activeSpells,True,0))

# 1824
# 1937