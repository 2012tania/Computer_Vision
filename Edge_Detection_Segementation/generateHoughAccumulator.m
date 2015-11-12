function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)
[l,b] = size(img);
diagonal = sqrt(l^2 + b^2);

range_theta = (0:pi/theta_num_bins:pi);
range_rho = (0:2*diagonal/rho_num_bins:2*diagonal);

[y, x]=find(img);

xsin_theta = x*sin(range_theta);
ycos_theta = y*cos(range_theta);

value = ycos_theta - xsin_theta + diagonal;

no_columns_rho = size(range_rho,2);
no_columns_theta = size(range_theta,2);

hough_img = zeros(no_columns_rho, no_columns_theta);


for m=1:no_columns_theta
    for n=1:length(x)
        X = value(n,m)>=range_rho;
        hough_img(find(X,1,'last'),m) =...
            hough_img(find(X,1,'last'), m) + 1;
    end
end

max_val=max(max(hough_img));
hough_img = hough_img./max_val*255;
hough_img = hough_img;
figure, imshow(hough_img);

end




