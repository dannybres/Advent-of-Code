from collections import Counter

lines = open("Day6.txt").read().splitlines()
columnGroups = [[row[i] for row in lines] for i in range(len(lines[0]))]
print(''.join([Counter(x).most_common()[0][0] for x in columnGroups]))
print(''.join([Counter(x).most_common()[-1][0] for x in columnGroups]))