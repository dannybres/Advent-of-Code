import sys
name = "Day" + sys.argv[1]
try:
    extras = [a + ".txt" for a in sys.argv[2].split(",")]
except:
    extras = []
extensions = [".py"] + extras
for e in extensions:
    open(name + e, 'a').close()