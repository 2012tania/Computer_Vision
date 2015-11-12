function [normals, albedo_img] = ...
    computeNormals(light_dirs, img_cell, mask)

no_rows  = size(mask,1)
no_columns = size(mask,2);
no_imgs = size(img_cell, 1);

all_imgs = zeros(no_rows, no_columns, no_imgs);
for i=1:no_imgs
    all_imgs(:,:,i) = img_cell{i};
end

albedo_img = zeros(no_rows, no_columns);
normals = zeros(no_rows, no_columns, 3);

[y, x] = find(mask == 1);

no_total_rows = size(x,1)

for i=1:no_total_rows
    for j=1:no_imgs
        I(j,1) = all_imgs(y(i), x(i), j);
    end
    
    %N = light_dirs' * I;
    N = light_dirs\I;
    
    N_norm = norm(N);
    
    normals(y(i),x(i), :) = N/N_norm;
    albedo_img(y(i), x(i)) = N_norm;
end

factor = max(max(albedo_img));
albedo_img = albedo_img./factor;

end
 
