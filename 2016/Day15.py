from modint import ChineseRemainderConstructor, chinese_remainder

lines = open("Day15.txt").read().splitlines()
teeth = []
rem = []
for line in lines:
    a = line[:-1].split(" ")
    teeth.append(int(a[3]))
    rem.append(int(a[-1]))

r = [(teeth[x] - rem[x] - (x + 1)) % teeth[x] for x in range(len(rem))]
print(chinese_remainder(teeth,r))

teeth.append(11)
rem.append(0)

r = [(teeth[x] - rem[x] - (x + 1)) % teeth[x] for x in range(len(rem))]
print(chinese_remainder(teeth,r))