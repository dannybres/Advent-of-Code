import math

# https://www.youtube.com/watch?v=uCsD3ZGzMgE
n = 3012210
b = bin(n)[2:]
b = b[1:] + b[0]
print(int(b,2))

# use code below to fine patern - increments by 1, resets at 3^n, when passes last 3^n, increases by 2 not 1.
n = 3012210
zeroReset = pow(3,math.floor(math.log(n,3)))
rem = n - zeroReset
if rem > zeroReset:
    rem += rem - zeroReset
print(rem)

# import matplotlib.pyplot as plt

# def findElfAcrossTheCircle(presents,position,emptyElves):
#         remainingElves = len(presents) - emptyElves
#         halfway = math.floor(remainingElves/2)
#         na = 1
#         f = 0
#         while True:
#             nextPosition = (position + na) % len(presents)
#             if presents[nextPosition] != 0:
#                 f += 1
#                 if f == halfway:
#                     return nextPosition
#             na += 1   

# n = 127

# r = []
# for n in range(1,n+1):
#     presents = [1 for x in range(n)]

#     def findNextNonZeroElfFrom(presents,position):
#         na = 1
#         while True:
#             nextPosition = (position + na) % len(presents)
#             if presents[nextPosition] != 0:
#                 return nextPosition
#             na += 1    

    
#     position = 0
#     emptyElves = 0
#     while emptyElves < n - 1:
#         if presents[position] == 0:
#             position = (position + 1) % len(presents)
#             continue
#         stealFrom = findElfAcrossTheCircle(presents,position,emptyElves)
#         nextPosition = findNextNonZeroElfFrom(presents,position)
#         # stealFrom = nextPosition
#         presents[position] += presents[stealFrom]
#         presents[stealFrom] = 0
#         emptyElves += 1
#         position = findNextNonZeroElfFrom(presents,position)

#     r.append([x for x in range(len(presents)) if presents[x] != 0][0] + 1)


