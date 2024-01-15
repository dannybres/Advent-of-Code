lines = open("Day3.txt").read().splitlines()

allSideLengths = [[int(x) for x in line.split(" ") if x.isdigit()] for line in lines]

result = 0
for sideLengths in allSideLengths:
    result += 1 if sum(sideLengths) / 2 > max(sideLengths) else 0
print(result)

result = 0
for r in range(0,len(allSideLengths),3):
    for c in range(3):
        sideLengths = [allSideLengths[r + x][c] for x in range(3)]
        result += 1 if sum(sideLengths) / 2 > max(sideLengths) else 0
print(result)