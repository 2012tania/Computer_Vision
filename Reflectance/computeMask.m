function mask = computeMask(img_cell)

img = img_cell(1);

no_rows = size(img,1);
no_columns = size(img,2);

mask = zeros(no_rows, no_columns);

no_imgs = size(img_cell,1);

for i=1:no_imgs
   img = cell2mat(img_cell(i)); 
   mask = mask + im2double(img);
end

mask(mask > 0) = 1;

end