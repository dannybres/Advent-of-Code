import numpy as np 

target = 33100000

house = [0 for a in range(int(target/10))]
for elf, _ in enumerate(house):
    for houseN in range(elf,len(house),elf+1):
        house[houseN] += (elf + 1) * 10
for i, v in enumerate(house):
    if v >= target:
        break

print(i+1)

house = [0 for a in range(int(target/10))]
for elf, _ in enumerate(house):
    for houseN in range(elf,min(51*(elf+1),len(house)),elf+1):
        house[houseN] += (elf + 1) * 11
for i, v in enumerate(house):
    if v >= target:
        break

print(i+1)