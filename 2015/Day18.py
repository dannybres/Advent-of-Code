a = open("18.txt").read().splitlines()

def advance(map,part2 = False):
    newMap = [x[:] for x in map]
    for x in range(len(map)):
        for y in range(len(newMap[0])):
            neighboursOn = 0
            for dx, dy in [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]:
                nx = x + dx
                ny = y + dy
                if 0 <= nx < len(newMap) and 0 <= ny < len(newMap[0]):
                    neighboursOn += map[nx][ny]
            if map[x][y]:
                if neighboursOn == 2 or neighboursOn == 3:
                    newMap[x][y] = 1
                else:
                    newMap[x][y] = 0
            else:
                if neighboursOn == 3:
                    newMap[x][y] = 1
                else:
                    newMap[x][y] = 0
    if part2:
        newMap[0][0] = 1
        newMap[0][-1] = 1
        newMap[-1][0] = 1
        newMap[-1][-1] = 1
    return [x[:] for x in newMap]

map  = list()
for line in a:
    map.append([0 if line[x] == '.' else 1 for x in range(len(line))])
for i in range(100):
    map = advance(map)
print(sum([sum(i) for i in map]))

map  = list()
for line in a:
    map.append([0 if line[x] == '.' else 1 for x in range(len(line))])
map[0][0] = 1
map[0][-1] = 1
map[-1][0] = 1
map[-1][-1] = 1
for i in range(100):
    map = advance(map,True)
print(sum([sum(i) for i in map]))