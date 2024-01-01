def pathOfVisits(directions):
        visited = []
        visited.append((0,0))
        for i in range(len(directions)):
                r,c = visited[-1]
                if directions[i] == "v":
                        r += 1
                elif directions[i] == "^":
                        r -= 1
                elif directions[i] == "<":
                        c -= 1
                elif directions[i] == ">":
                        c += 1
                visited.append((r,c))
        return(visited)

line = open("3.txt").read()
print(len(set(pathOfVisits(line))))
print(len(set(pathOfVisits(line[::2]) + pathOfVisits(line[1::2]))))