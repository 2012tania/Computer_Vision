function [center, radius] = findSphere(img)

%b_img = im2bw(img, 0.1);
b_img = im2bw(img, 0);
figure, imshow(b_img);

[y, x] = find(b_img == 1);

area = size(x, 1);

radius = sqrt(area/pi);

center(1) = sum(x)/area;
center(2) = sum(y)/area;

end
