function output_img = recognizeObjects(orig_img, labeled_img, obj_db)

num_of_obj = size(obj_db,2);

obj_db2 = compute2DProperties(orig_img,labeled_img);
num_of_obj2 = size(obj_db2,2);

output_img = zeros(size(labeled_img));
check=zeros(num_of_obj2,1);

for i=1:num_of_obj2
    for j=1:num_of_obj
        if(abs((obj_db2(6,i)-obj_db(6,j))/obj_db2(6,i)) < 0.015)
            if(abs((obj_db2(7,i)-obj_db(7,j))/obj_db2(7,i)) < 0.06)
                check(i,1)=1;
            end
        end
    end
end

fh=figure();
imshow(orig_img);
hold on;
for i=1:num_of_obj2
    if (check(i,1)==1)
        c = obj_db2(3,i) - obj_db2(2,i)*tan(obj_db2(5,i));
        x2 = obj_db2(3,i) + 10;
        y2= x2*tan(obj_db2(5,i)) + c;
        plot(obj_db2(2,i), obj_db2(3,i), 'r.','MarkerSize',15,'Color', 'red');
        line([obj_db2(2,i),x2],[obj_db2(3,i),y2], 'LineWidth',2, 'Color', 'blue');
    end
end

set(fh, 'WindowStyle', 'normal');
img = getimage(fh);
truesize(fh, [size(img, 1), size(img, 2)]);

frame = getframe(fh);
frame = getframe(fh);
pause(0.5);  
output_img = frame.cdata;

end
