line = open("2.txt").read().splitlines()

t = 0
for p in line:
    p = [int(x) for x in p.split("x")]
    h = p[0]
    w = p[1]
    l = p[2]
    t = t + 2*l*w + 2*w*h + 2*h*l + min(w*h,w*l,h*l)
print(t)

t = 0
for p in line:
    p = [int(x) for x in p.split("x")]
    sorted_numbers = sorted(p)
    two_min_values = sorted_numbers[:2]
    t = t + 2 * sum(two_min_values) + p[0]*p[1]*p[2]
print(t)