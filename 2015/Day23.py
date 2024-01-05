def runLittleJaneMarieVeryFirstComputer(registers):
    lines = open("23.txt").read().replace("to","=").splitlines()
    currentInstruction = 0
    while currentInstruction < len(lines):
        inst,arg = lines[currentInstruction].split(" ",1)
        if inst == "hlf":
            registers[arg] *= 0.5
        elif inst == "tpl":
            registers[arg] *= 3
        elif inst == "inc":
            registers[arg] += 1
        elif inst == "jmp":
            currentInstruction = currentInstruction + int(arg)
            continue
        elif inst == "jie":
            r, offset = arg.split(", ")
            currentInstruction = currentInstruction + 1 if registers[r] % 2 else currentInstruction + int(offset) 
            continue
        elif inst == "jio":
            r, offset = arg.split(", ")
            currentInstruction = currentInstruction + int(offset) if registers[r] == 1 else currentInstruction + 1
            continue
        currentInstruction += 1
    return (registers)

part1 = runLittleJaneMarieVeryFirstComputer(dict(a = 0, b = 0))
print(part1["b"])

part1 = runLittleJaneMarieVeryFirstComputer(dict(a = 1, b = 0))
print(part1["b"])