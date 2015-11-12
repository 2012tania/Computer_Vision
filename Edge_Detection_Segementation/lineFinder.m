function line_detected_img = lineFinder(orig_img, hough_img, hough_threshold)

bins = size(hough_img,2);

[l,b] = size(orig_img);
diagonal = sqrt(l^2 + b^2);

range_theta = (0:pi/bins:pi);
range_rho = (0:2*diagonal/bins:2*diagonal);

fh = figure();
imshow(orig_img);

hough_check = (hough_img >= hough_threshold);
[rho, theta] = find(hough_check);

l = size(rho,1);

for i=1:l
    x=[0:b-1];
    new_rho = range_rho(1,(rho(i,1))) - diagonal; 
    y = round((x.*tan(range_theta(1,(theta(i,1))))) + new_rho/cos(range_theta(1,(theta(i,1)))));
    hold on
    plot(x,y,'Color','b','LineWidth',1);
    
end

F = getframe(fh);
line_detected_img = F.cdata;

end