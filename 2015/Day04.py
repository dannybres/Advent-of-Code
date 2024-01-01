import hashlib
key = 'bgvyzdsv'

n = 0
while 1:
    q = key + str(n)
    result = hashlib.md5(q.encode())
    if result.hexdigest()[:5] == "00000":
        break
    n += 1

print(n)

n = 0
while 1:
    q = key + str(n)
    result = hashlib.md5(q.encode())
    if result.hexdigest()[:6] == "000000":
        break
    n += 1

print(n)
