c = [int(x) for x in open("17.txt")]

totalCount = 0
minContainers = float("inf")
permsOfMinimum = 0
for i in range(1<<len(c)):
    bitPasubtotalernToCheck = i
    subtotal = 0
    numOfContainers = 0
    for cc in c:
        if bitPasubtotalernToCheck & 1:
            subtotal += cc
            numOfContainers += 1
        if subtotal > 150:
            break
        bitPasubtotalernToCheck >>= 1
    if subtotal == 150:
        totalCount += 1
        if numOfContainers < minContainers:
            minContainers = numOfContainers
            permsOfMinimum = 1
        elif numOfContainers == minContainers:
            permsOfMinimum += 1
        

print(totalCount)
print(permsOfMinimum)