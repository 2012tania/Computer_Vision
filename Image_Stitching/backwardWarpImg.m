function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
    dest_canvas_width_height)

canvas_width = dest_canvas_width_height(1,1);
canvas_height = dest_canvas_width_height(1,2);

img_width = size(src_img,2);
img_height = size(src_img,1);

for i=1:canvas_width
    for j=1:canvas_height
        position = resultToSrc_H * [i; j; 1];
        position = position./position(3,1);
        position = round(position);
        if(position(1,1) <= img_width && position(2,1) <= img_height  && position(1,1) > 0 && position(2,1) > 0)
            result_img(j,i,1) = src_img(position(2,1), position(1,1), 1);
            result_img(j,i,2) = src_img(position(2,1), position(1,1), 2);
            result_img(j,i,3) = src_img(position(2,1), position(1,1), 3);
            mask(j,i) = 1;
        else
            result_img(j,i,1) = 0;
            result_img(j,i,2) = 0;
            result_img(j,i,3) = 0;
            mask(j,i) = 0;
        end
    end 
end

end