import hashlib

def firstValueToStartWith(key,numberOfZeros):
    n = 0
    while 1:
        q = key + str(n)
        result = hashlib.md5(q.encode())
        if result.hexdigest()[:numberOfZeros] == "0" * numberOfZeros:
            break
        n += 1
    return(n)

key = 'bgvyzdsv'
print(firstValueToStartWith(key,5))
print(firstValueToStartWith(key,6))