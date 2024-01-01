lines = open("9.txt").read().replace("to","=").splitlines()


g = dict()

for line in lines:
    fr, to, distance = line.split(" = ")
    if fr not in g:
        g[fr] = dict()
    if to not in g:
        g[to] = dict()
    g[fr][to] = int(distance)
    g[to][fr] = int(distance)

seen = set()
def dfs(node):
    m = float("inf")
    if len(seen) == len(g.keys())-1:
        return 0
    seen.add(node)
    for nx in g[node].keys():
        if nx not in seen:
            m = min(m, dfs(nx) + g[node][nx])
    seen.remove(node)
    return m
    
def dfsMax(node):
    m = float("-inf")
    if len(seen) == len(g.keys())-1:
        return 0
    seen.add(node)
    for nx in g[node].keys():
        if nx not in seen:
            m = max(m, dfsMax(nx) + g[node][nx])
    seen.remove(node)
    return m
        
m = float("inf")
for node in g.keys():
    m = min(m, dfs(node))
print(m)

m = float("-inf")
for node in g.keys():
    m = max(m, dfsMax(node))
print(m)
# 178 is too highp