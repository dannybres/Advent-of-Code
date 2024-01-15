lines = open("6.txt").read().replace("turn ","").replace(" through ",",").replace(" ",",").splitlines()
lights = [[0] * 1000 for _ in range(1000)]
lights2 = [[0] * 1000 for _ in range(1000)]
for line in lines:
    type = line.split(',', 1)[0]
    fx,fy,tx,ty = [int(x) for x in line.split(',', 1)[1].split(",")]
    for x in range(fx,tx+1):
        for y in range(fy,ty+1):
            lights[x][y] = 1 if type == 'on' else 0 if type == 'off' else 1 if lights[x][y] == 0 else 0
            lights2[x][y] = lights2[x][y] + 1 if type == 'on' else max(0, lights2[x][y] - 1) if type == 'off' else lights2[x][y] +2
print(sum([sum(x) for x in lights]))
print(sum([sum(x) for x in lights2]))