import math

def incrementPasswordBy(a,n):
    a[-1] = a[-1] + n
    while not all([x<26 for x in a]):
        toInc = [math.floor(x/26) for x in a]
        a = [x % 26 for x in a]
        for x in range(1,len(toInc)):
            a[x-1] = a[x-1] + toInc[x]
            
    a = [x if (x!=8 and x!=11 and x!=14) else x+1 for x in a]
    return a

def isValid(a):
    characterSequence = any([a[x] == a[x+1]-1 == a[x+2]-2 for x in range(len(a)-2)])
    
    doublePair = False
    lastMatch = float("nan")
    for x in range(len(a)-1):
        if a[x] == a[x+1]:
            if lastMatch == lastMatch and lastMatch < x - 1:
                doublePair = True
                break
            lastMatch = x
    return characterSequence and doublePair 

input = "vzbxkghb"
a = [ord(input[x]) - ord("a") for x in range(len(input))]

shifted = False
for x in range(len(a)):
    if shifted:
        a[x] = 0
    if a[x] == 8 or a[x] == 11 or a[x] == 14:
        a[x] = a[x] + 1
        shifted = True
        

while not isValid(a):
    a = incrementPasswordBy(a,1)
    
print("".join([chr(x + ord("a")) for x in a]))

a = incrementPasswordBy(a,1)

while not isValid(a):
    a = incrementPasswordBy(a,1)
    
print("".join([chr(x + ord("a")) for x in a]))
