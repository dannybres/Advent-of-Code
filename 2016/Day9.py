line = open("Day9.txt").read()

i = 0
decompressedLength = len(line)
while i < len(line):
    if line[i] == "(":
        decryptionInfo = tuple([int(x) for x in line[i+1:].split(")")[0].split("x")])
        decryprLen = len(str(decryptionInfo[0])) + len(str(decryptionInfo[1])) + 3
        decompressedLength += decryptionInfo[0] * (decryptionInfo[1] - 1) - decryprLen
        i += decryprLen + decryptionInfo[0]
    else:
        i += 1

print(decompressedLength)

def determineDecompressedLength(s,num):
    print((s,num))
    decompressedLength = len(s)
    i = 0
    while i < len(s):
        if s[i] == "(":
            bracketContent = s[i+1:].split(")")[0]
            decryptionInfo = tuple([int(x) for x in bracketContent.split("x")])
            decompressedLength += determineDecompressedLength(s[i+2+len(bracketContent):i+2+len(bracketContent)+decryptionInfo[0]],decryptionInfo[1]) - decryptionInfo[0] - len(bracketContent) - 2
            i += len(bracketContent) + 2 + decryptionInfo[0]
        else:
            i += 1
    a = decompressedLength * num
    print(a)
    return(a)

print(determineDecompressedLength(line,1))