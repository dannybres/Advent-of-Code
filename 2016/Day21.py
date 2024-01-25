def scramble(password):
    lines = open("Day21.txt").read().splitlines()
    for line in lines:
        type, *args = line.split(" ")
        if type == "swap":
            if args[0] == "position":
                l1,l2 = password[int(args[1])],password[int(args[-1])]
            else:
                l1,l2 = args[1],args[-1]
            password = password.replace(l1,"*")
            password = password.replace(l2,l1)
            password = password.replace("*",l2)
        elif type == "rotate":
            if args[0] == "based":
                shiftBy = [n for n,x in enumerate(password) if x == args[-1]][0] + 1
                if shiftBy > 4:
                    shiftBy += 1
                shiftBy = shiftBy % len(password)
                password = password[-shiftBy:] + password[:-shiftBy]
            elif args[0] == "left":
                password = password[int(args[1]) % len(password):] + password[:int(args[1]) % len(password)]
            else:
                password = password[-int(args[1]) % len(password):] + password[:-int(args[1]) % len(password)]
        elif type == "reverse":
            assert args[0] == "positions"
            s,e = int(args[1]),int(args[-1])
            password = password[:s] + password[s:e+1][::-1] + password[e+1:]
        elif type == "move":
            p1,p2 = int(args[1]),int(args[-1])
            char = password[p1]
            stringWithRemoved = password[:p1] + password[p1+1:]
            password = stringWithRemoved[:p2] + char + stringWithRemoved[p2:]
    return password

print(scramble("abcdefgh"))