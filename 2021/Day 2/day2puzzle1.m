inputData = readtable("input.txt",TextType="string");

[a,direction] = findgroups(inputData.Var1);
sumOfDistance = splitapply(@sum,inputData.Var2,a);

summary = table(sumOfDistance);
summary.Properties.RowNames = direction;

day2puzzle1Result = summary{"forward","sumOfDistance"} * ...
    (summary{"down","sumOfDistance"} - summary{"up","sumOfDistance"})