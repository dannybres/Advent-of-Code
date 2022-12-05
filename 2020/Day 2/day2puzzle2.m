data = readtable("input.txt",TextType="string",ReadVariableNames=false);

data.Properties.VariableNames = ["range","letter","pw"];

data.letter = data.letter.erase(":");
minIns = double(data.range.extractBefore("-"));
maxIns = double(data.range.extractAfter("-"));

data = [data table(minIns) table(maxIns)];

acceptable = double(data.pw.extractBetween(data.minIns,data.minIns) ...
    == data.letter) + double(data.pw.extractBetween(data.maxIns, ...
    data.maxIns) == data.letter) == 1

data = [data table(acceptable)] 

day2puzzle2result = sum(data.acceptable)