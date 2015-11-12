function dest_pts_nx2 = applyHomography(H_3x3, src_pts_nx2)

xt = src_pts_nx2(:,1);
yt = src_pts_nx2(:,2);

%t1 = [xt(1);yt(1);1];
%t2 = [xt(2);yt(2);1];
%t3 = [xt(3);yt(3);1];
%t4 = [xt(4);yt(4);1];

%d1 = H_3x3*t1;
%d2 = H_3x3*t2;
%d3 = H_3x3*t3;
%d4 = H_3x3*t4;

%dest_pts_nx2 = [d1(1,1) d1(2,1);d2(1,1) d2(2,1);d3(1,1) d3(2,1);d4(1,1) d4(2,1)];

num_of_points = size(xt,1);
modified_matrix = [xt yt ones(num_of_points,1)]';

modified_d = H_3x3*modified_matrix;
d = modified_d';

dest_pts_nx2 = [d(:,1)./d(:,3) d(:,2)./d(:,3)];