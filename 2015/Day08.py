lines = open("8.txt").read().splitlines()
t = 0
for line in lines.copy():
    es = line.count("\\\\")
    line = line.replace("\\\\","")
    
    eq = line.count("\\\"")
    line = line.replace("\\\"","")
    
    hc = line.count("\\x")
    l = len(line)
    
    if hc > 1:
        indices = [index for index in range(len(line) - 1) if line[index:index + 2] == "\\x"]
        for i in indices:
            try:
                int(line[i+2:i+4],16)
            except Exception as e:
                hc -= 1
    t = t + 2 + eq + es + 3*hc
print(t)

t = 0
for line in lines.copy():
    es = line.count("\\")
    eq = line.count("\"")
    t = t + es + eq + 2
print(t)