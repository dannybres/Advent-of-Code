from itertools import combinations

def displayDevices(devices,e):
    displayDev = devices.copy()
    displayDev.reverse()
    for n,d in enumerate(displayDev):
        print("F%i: %s" % (3 - n,("E " if 3 - n == e else "  ") + " ".join(d)))
    print()

def buildDevices(t):
    lines = open("Day11"+ t + ".txt").read().splitlines()
    devices = [[] for x in range(len(lines))]
    for n, line in enumerate(lines[:-1]):
        line = line.split("contains a ")[1].replace(".","").replace(", and a ",", a ").replace(" and a ",", a ").split(", a ")
        for element in line:
            type, device = element.split(" ")
            devices[n].append(type[0] + device[0])
    for n in devices:
        n.sort()
    return devices

def isFloorValid(f):
    microchips =  [x[0] for x in f if x[1] == "m"]
    generators =  [x[0] for x in f if x[1] == "g"]
    return all([generators.count(c) != 0 for c in microchips]) or len(generators) == 0

def nextStep(devices,e):
    if sum([len(x) for x in devices[:-1]]) == 0:
        print("end!!!!!!!!!!!!!!!!")
        return 0
    
    cost = float("inf")
    key = ",".join(["".join(x) for x in devices]) # MAYBE need to alphabetise the keys here.
    seen.add(key)

    for dev in list(combinations(devices[e],2)) + list(combinations(devices[e],1)):
        for dir in [-1, 1]:
            nextFloor = e + dir 
            if nextFloor < 0 or nextFloor >= len(devices):
                continue
            newNextFloorOption = devices[nextFloor] + list(dev)
            newCurrentFloorOptions = [x for x in devices[e] if list(dev).count(x) == 0]
            if isFloorValid(newCurrentFloorOptions) and isFloorValid(newNextFloorOption):
                newConfigKey = ",".join(["".join(x) for x in devices]) # MAYBE need to alphabetise the keys here.

                nextDeviceConfiguration = devices.copy()
                nextDeviceConfiguration[e] = newCurrentFloorOptions
                nextDeviceConfiguration[nextFloor] = newNextFloorOption
                for n in nextDeviceConfiguration:
                    n.sort()
                newConfigKey = ",".join(["".join(x) for x in nextDeviceConfiguration]) # MAYBE need to alphabetise the keys here.
                if newConfigKey in seen:
                    continue
                # print("Next Options Found:")
                # print("Next floor %i: %s (%s)" % (nextFloor, ", ".join(newNextFloorOption),"valid" if isFloorValid(newNextFloorOption) else "not valid"))
                # print("Current floor %i: %s (%s)" % (e, ", ".join(newCurrentFloorOptions),"valid" if isFloorValid(newCurrentFloorOptions) else "not valid"))
                # displayDevices(devices,e)
                # displayDevices(nextDeviceConfiguration,nextFloor)
                # print()
                cost = min(cost,nextStep(nextDeviceConfiguration,nextFloor)+1)

    return cost

seen = set()
devices = buildDevices("a")
e = 0
inElevator = []
print(nextStep(devices,e))