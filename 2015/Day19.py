import re
changes,target = open("19.txt").read().split("\n\n")

def allOptions(w):
    r = set()
    for line in changes.splitlines():
        k,v = line.split(" => ")
        pattern = re.compile('('+k+')')
        result = [(match.start(),match.end()) for match in pattern.finditer(w)]
        for match in result:
            newS = w[:match[0]] + v + w[match[1]:]
            if newS not in allWords:
                allWords.append(newS)

allWords = []
allOptions(target)
print(len(allWords))

print(target)

NumEle = sum([1 if x[1].isupper() else 0 for x in enumerate(target)])

print(NumEle - target.count("Ar")  - target.count("Rn") - target.count("Y") * 2 - 1)

# 213 - too high