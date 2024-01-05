def castSpell(spellCast,p,b,activeSpells):
    manaCost, damage, heal, duration = spells[spellCast][:4]
    activeSpells[spellCast] = duration
    p["m"] -= manaCost
    p["h"] += heal
    b["h"] -= damage
    return (p,b,activeSpells)

def play(p,b,activeSpells,manaUsed,spell = "",hardMode = False):
    global minMana
    if manaUsed > minMana: # optimisation when cannot scored better
        return float("inf")
    if spell != "": # cast spell if specified (ending prior turn) (only r1 doesnt have a pre-cast)
        p,b,activeSpells = castSpell(spell,p,b,activeSpells)
    if p["h"] < 1: # check end game
        return float("inf")
    elif b["h"] < 1:
        return manaUsed    
    for roundNum in range(1 if spell == "" else 0,2):  # boss then player except round 1 when no spell is precast
        effect = [0 for x in range(3)] # perform spell effect
        for spell in activeSpells.keys():
            activeSpells[spell] -= 1
            effect = [x + y for x, y in zip(effect, spells[spell][-3:])]
        activeSpells = {key:val for key, val in activeSpells.items() if val > 0}
        p["m"] += effect[2]
        b["h"] -= effect[1]
        if b["h"] < 1:
            return manaUsed
        if roundNum % 2: # player turn
            for spell in spells:
                if spell not in activeSpells and spells[spell][0] < p["m"]:
                    pp = p.copy()
                    if hardMode:
                        pp["h"] = pp["h"] - 1
                    minMana = min(minMana, play(pp,b.copy(),activeSpells.copy(),manaUsed+spells[spell][0],spell,hardMode))
        else: # boss turn
            p["h"] -= max(1, b["d"] - effect[0])
            if p["h"] < 1:
                return float("inf")
    return minMana 

b = dict(h=71,d=10)
p = dict(h=50,m=500)
spells = dict(mm=[53, 4, 0, 0, 0, 0, 0], dr=[73, 2, 2, 0, 0, 0, 0], sh=[113, 0, 0, 6, 7, 0, 0],po=[173, 0, 0, 6, 0, 3, 0],re = [229, 0, 0, 5, 0, 0, 101])

minMana = float("inf")
print(play(p.copy(),b.copy(),dict(),0))

minMana = float("inf")
print(play(p,b,dict(),0,"",True))