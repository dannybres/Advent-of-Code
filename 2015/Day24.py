from itertools import combinations
presents = [int(line.strip()) for line in open('24.txt')]
def minimumQuantumEntanglement(groups):
    for i in range(len(presents)):
        combos = [comb for comb in combinations(presents, i) if sum(comb) == sum(presents)/groups]
        if len(combos) != 0:
            break
    minQuEn = float("inf")
    for c in combos:
        product = 1
        for p in list(c):
            product *= p
        minQuEn = min(minQuEn,product)
    return minQuEn
print(minimumQuantumEntanglement(3))
print(minimumQuantumEntanglement(4))