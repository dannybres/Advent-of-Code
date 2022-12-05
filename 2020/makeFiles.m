for idx = 1:25
    mkdir("Day " + idx)
    for pidx = 1:2
        edit(fullfile("day " + idx,"day" + idx + "puzzle" + pidx + ".m"))
    end
    edit(fullfile("day " + idx,"inputDemo.txt"))
    edit(fullfile("day " + idx,"input.txt"))
end