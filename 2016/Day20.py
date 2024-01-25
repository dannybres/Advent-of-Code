blacklist = open("Day20.txt").read().splitlines()
blacklist = [(int(a.split("-")[0]),int(a.split("-")[1])) for a in blacklist]
blacklist.sort()

n = 4294967295
allowed = [(0,n)]
for blacklistRange in blacklist:
    newAllowed = []
    for allowRange in allowed:
        if blacklistRange[0] <= allowRange[0] and blacklistRange[1] < allowRange[1] and blacklistRange[1] > allowRange[0]: # trim start
            newAllowed.append((blacklistRange[1]+1, allowRange[1]))
        elif blacklistRange[0] < allowRange[1] and blacklistRange[1] >= allowRange[1]: # trim end
            newAllowed.append((allowRange[0],blacklistRange[0]-1))
        elif blacklistRange[0] > allowRange[0] and blacklistRange[1] < allowRange[1]: # fully contained
            newAllowed.append((allowRange[0],blacklistRange[0]-1))
            newAllowed.append((blacklistRange[1]+1,allowRange[1]))
        else:
            newAllowed.append(allowRange)
    allowed = newAllowed

lowestIP = n            
allowedCount = 0
for s,e in allowed:
    lowestIP = min(s,lowestIP)
    allowedCount += 1 + e - s

print(lowestIP)
print(allowedCount)