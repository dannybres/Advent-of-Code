import hashlib
passcode = "pvhmgsws"
target = (3,3)
roomNum = 4

def nextStep(location,path,part2 = False):
    def nextOptions(location,path):
        def doorState(hashString):
            s = hashlib.md5(hashString.encode()).hexdigest()
            return [True if any(m in c for m in ['b', 'c', 'd', 'e', 'f']) else False for c in s[:4]]
        options = []
        for n,dir in enumerate([(-1,0),(1,0),(0,-1),(0,1)]):
            nr,nc = location[0] + dir[0], location[1] + dir[1]
            if 0 <= nr < roomNum and 0 <= nc < roomNum and doorState(passcode+path)[n]:
                options.append(('UDLR'[n],(nr,nc)))
        return options
    if location == target:
        return (0,path)
    desiredSteps = float("-inf") if part2 else float("inf")
    desiredPath = ""
    next = nextOptions(location,path)
    for direction, newLocation in next:
        lengthOfSteps, pathOfSteps = nextStep(newLocation,path + direction,part2)
        f = (lambda a,b : a > b) if part2 else (lambda a,b : a < b)
        if f(lengthOfSteps + 1, desiredSteps):
            desiredSteps = lengthOfSteps + 1
            desiredPath = pathOfSteps
    return (desiredSteps,desiredPath)

s = (0,0)
print(nextStep(s,"")[1])
print(nextStep(s,"",True)[0])
