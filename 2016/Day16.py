import numpy as np

def expand(s,l):
    def makeDragon(a):
        b = a
        b = b[::-1].replace("1","t").replace("0","1").replace("t","0")
        return a + "0" + b
    while len(s) < l:
        s = makeDragon(s)
    s = s[:l]
    return s

def checksum(s):
    e = np.fromiter(s[::2],dtype=int)
    o = np.fromiter(s[1::2],dtype=int)
    b = np.array([])
    while len(b) % 2 == 0:
        b = e == o
        e = b[::2]
        o = b[1::2]
    return ''.join(['1' if d else '0' for d in b])

def expandAndCheck(s,l):
    return checksum(expand(s,l))

s = '01110110101001000'
print(expandAndCheck(s,272))
print(expandAndCheck(s,35651584))