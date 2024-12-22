%% day21puzzle2 - Daniel Breslan - Advent Of Code 2024
l = readlines("input.txt");

numKp = ['789';'456';'123';' 0A'];
dirKp = [' ^A';'<v>'];
n = 25;
day21puzzle2result = 0;
clear pressesForKeypad
for li = 1:numel(l)
    a = char(commandsForKeypad(char(l(li)),numKp));

    cou = 0;
    for idx = 1:numel(a)
        c = a(idx);
        cou = cou + pressesForKeypad(c,dirKp,n);%,state);
    end
    day21puzzle2result = day21puzzle2result + ...
        cou .* l(li).extract(digitsPattern).double();
end
day21puzzle2result



function presses = pressesForKeypad(character, keypad, depth)%,state)
persistent locationsOfRobots
persistent cache
[sr,sc] = find(keypad == 'A');
if isempty(locationsOfRobots)
    locationsOfRobots = [sr sc];
    locationsOfRobots = repmat(locationsOfRobots,25,1);
    cache = configureDictionary("string","double");
end
if depth == 0
    presses = 1;
    return
end
cr = locationsOfRobots(depth,1);
cc = locationsOfRobots(depth,2);
[tr,tc] = find(keypad == character);

key = compose("%s%i%i%i",character,cr,cc,depth);
if isKey(cache,key)
    presses = cache(key);
    locationsOfRobots(depth,:) = repmat([tr tc],1,1);
    return
end
[dangerR,dangerC] = find(keypad == ' '); % danger = empty square
commands = "";
[tr,tc] = find(keypad == character);
rowMove = tr - cr;
colMove = tc - cc;
up = abs(min([0 rowMove]));
down = max([0 rowMove]);
left = abs(min([0 colMove]));
right = max([0 colMove]);
route = [repmat('^',1,up), repmat('v',1,down), ...
    repmat('<',1,left), repmat('>',1,right)];
if nnz([left right up down]) > 1 % multiple dir
    if dangerC == tc && cr == dangerR || dangerR == tr && cc == dangerC 
        % one route will pass invlalid only add the other
        if cr == dangerR % danger is on row, so only add vert move first
            commands = commands + string(route) + "A";
        else % danger is on col, so only add hori move first
            commands = commands + string(fliplr(route)) + "A";
        end
    else % not near danger
        if left % do horizontal move first (so left first)
            commands = commands + string(fliplr(route)) + "A";
        else
            commands = commands + string(route) + "A";
        end
    end
else
commands = commands + string(route) + "A"; % single dir, no options
end
locationsOfRobots(depth,:) = [tr tc]; 
presses = 0;
for c = char(commands)
    presses = presses + pressesForKeypad(c,keypad,depth-1);%,state);
end
cache(key) = presses;
end

function commands = commandsForKeypad(code,keypad)
stBit = [0 1 0 0];
code = char(code);
[cr,cc] = find(keypad == 'A');
[dar,dac] = find(keypad == ' ');

commands = "";
for idx = 1:numel(code)
    target = code(idx);
    [tr,tc] = find(keypad == target);
    dr = tr - cr; dc = tc - cc;
    u = abs(min([0 dr]));
    d = max([0 dr]);
    l = abs(min([0 dc]));
    r = max([0 dc]);
    route = [repmat('^',1,u), repmat('v',1,d), repmat('<',1,l), repmat('>',1,r)];
    if nnz([l r u d]) > 1 % multiple dir
        if dac == tc && cr == dar || dar == tr && cc == dac % one route will pass invlalid only add the other
            if cr == dar % danger is on row, so only add vert move first
                commands = commands + string(route) + "A";
            else % danger is on col, so only add hori move first
                commands = commands + string(fliplr(route)) + "A";
            end
        else
            if stBit(abs(sum(double([u d l r] ~= 0) .* 2.^(0:3)) - 6.5) + 0.5)
                commands = commands + string(fliplr(route)) + "A";
            else
                commands = commands + string(route) + "A";
            end
        end
    else
        commands = commands + string(route) + "A";
    end
    cr = tr;
    cc = tc;
end
commands = unique(commands,'row');
end
