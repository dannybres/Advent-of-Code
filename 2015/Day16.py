lines = open("16.txt").read().replace(":","").replace(",","").splitlines()
sueData = open("16sue.txt").read().splitlines()

s = dict()
for ele in sueData:
    type,val = ele.split(": ")
    s[type] = int(val)

for line in lines:
    data = line.split(" ")
    a = data[2:]
    thisSue = True
    for i, e in enumerate(a[::2]):
        if s[e] != int(a[2*i+1]):
            thisSue = False
    if thisSue:
        sue = int(data[1])

for line in lines:
    data = line.split(" ")
    a = data[2:]
    thisSue = True
    for i, e in enumerate(a[::2]):
        if e == "cats" or e == "trees":
            if s[e] >= int(a[2*i+1]):
                thisSue = False
        elif e == "pomeranians" or e == "goldfish":
            if s[e] <= int(a[2*i+1]):
                thisSue = False
        else:
            if s[e] != int(a[2*i+1]):
                thisSue = False
    if thisSue:
        sue2 = int(data[1])

print(sue)
print(sue2)