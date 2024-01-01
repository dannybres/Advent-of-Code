import numpy as np

lines = open("14.txt").read().replace(" can fly","").replace("km/s for ","").replace(" seconds, but then must rest for","").replace(" seconds.","").splitlines()

def position(line,t):
    reindeer, speed, duration, rest = line.split(" ")
    rest = float(rest)
    duration = float(duration)
    speed = float(speed)
    cycles = int(t / (duration + rest))
    remaining = min(duration, t % (duration + rest))
    activeFor = cycles * duration + remaining
    return float(activeFor * speed)

r = 0
time = 2503
for line in lines:
    r = int(max(r,position(line,time)))
print(r)

t = [float(0)] * len(lines)
p = [0] * len(lines)
for time in range(1,time + 1):
    for i, line in enumerate(lines):
        p[i] = position(line,time)
    t = [t[x] + float(p[x] == max(p)) for x in range(len(lines))] 

print(int(max(t)))