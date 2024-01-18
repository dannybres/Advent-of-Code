import hashlib

def containsSequence(s,n):
    s = [ord(c) for c in s]
    for i in range(len(s)-n+1):
        if len(set(s[i:i+n])) == 1:
            return chr(s[i])
    return None

def findHash(s,part2 = False):
    if part2:
        for x in range(2017):
            s = hashlib.md5(s.encode()).hexdigest()
        return s
    else:
        return hashlib.md5(s.encode()).hexdigest()

salt = 'ahsbgdzn'
for b  in [False, True]:
    candidate = []       
    confirmed = []
    n = 0
    finalN = float('inf')

    while n < finalN:
        s = salt + str(n)
        hash = findHash(s,b)
        triplet = containsSequence(hash,3)
        quintlet = containsSequence(hash,5)


        if quintlet:
            matches = [x for x in candidate if x[1] == quintlet]
            if matches:
                for m in matches:
                    confirmed.append(m)

        if triplet:
            candidate.append((n,triplet))
        
        for c in candidate:
            if n - c[0] > 1000:
                candidate.remove(c) 
        
        n += 1

        if len(confirmed) > 64 and finalN == float("inf"):
            finalN = n + 1001
            
    confirmed.sort()
    print(confirmed[63][0])