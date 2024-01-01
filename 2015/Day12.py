import re, json
lines = open("12.txt").read()
t=0
for x in re.findall("[-]?\d+", lines):
    t=t+int(x)
print(t)

a = json.loads(lines)
def dfs(input):
    tt = 0
    if isinstance(input,dict):
        ex = False
        for x in input.keys():
            if input[x] == "red":
                ex = True
        if ex:
            t=0
            for x in re.findall("[-]?\d+", json.dumps(input)):
                t=t+int(x)
            tt = tt + t
        else:
            for x in input.keys():
                tt = tt + dfs(input[x])
    elif isinstance(input,list):
        for x in input:
            tt = tt + dfs(x)
    return tt
print(t-dfs(a))