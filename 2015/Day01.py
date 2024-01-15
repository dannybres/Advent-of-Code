line = open("1.txt").read()
print(line.count('(') - line.count(')'))

floorNumber = 0
for characterPosition in range(len(line)):
    if line[characterPosition] == '(':
        floorNumber += 1
    else:
        floorNumber -= 1
        
    if floorNumber == -1:
        break
        
print(characterPosition+1)