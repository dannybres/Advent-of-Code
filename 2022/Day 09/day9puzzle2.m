%% day9puzzle2 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").replace(["U","D","L","R"],string(1:4))...
    .split(" ").double();

dirs = [...
    0  1;...   % U 
    0  -1;...  % D
    -1 0;...   % L
    1  0       % R
    ];

hlocations = [0 0;cumsum(dirs(repelem(data(:,1),data(:,2),1),:))];
locations = zeros([size(hlocations) 10]);
locations(:,:,1) = hlocations;

for idx = 2:size(locations,1)
    for tidx = 2:size(locations,3)
        newH = locations(idx,:,tidx-1);
        currentT = locations(idx - 1,:,tidx);
        posDelta = diff([currentT; newH]);
        if all(abs(posDelta) < 2) % no move needed
            locations(idx,:,tidx) = locations(idx - 1,:,tidx);
        elseif any(posDelta == 0) % need to move U,D,L,R
            locations(idx,:,tidx) = locations(idx - 1,:,tidx)...
                + posDelta / 2;
        else % need to move diag
            locations(idx,:,tidx) = locations(idx - 1,:,tidx)...
                + sign(posDelta);
        end
    end
end

day9puzzle2result = size(unique(locations(:,:,end),'rows'),1) %#ok<NOPTS> 


%% Visualisation
n = 30;
vw = VideoWriter("out" + n + ".mp4","MPEG-4");
vw.FrameRate = 900;
open(vw)
close all
f = figure(Visible="off");
a = axes();
grid on
xlim([min(squeeze(locations(:,1,:)),[],'all') max(squeeze(locations(:,1,:)),[],'all')]);
ylim([min(squeeze(locations(:,2,:)),[],'all') max(squeeze(locations(:,2,:)),[],'all')]);
a.XLimMode = "manual";
a.YLimMode = "manual";
hold all
for idx = 1:n:size(locations,1)
    if mod(idx-1,n*20*30) == 0
        disp(idx)
    end
    coords = squeeze(locations(idx,:,:))';
    if exist("p","var")
        delete(p)
        delete(pp)
    end
    p = plot(a,coords(:,1),coords(:,2),'bo');
    pp = plot(locations(1:idx,1,end),locations(1:idx,2,end),'o',MarkerSize=3,Color=[0.9 0.9 0.9]);
    g = getframe(f);
    writeVideo(vw,g)
end
close(vw)
