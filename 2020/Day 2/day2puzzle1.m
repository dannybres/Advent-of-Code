data = readtable("input.txt",TextType="string",ReadVariableNames=false);

data.Properties.VariableNames = ["range","letter","pw"];

data.letter = data.letter.erase(":");
minIns = double(data.range.extractBefore("-"));
maxIns = double(data.range.extractAfter("-"));

data = [data table(minIns) table(maxIns)];

instances = cell2mat(arrayfun(@count,data.pw,data.letter,'UniformOutput',false))

acceptable = instances >= data.minIns & instances <= data.maxIns;

data = [data table(instances) table(acceptable)] 

day2puzzle1result = sum(data.acceptable)