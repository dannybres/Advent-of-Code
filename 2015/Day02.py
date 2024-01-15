lines = open("2.txt").read().splitlines()

totalAreaOfPaper = 0
for dimensions in lines:
    height,width,length = map(int,dimensions.split("x"))
    totalAreaOfPaper = totalAreaOfPaper + 2*length*width + 2*width*height + 2*height*length + min(width*height,width*length,height*length)
print(totalAreaOfPaper)

totalLengthOfRibbon = 0
for dimensions in lines:
    dimensions = sorted([int(x) for x in dimensions.split("x")])
    totalLengthOfRibbon = totalLengthOfRibbon + 2 * sum(dimensions[:2]) + dimensions[0]*dimensions[1]*dimensions[2]
print(totalLengthOfRibbon)