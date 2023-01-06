data = readlines("d2.txt").split(",").double();
data(2:3) = [12 2];
[~, data] = processIntCodeComputer(data); 
d2p1 = data(0) == 5110675;

data = readlines("d2.txt").split(",").double();
data(2:3) = [48 47];
[~, data] = processIntCodeComputer(data,1); 
d2p2 = 19690720 == data(0); 

data = readlines("d5.txt").split(",").double();
output = processIntCodeComputer(data,1);
d5p1 = all(output == [zeros(numel(output)-1,1); 6745903]);

data = readlines("d5.txt").split(",").double();
output = processIntCodeComputer(data,5);
d5p2 = 9168267 == output;

testsuccess = [d2p1 d2p2 d5p1 d5p2] %#ok<NOPTS> 