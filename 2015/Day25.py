r, c = (2947, 3029)
c1 = r + c - 1 - 1 # find row in c1 that is before it (extra -1 as lazy sequence is 0 based)
vc1 = (c1*c1 + c1 + 2)/2 # work out its index in sequence (1 2 4 7 11 - Lazy caterer's sequence)
idx = int(vc1 + c - 1) # add number of cols back on to determine the value
n,mul,mod = (20151125, 252533, 33554393)
for i in range(idx-1): # loop to point
    n = (n*mul)%mod
print(n)