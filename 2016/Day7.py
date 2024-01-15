def hasAutonomousBridgeBypassAnnotation(s):
    for i in range(len(s)-3):
        if s[i] == s[i + 3] and s[i + 1] == s[i + 2] and s[i] != s[i + 1]:
            return True
    return False

def findAbs(ss):
    abs = []
    for s in ss:
        for i in range(len(s)-2):
            if s[i] == s[i + 2] and s[i] != s[i + 1]:
                abs.append((s[i],s[i+1]))
    return abs

def containsBab(ss, ab):
    for s in ss:
        for i in range(len(s)-2):
            if s[i] == s[i+2] == ab[1] and s[i+1] == ab[0]:
                return True
    return False
# sorry - 1 line is quite useless but seems too good to miss.
# print(sum([1 if t else 0 for t in [any(T[0::2]) and not any(T[1::2]) for T in [[hasAutonomousBridgeBypassAnnotation(e) for e in line.replace("]","[").split("[")] for line in open("Day7.txt").read().splitlines()]]]))

lines = open("Day7.txt").read().splitlines()
abbaStates = [[hasAutonomousBridgeBypassAnnotation(e) for e in line.replace("]","[").split("[")] for line in lines]
tlsSupport = [any(T[::2]) and not any(T[1::2]) for T in abbaStates]
print(sum([1 if t else 0 for t in tlsSupport]))

part2 = 0
for line in lines:
    parts = line.replace("]","[").split("[")
    abs = findAbs(parts[::2])
    # print(abs)
    containsb = False
    for ab in abs:
        containsb = containsb or containsBab(parts[1::2],ab)
    part2 += 1 if containsb else 0
    # print(containsb)

print(part2)