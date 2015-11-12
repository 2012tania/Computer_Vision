function stitched_img = stitchImg(varargin)

num_of_imgs = length(varargin)

H_3x3xNI = zeros(3,3,num_of_imgs-1);
BB_H_3x3xNI = zeros(3,3,num_of_imgs);
bounding_boxes = [];

for i=1:num_of_imgs-1
    [xs, xd] = genSIFTMatches(varargin{i}, varargin{i+1});
    [inliers, H] = runRANSAC(xs, xd, 200, 2);
    H_3x3xNI(:,:,i) = H;
end 
    
num_half = ceil(num_of_imgs/2)

for i=1:num_of_imgs
   I_3x3 = eye(3);
   if(i<num_half)
       for j=1:num_half-i
           I_3x3 = I_3x3*H_3x3xNI(:,:,j);
       end
   elseif(i>num_half)
       for j=1:i-num_half
           I_3x3 = I_3x3*(inv(H_3x3xNI(:,:,num_of_imgs-j)));
       end
   end
   BB_H_3x3xNI(:,:,i) = I_3x3;
   img = varargin{i};
   
   left_upper = [1 1];
   right_upper = [size(img,2) 1];
   left_lower = [1 size(img,1)];
   right_lower = [size(img,2) size(img,1)];
   
   img_corners = [left_upper; right_upper; left_lower; right_lower];
   
   h_corners = applyHomography(BB_H_3x3xNI(:,:,i), img_corners);
   
   bounding_boxes = [bounding_boxes; h_corners];
end   

leftest = min(bounding_boxes(:,1));
rightest = max(bounding_boxes(:,1));
highest = min(bounding_boxes(:,2))
lowest = max(bounding_boxes(:,2))

BB_I_3x3 = eye(3);
BB_I_3x3(1,3) = leftest;
BB_I_3x3(2,3) = highest;

bb_width = round(rightest - leftest);
bb_height = round(lowest - highest);

for i=1:num_of_imgs
    BB_H_3x3xNI(:,:,i) = inv(BB_H_3x3xNI(:,:,i))*BB_I_3x3;
    [mask, dest_img] = backwardWarpImg(varargin{i}, BB_H_3x3xNI(:,:,i), [bb_width bb_height]);
    if(i==1)
        stitched_img = dest_img.*255;
        stitched_mask = mask.*255;
    else
        stitched_img = blendImagePair(stitched_img, stitched_mask, dest_img.*255, mask.*255, 'blend');
        stitched_mask = stitched_mask + mask.*255;
    end
end

end