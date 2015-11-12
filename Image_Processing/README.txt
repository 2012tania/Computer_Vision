hw1_walkthrough2
Used imread function to read the image
Used im2double function for double precision
Since the image was a true color image, imread produced a 3D array
img(:,:,1) corresponds to the red channel, img(:,:,2) corresponds to the green channel,
img(:,:,3) corresponds to the blue channel
Each channel is retreived and stored onto a different image
A 2x2 collage is then made of the original image and these three images
Original image and red version in first row, blue and green versions in the second row
In case we want the collage to be of the same size as the original image, we can resize the four
Versions by a scale of 0.5 using imresize
Used imwrite to save the image to file 'collage.png'


hw2_walkthrough
Used imread function to read the iheartny_img image
Converted the rgb image to a grayscale image (luminance retained)
Used im2bw function with threshold value 0.5(considering the text colors 
  in the original image and hence the corresponding grayscale) to convert into a binary image(black and white)
This means that pixels with luminance>0.5 get replaced by white(1), rest get replaced by black(0)
That is text will be converted to white and backgroud will be black
Used imread function to read the nyc image
Resized nyc image to height 500 pixels
Resized binary version iheartny_img to 400 pixels
Inverted it to get text in black and background white
Added padding to it to make it same size as resized nyc image (called it iresized_mask)
Masked it to a logical image
For the red channel in the nyc image, added iresized_mask with value 255
For the green channel in the nyc image, added iresized_mask with value 0
For the blue channel in the nyc image, added iresized_mask with value 0
Used imwrite to save the iamge to file 'output_nyc.png'


hw2_Walkthrough1
1. Used 10 dilations followed by 10 erosions to get rid of holes
2. Used 10 erosions followed by 10 dilations to get rid of rice
(Tried different values of k from 1 to infinity)


hw2_Challenge1a - generateLabeledImage
1. used imb2w for converting gray image to binary image
2. used bwlabel for converting binary image into labeled image(backgroud=zero, each object=one digit starting from 1)
3. threshold = 0.5 for two_objects
   threshold = 0.45 for many_objects_1 ad many_objects_2
(Tried different thresholds from 0.4 to 0.6)


hw3_Challenge1b - compute2DProperties
1. Calculated and saved properties - label, row position of center, column position of center, moment of inertia, orientation, roundedness and factor
2. Factor = moment of inertia/square(Area). Used it in part c as a matching criterion
3. Figure shows center of each object as red dot and orientation as blue line


hw4_Challenge1c - recognizeObjects
1. Property used - Roundedness
	Ratio of roundedness of same object in both images can be away from 1 only upto 0.015
2. Property used - Factor
	Ratio of factor of same object in both images can be away from 1 only upto 0.06
3. Figure shows center and orientaion of only matching database objects on new image
