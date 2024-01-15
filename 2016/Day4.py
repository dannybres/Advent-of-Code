lines = open("Day4.txt").read().splitlines()

sumOfTheSectorIdsOfTheRealRooms = 0
for line in lines:
    encryptedName = line.rsplit("-",1)[0]
    sectorID = int(line.rsplit("-",1)[1].split("[")[0])
    checksum = line[:-1].split("[")[1]

    uniqueLetters = set()
    [uniqueLetters.add(x) for x in encryptedName.replace("-","")]
    pairs = [] # first is an index to order by, 100 * count, so more count is prioritised, then 26 - position in alphabet, so a = 25 and z  = 0, giving alphanbetical ordering
    for l in uniqueLetters:
        pairs.append((100*encryptedName.replace("-","").count(l) + ord('z')-ord(l)+1,l))
    pairs = sorted(pairs, key=lambda x: x[0], reverse=True) 

    realRoom = ''.join([x[1] for x in pairs[:5]]) == checksum
    sumOfTheSectorIdsOfTheRealRooms += sectorID if realRoom else 0
    if realRoom:
        words = [[ord(c) for c in parts] for parts in encryptedName.split("-")]
        for word in words:
            if ''.join([chr(ord('a') + (w - ord('a') + sectorID) % 26) for w in word]).count("northpole"):
                sectorIdOfTheRoomWhereNorthPoleObjectsAreStored  = sectorID
    
print(sumOfTheSectorIdsOfTheRealRooms)
print(sectorIdOfTheRoomWhereNorthPoleObjectsAreStored)