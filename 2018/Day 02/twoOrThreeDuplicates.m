function result = twoOrThreeDuplicates(stringInput)
stringInput = stringInput.split("");
stringInput = stringInput(2:end-1);

countsOfChar = sum(tril(stringInput == stringInput',-1))+1;
[~,I] = unique(stringInput,'first');
countsOfChar = countsOfChar(I);
result = [any(countsOfChar == 2) any(countsOfChar == 3)];
end