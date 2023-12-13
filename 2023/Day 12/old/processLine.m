function n = processLine(springs,counts,numDoneinGroup)
persistent mf
if isempty(mf)
    mf = memoize(@processLine);
    mf.CacheSize = 100;
end
% mf = @processLine;
n = 0;
if (numel(springs) + numDoneinGroup) < (sum(counts) + numel(counts) - 1)
    return
end
if sum(any(springs == ('?#')')) < (sum(counts) - numDoneinGroup)
    return
end
if sum(any(springs == ('?.')')) < numel(counts) - 1
    return
end
if numDoneinGroup & ~isempty(counts)
    if counts(1) - numDoneinGroup > 0
        if springs(counts(1) - numDoneinGroup + 1) == '#'
            return
        end
    end
end
if isempty(springs)
    if isempty(counts) && numDoneinGroup == 0
        n = 1;
    end
    return
end

if springs(1) == '?'
    possible = '.#';
else
    possible = springs(1);
end
for idx = possible
    if idx == '#'
        n = n + mf(springs(2:end),counts,numDoneinGroup + 1);
    else
        if numDoneinGroup
            if ~isempty(counts)
                if numDoneinGroup > counts(1)
                    return
                end
                if counts(1) == numDoneinGroup
                    n = n + mf(springs(2:end),counts(2:end),0);
                end
            end
        else % known - move on
            n = n + mf(springs(2:end),counts,0);
        end
    end
end
end

