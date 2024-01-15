lines = open("5.txt").read().splitlines()
def isNice(phase):
    vowelCount = sum(1 for char in phase if char.lower() in 'aeiou')
    phraseCount = sum(phase.count(x) for x in ['ab','cd','pq','xy'])
    consecutiveLetters = sum(1 for i in range(len(phase)-1) if phase[i] == phase[i+1])
    return not phraseCount and vowelCount >= 3 and consecutiveLetters
def isNicer(phase):
    pairOfPairs = any(phase[i:i+2] == phase[j:j+2] for i in range(len(phase)-1) for j in range(len(phase)-1) if abs(i-j) >= 2)
    splitLetters = any(phase[i] == phase[i+2] for i in range(len(phase)-2))
    return pairOfPairs and splitLetters
print(sum(1 for line in lines if isNice(line)))
print(sum(1 for line in lines if isNicer(line)))