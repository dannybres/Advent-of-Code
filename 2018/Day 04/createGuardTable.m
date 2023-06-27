function guardT = createGuardTable(t)
idx = 1;
while idx < height(t)
    toPro = t(idx,:);
    if toPro.event.startsWith("Guard")
        toPro = t(idx,:);
        out = regexp(toPro.event,"Guard #(\d+) begins shift",'tokens');
        
        newR = [table(toPro.date, double(out{:}),...
            VariableNames=["date","guard"]) ...
            array2table(zeros(1,60),VariableNames="m" + (0:59))];
        if ~exist("guardT","var")
            guardT = newR;
        else
            guardT = [guardT; newR]; %#ok<AGROW> 
        end
    else
        toPro = minute(t{idx:idx+1,"date"});
        guardT(end,"m" + (toPro(1):toPro(2)-1)) = {1};
        idx = idx + 1;
    end
    idx = idx + 1;
end

guardT = [guardT ...
    table(sum(guardT{:,3:end},2),VariableNames= "total asleep")];
end