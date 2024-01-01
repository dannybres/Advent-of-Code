import numpy as np

def process(lines):
    knowns = dict()
    while lines:
    # for i in range(4):
        for line in reversed(lines):
            lhs, rhs = line.split(" -> ")
            parts = lhs.split(" ")
            if len(parts) == 1:
                if lhs.isdigit():
                    knowns[rhs] = int(lhs)
                    lines.remove(line)
                elif parts[0] in knowns: # another value
                        knowns[rhs] = knowns[parts[0]]
                        lines.remove(line)
            elif len(parts) == 2: # NOT
                v1 = float('nan')
                if parts[1].isdigit():
                    v1 = parts[1]
                elif parts[1] in knowns:
                    v1 = knowns[parts[1]]
                if v1 == v1:
                    knowns[rhs] = np.invert(np.uint16(v1))
                    lines.remove(line)
            else:
                v1 = float('nan')
                if parts[0].isdigit():
                    v1 = parts[0]
                elif parts[0] in knowns:
                    v1 = knowns[parts[0]]
                v2 = float('nan')
                if parts[2].isdigit():
                    v2 = parts[2]
                elif parts[2] in knowns:
                    v2 = knowns[parts[2]]

                if v1 == v1 and v2 == v2:
                    if parts[1] == "AND": # AND
                        knowns[rhs] = np.bitwise_and(np.uint16(v1),np.uint16(v2))
                        lines.remove(line)
                    elif parts[1] == "OR": # OR
                        knowns[rhs] = np.bitwise_or(np.uint16(v1),np.uint16(v2))
                        lines.remove(line)
                    elif parts[1] == "LSHIFT": # LSHIFT
                        knowns[rhs] = np.left_shift(np.uint16(v1),np.uint16(v2))
                        lines.remove(line)
                    elif parts[1] == "RSHIFT": # RSHIFT
                        knowns[rhs] = np.right_shift(np.uint16(v1),np.uint16(v2))
                        lines.remove(line)
    return knowns["a"]

lines = open("7.txt").read().splitlines()
a1 = process(lines.copy())
print(a1)

for line in lines:
    if line.endswith("-> b"):
        lines.remove(line)
lines.append(str(a1) + " -> b")
a2 = process(lines.copy())
print(a2)