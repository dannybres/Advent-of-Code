lines = open("Day2.txt").read().splitlines()

moves = dict(U=(-1,0),D=(1,0),L=(0,-1),R=(0,1))

result = ""
for line in lines:
    x,y = 2,2
    for char in line:
        dx,dy = moves[char]
        x, y = min(max(1,x+dx),3), min(max(1,y+dy),3)
    result += str((x-1)*3 + y)
print(result)

keypad = [k.replace(" ","")for k in open("Day2keypad.txt").read().splitlines()]
result = ""
for line in lines:
    x,y = 2, 0
    for char in line:
        dx,dy = moves[char]
        nx, ny = min(max(0,x+dx),4), min(max(0,y+dy),4)
        if abs(nx - 2) + abs(ny - 2) <= 2:
            x, y = nx, ny
    result += keypad[x][y - abs(2 - x)]
    
print(result)