function makeFiles(y)
mkdir(y)
for idx = 1:25
    mkdir(fullfile(y,"Day " + sprintf("%02i",idx)))
    for pidx = 1:2
        fn = fullfile(y,"Day " + sprintf("%02i",idx),"day" + idx + "puzzle" + pidx + ".txt");
        comm(1) = "%% day" + idx + "puzzle" + pidx + " - Daniel Breslan - Advent Of Code " + y;
        comm(2) = "data = readlines(""inputDemo.txt"")";
        comm(5) = "day" + idx + "puzzle" + pidx + "result = 0;";
        writematrix(comm',fn,QuoteStrings=false)
        movefile(fn,fn.replace(".txt",".m"))
    end
    writematrix("",fullfile(y,"Day " + sprintf("%02i",idx),"inputDemo.txt"))
    writematrix("",fullfile(y,"Day " + sprintf("%02i",idx),"input.txt"))
end
end