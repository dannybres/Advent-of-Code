lastLine = ".^^^^^.^^.^^^.^...^..^^.^.^..^^^^^^^^^^..^...^^.^..^^^^..^^^^...^.^.^^^^^^^^....^..^^^^^^.^^^.^^^.^^"
n = 400000

def findSafeSpaces(lastLine,r):
    nextline = ["." for x in range(len(lastLine))]
    paddedLine = "." + lastLine + "."
    for n in range(len(nextline)):
        if paddedLine[n:n+3:2].count("^") == 1:
            nextline[n] = "^"
    nextline = "".join(nextline)
    r += nextline.count(".")
    return (nextline,r)

r = lastLine.count(".")
for n in range(n-1):
    lastLine,r = findSafeSpaces(lastLine,r)

print(r)