directions = open("Day1.txt").read().split(", ")
possibleDirectionToRight = [(-1,0), (0,1),(1,0),(0,-1)]

facingDirection = 0
location = [0,0]
visited = set()
foundRepeat = False
for direction in directions:
    facingDirection = (facingDirection + (1 if direction[0] == "R" else -1)) % len(possibleDirectionToRight)
    for i in range(int(direction[1:])):
        for x in range(2):
            location[x] += possibleDirectionToRight[facingDirection][x]
        if tuple(location) in visited and not foundRepeat:
            print(location)
            part2location = location.copy()
            foundRepeat = True
        visited.add(tuple(location))
            
print(sum([abs(x) for x in location]))
print(sum([abs(x) for x in part2location]))