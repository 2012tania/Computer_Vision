function labeled_img = generateLabeledImage(gray_img, threshold)

binary_img = im2bw(gray_img, threshold);

figure, imshow(binary_img);

labeled_img=bwlabel(binary_img);


