import hashlib

key = 'reyedfim'
n = 0
passwordForPart1 = []
passwordForPart2 = [""] * 8

numberOfZeros = 5
while 1:
    q = key + str(n)
    result = hashlib.md5(q.encode())
    result = result.hexdigest()
    if result[:numberOfZeros] == "0" * numberOfZeros:
        print(result)
        passwordForPart1.append(result[5])
        try:
            if passwordForPart2[int(result[5])] == "":
                passwordForPart2[int(result[5])] = result[6]
        except:
            pass
    n += 1
    if len(passwordForPart1) >= 8 and all([x != "" for x in passwordForPart2]):
        break

print(''.join(passwordForPart1)[:8])
print(''.join(passwordForPart2))
