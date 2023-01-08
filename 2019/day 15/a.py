import copy
def run(program, move, pos, pc, field):
    num_of_operands = [0, 3, 3, 1, 1, 2, 2, 3, 3, 1]
    i, base = pc, 0
    directions, forbidden = {1: (-1, 0), 2: (1,0), 3: (0,-1), 4: (0,1)},{1: 2, 2: 1, 3: 4, 4: 3}
    tiles = ["▒", ".", "W"]
    while program[i] != 99:
        modes = [int(x) for x in f"{program[i]:0>5}"[:3]][::-1]
        instruction = int(f"{program[i]:0>5}"[3:])
        base_tmp = [base if modes[x]==2 else 0 for x in range(num_of_operands[instruction])]
        operands = [program[i+x+1] if modes[x]==1 else program[base_tmp[x]+program[i+x+1]] for x in range(num_of_operands[instruction])]
        if instruction == 1:
            program[base_tmp[2]+program[i+3]] = operands[0] + operands[1]
        elif instruction == 2:
            program[base_tmp[2]+program[i+3]] = operands[0] * operands[1]
        elif instruction == 3:
            program[base_tmp[0]+program[i+1]] = move
        elif instruction == 4:
            field[pos[0]+directions[move][0]][pos[1]+directions[move][1]] = tiles[operands[0]]
            if operands[0] > 0:
                [run(program.copy(), x, [pos[0]+directions[move][0], pos[1]+directions[move][1]], i+num_of_operands[instruction]+1,field) for x in range(1,5) if x != forbidden[move]]
            return
        elif instruction == 5:
            i = (operands[1] - 3) if operands[0]!=0 else i
        elif instruction == 6:
            i = (operands[1] - 3) if operands[0]==0 else i
        elif instruction == 7:
            program[base_tmp[2]+program[i+3]] = int(operands[0] < operands[1])
        elif instruction == 8:
            program[base_tmp[2]+program[i+3]] = int(operands[0] == operands[1])
        elif instruction == 9:
            base += operands[0]
        i += num_of_operands[instruction] + 1
def find_path(x, y, length, field):
    if field[x][y] == "▒" or field[x][y] == "W": return (0,0,0) if field[x][y] == "▒" else (x,y,length)
    field[x][y] = "▒"
    return max([find_path(x+d[0], y+d[1], length+1, field) for d in ((-1, 0), (1,0), (0,-1), (0,1))], key = lambda x: abs(x[0]) + abs(x[1]))
def distance(x1,y1,x2,y2,length,field):
    if field[x1][y1] == "▒": return 0
    if x1 == x2 and y1 == y2: return length
    field[x1][y1] = "▒"
    return max([distance(x1+d[0], y1+d[1], x2, y2, length+1, field) for d in ((-1, 0), (1,0), (0,-1), (0,1))])
with open("input.txt") as file:
    program = [int(x) for x in file.readline().split(",")]+[0]*10000
    field, start = [[" "]*41 for _ in range(41)], [21,21]
    [run(program.copy(), x, start, 0, field) for x in range(1,5)]
    field[start[0]][start[1]]="S"
    found = find_path(start[0], start[1], 0, copy.deepcopy(field))
    print(*[" ".join(x) for x in field],found, sep="\n")
    print(max([distance(found[0], found[1], x, y, 0, copy.deepcopy(field)) for x in range(len(field)) for y in range(len(field[x])) if field[x][y] == "."]))
