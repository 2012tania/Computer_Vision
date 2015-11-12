function result_img = ...
    showCorrespondence(orig_img, warped_img, src_pts_nx2, dest_pts_nx2)

xs = src_pts_nx2(:,1)
ys = src_pts_nx2(:,2)

xd = dest_pts_nx2(:,1);
yd = dest_pts_nx2(:,2)

temp_img = cat(2, orig_img, warped_img);

diff = size(orig_img,2);

xd = xd + diff

fh = figure();
imshow(temp_img);
hold on;

%num_of_points = size(xs,1);

%for i=1:num_of_points
% line([xs(i);xd(i)],[ys(i);yd(i)], 'LineWidth',1, 'Color', 'blue');
%end

line([xs';xd'],[ys';yd'], 'LineWidth',1, 'Color', 'blue');

%line([xs xd]',[ys yd]', 'LineWidth',1, 'Color', 'blue');

%line([xs(2),xd(2)],[ys(2),yd(2)], 'LineWidth',1, 'Color', 'blue');
%line([xs(3),xd(4)],[ys(3),yd(3)], 'LineWidth',1, 'Color', 'blue');
%line([xs(4),xd(4)],[ys(4),yd(4)], 'LineWidth',1, 'Color', 'blue');

set(fh, 'WindowStyle', 'normal');
img = getimage(fh);
truesize(fh, [size(img, 1), size(img, 2)]);

frame = getframe(fh);
frame = getframe(fh);
pause(0.5);
result_img = frame.cdata;

end