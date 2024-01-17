from itertools import combinations
from heapq import heappush, heappop

def displayDevices(devices,e):
    displayDev = devices.copy()
    displayDev.reverse()
    for n,d in enumerate(displayDev):
        print("F%i: %s" % (3 - n,("E " if 3 - n == e else "  ") + " ".join(d)))

def buildDevices(t = ""):
    lines = open("Day11"+ t + ".txt").read().splitlines()
    devices = [[] for x in range(len(lines))]
    for n, line in enumerate(lines[:-1]):
        line = line.split("contains a ")[1].replace(".","").replace(", and a ",", a ").replace(" and a ",", a ").split(", a ")
        for element in line:
            type, device = element.replace("-compatible","").split(" ")
            devices[n].append(type + device[0])
    for n in devices:
        n.sort()
    return devices

def isFloorValid(f):
    microchips =  [x[:-1] for x in f if x[-1] == "m"]
    generators =  [x[:-1] for x in f if x[-1] == "g"]
    return all([generators.count(c) != 0 for c in microchips]) or len(generators) == 0

def getKey(devices):
    allDevices = set()
    for floor in devices:
        for x in floor:
            allDevices.add(x[:-1])
    key = [0 for x in range(len(allDevices))]
    for floor,deviceGroup in enumerate(devices):
        for device in deviceGroup:
            element = device[:-1]
            type = device[-1]
            value = (floor + 1) * (1 if type == "m" else 10)
            keyIdx = [n for n,dev in enumerate(allDevices) if dev == element]
            key[keyIdx[0]] += value
    key.sort()
    return key
    
def findMinimumLiftMovesToAllObjectsToTopFloor(devices):
    pq = [(0, devices,0)]
    while pq:
        costSoFar,devices, e = heappop(pq)
        if sum([len(x) for x in devices[:-1]]) == 0:
            return costSoFar

        if (getKey(devices),e) in seen:
            continue

        seen.append((getKey(devices),e))
        toMove = []
        for dev in list(combinations(devices[e],2)) + list(combinations(devices[e],1)):
            for dir in [-1, 1]:
                nextFloor = e + dir 
                if nextFloor < 0 or nextFloor >= len(devices):
                    continue
                newNextFloorOption = devices[nextFloor] + list(dev)
                newCurrentFloorOptions = [x for x in devices[e] if list(dev).count(x) == 0]
                if isFloorValid(newCurrentFloorOptions) and isFloorValid(newNextFloorOption):
                    nextDeviceConfiguration = devices.copy()
                    nextDeviceConfiguration[e] = newCurrentFloorOptions
                    nextDeviceConfiguration[nextFloor] = newNextFloorOption
                    if (getKey(nextDeviceConfiguration),nextFloor) in seen:
                        continue
                    firstFloorWithDevices = 0
                    for n in range(1,4):
                        if len(devices[n-1]) == 0:
                            firstFloorWithDevices = n
                        else:
                            break
                    if nextFloor < firstFloorWithDevices:
                        continue
                    toMove.append((dev,dir,(costSoFar+1,nextDeviceConfiguration,nextFloor)))
                    # heappush(pq,(costSoFar+1,nextDeviceConfiguration,nextFloor))

        movesUp = [x for x in toMove if x[1] == 1]
        
        if movesUp:
            alreadyMoved = set()
            for m in movesUp:
                if len(m[0]) > 1:
                    for n in list(m[0]):
                        alreadyMoved.add(n)
                else:
                     if  list(m[0])[0] in alreadyMoved:
                         toMove.remove(m)
                    
        for move in toMove:
            heappush(pq,move[2])

seen = []
devices = buildDevices()
print(findMinimumLiftMovesToAllObjectsToTopFloor(devices))

devices = buildDevices()
lines = open("Day11b.txt").read().splitlines()
for line in lines:
    ele,type = line.split(" ",1)[1].replace("-compatible","").split(" ")
    devices[0].append(ele + type[0])
print(findMinimumLiftMovesToAllObjectsToTopFloor(devices))