line = open("1.txt").read()
print(line.count('(') - line.count(')'))

r = 0
for i in range(len(line)):
    if line[i] == '(':
        r += 1
    else:
        r -= 1
        
    if r == -1:
        break
        
print(i+1)