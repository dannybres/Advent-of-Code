lines = open("5.txt").read().splitlines()

def isNice(phase):
    vowelCount = 0
    for v in ['a','e','i','o','u']:
        vowelCount += phase.count(v)
    phraseCount = 0
    for v in ['ab','cd','pq','xy']:
        phraseCount += phase.count(v)
    consecutiveLetters = False
    for i in range(len(phase)-1):
        if phase[i] == phase[i+1]:
            consecutiveLetters = True
            break
    return phraseCount == 0 and vowelCount >= 3 and consecutiveLetters

def isNicer(phase):
    pairOfPairs = False
    for i in range(len(phase)-1):
        if pairOfPairs:
            break
        for j in range(len(phase)-1):
            if abs(i-j) < 2:
                continue
            if phase[i:i+2] == phase[j:j+2]:
                pairOfPairs = True
                break
                
    splitLetters = False
    for i in range(len(phase)-2):
        if phase[i] == phase[i+2]:
            splitLetters = True
            break
    return pairOfPairs and splitLetters

# Part 1
c = 0
for line in lines:
    if isNice(line):
        c += 1
print(c)

# Part 2
c = 0
for line in lines:
    if isNicer(line):
        c += 1
print(c)