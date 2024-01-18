from heapq import heappush, heappop

favenum = 1364
target = (39,31)

def isItAnOpenSpace(r,c):
    if r < 0 or c < 0:
        return False
    if bin(c*c + 3*c + 2*c*r + r + r*r + favenum).count('1') % 2 == 1:
        return False
    else:
        return True


pq = [(0,1,1)]
seen = []
part1result = 0
part2result = 0

while pq:
    stepsSoFar,r,c = heappop(pq)

    if stepsSoFar > 50 and part2result == 0:
        part2result = len(seen)

    if (r,c) == target and part1result == 0:
        part1result = stepsSoFar

    if part2result != 0 and part1result != 0:
        break

    if (r,c) in seen:
        continue

    seen.append((r,c))
    for dr, dc in [(0,1),(0,-1),(1,0),(-1,0)]:
        nr = r + dr
        nc = c + dc
        if isItAnOpenSpace(nr,nc):
            heappush(pq,(stepsSoFar+1,nr,nc))

print(part1result)
print(part2result)