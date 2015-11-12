function [db, out_img] = compute2DProperties(orig_img, labeled_img)

num_of_obj = max(max(labeled_img));

db=zeros(7,num_of_obj);

c = zeros(2,1);
x2 = zeros(2,1);
y2 = zeros(2,1);

for i=1:num_of_obj
    
    db(1,i) = i;
    
    [y,x,k] = find(labeled_img == i);
    area = size(k,1);

    y_center = sum(y)/area;
    x_center = sum(x)/area;

    db(2,i) = x_center;
    db(3,i) = y_center;

    x_new = x - x_center;
    y_new = y - y_center;

    b = 2*sum(x_new.*y_new);
    a = sum(x_new.^2);
    c = sum(y_new.^2);

    theta1 = atan2(b,a-c)/2;
    theta2 = pi/2 + theta1;

    min_theta = min(theta1,theta2);
    max_theta = max(theta1, theta2);

    min_E = a*sin(min_theta)*sin(min_theta) - b*sin(min_theta)*cos(min_theta) + c*cos(min_theta)*cos(min_theta);
    max_E = a*sin(max_theta)*sin(max_theta) - b*sin(max_theta)*cos(max_theta) + c*cos(max_theta)*cos(max_theta);

    roundedness = min_E/max_E;

    db(4,i) = min_E;
    db(5,i) = min_theta;
    db(6,i) = roundedness;

    factor = min_E/(area^2);
    db(7,i) = factor;
    
    c1(i,1) = y_center - x_center*tan(min_theta);
    x2(i,1) = x_center + 10;
    y2(i,1)= x2(i,1)*tan(min_theta) + c1(i,1);
end

    fh=figure();
    imshow(orig_img);
    hold on;
    for i=1:num_of_obj
    plot(db(2,i), db(3,i), 'r.','MarkerSize',15,'Color', 'red');
    line([db(2,i),x2(i,1)],[db(3,i),y2(i,1)], 'LineWidth',2, 'Color', 'blue');
    end
    
    set(fh, 'WindowStyle', 'normal');
    img = getimage(fh);
    truesize(fh, [size(img, 1), size(img, 2)]);

    frame = getframe(fh);
    frame = getframe(fh);
    pause(0.5);  
    out_img = frame.cdata;
end