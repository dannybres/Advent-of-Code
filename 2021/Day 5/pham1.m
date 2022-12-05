lines = readmatrix("inputDemo.txt",'Delimiter',{',', ' -> '});
slines = lines( (lines(:,1) == lines(:,3)) | (lines(:,2) == lines(:,4)) , :);
slines = permute(slines, [2 3 1]);
x1 = slines(1,:,:); x2 = slines(3,:,:); y1 = slines(2,:,:); y2 = slines(4,:,:);

[x, y] = meshgrid( 0:max(slines,[],'all'), 0:max(slines,[],'all') );

z = (x1 <= x & x <= x2) & (y1 <= y & y <= y2);
z = z | ((x2 <= x & x <= x1) & (y2 <= y & y <= y1));
z = sum(z,3);

nnz(z >= 2)