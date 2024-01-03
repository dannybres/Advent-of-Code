def find_divisors(number):
    divisors = []
    for i in range(1, number + 1):
        if number % i == 0:
            divisors.append(i)
    return divisors

# Example usage:
i = 1
while True:
    result = find_divisors(i)
    r = sum([x*10 for x in result])
    # print(r)
    if r >= 33100000:
        # print(i)
        break
    i += 1

print(i)
