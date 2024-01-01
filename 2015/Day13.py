lines = open("13.txt").read().replace("to","=").replace(".","").replace(" happiness units by sitting next =","").replace("would ","").replace("lose ","-").replace("gain ","").splitlines()

g = dict()

for line in lines:
    me,hap,them = line.split(" ")
    if me not in g:
        g[me] = dict()
    
    g[me][them] = int(hap)

seen = list()
def dfs(person):
    
    if len(seen) == len(g.keys())-1:
        return g[person][seen[0]] + g[seen[0]][person]

    t = 0
    seen.append(person)
    for k in g[person].keys():
        if k not in seen:
            t = max(t, dfs(k) + g[person][k] + g[k][person])
    seen.remove(person)
    
    return t


print(dfs("Alice")) 

g["me"] = dict()
for k in g.keys():
    g[k]["me"] = 0
    g["me"][k] = 0

print(dfs("Alice")) 
