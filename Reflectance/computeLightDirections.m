function light_dirs_5x3 = computeLightDirections(center, radius, img_cell)

light_dirs_5x3 = zeros(5,3);

no_of_imgs = size(img_cell,1);

for i=1:no_of_imgs
   
   img = cell2mat(img_cell(i));
   brightness = double(max(max(img)));
   
   [y, x] = find(img == brightness);
   
   area = size(x,1);
   
   point_x = sum(x)/area;
   point_y = sum(y)/area;
   
   diff_x = point_x - center(1);
   diff_y = point_y - center(2);
   z = sqrt(radius^2 - diff_x^2 - diff_y^2);
   
   point_3D = [diff_x diff_y z];
   
   factor = sqrt(sum(point_3D.^2));
   
   point_3D = point_3D.*brightness/factor;
   
   light_dirs_5x3(i,:) = point_3D;
end

