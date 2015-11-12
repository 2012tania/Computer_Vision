function cropped_line_img = lineSegmentFinder(orig_img, hough_img, hough_threshold)

edge_img = edge(orig_img,'canny',0.085);

f = fspecial('gaussian',40, 0.8);
g_img = imfilter(edge_img, f);

bins = size(hough_img,2);

[l,b] = size(orig_img);
diagonal = sqrt(l^2 + b^2);

range_theta = (0:pi/bins:pi);
range_rho = (0:2*diagonal/bins:2*diagonal);

fh = figure();
imshow(orig_img);
hold on;

hough_check = (hough_img >= hough_threshold);
[rho, theta] = find(hough_check);

l = size(rho,1);

for i=1:l
    x = (0:b-1);
    new_rho = range_rho(1,(rho(i,1))) - diagonal; 
    y = round((x.*tan(range_theta(1,(theta(i,1))))) + new_rho/cos(range_theta(1,(theta(i,1)))));
    hold on
    
    z = min(l,b);

    y_change=find(y >= z);
    y(y_change)= z;

    x_change=find(x >= z);
    x(x_change)= z;

    y_change=find(y <= 1);
    y(y_change)= 1;

    x_change=find(x<= 1);
    x(x_change)= 1;

    data = zeros(size(edge_img,1) , size(edge_img,2),'uint8');
    data_size = size(data);
    data(sub2ind(data_size,y,x)) = 1;

    [final_y, final_x] = find(data == 1);

    new_line = 0;
    start_pos = 0;
    count = 0;
    for i = 1:size(final_x,1);
        x1 = final_x(i,1);
        y1 = final_y(i,1);
        if(g_img(x1,y1)==1)
            if(new_line == 1)
                count = count + 1;
                new_line = 0;
                start_pos = i;
            end
            continue;
        else
            if (count>10)
                hold on
                plot(x1(1,start_pos:i),y1(1,start_pos:i),'Color','b','LineWidth',1);
            end
            new_line = 1;
            count = 0;
        end
    end
end

F = getframe(fh);
cropped_line_img = F.cdata;

end