function runHw4(varargin)
% runHw4 is the "main" interface that lists a set of 
% functions corresponding to the problems that need to be solved.
%
% Note that this file also serves as the specifications for the functions 
% you are asked to implement. In some cases, your submissions will be autograded. 
% Thus, it is critical that you adhere to all the specified function signatures.
%
% Before your submssion, make sure you can run runHw4('all') 
% without any error.
%
% Usage:
% runHw4                       : list all the registered functions
% runHw4('function_name')      : execute a specific test
% runHw4('all')                : execute all the registered functions

% Settings to make sure images are displayed without borders
orig_imsetting = iptgetpref('ImshowBorder');
iptsetpref('ImshowBorder', 'tight');
temp1 = onCleanup(@()iptsetpref('ImshowBorder', orig_imsetting));

fun_handles = {@honesty,...
    @challenge1a, @challenge1b, @challenge1c,...
    @challenge1d, @challenge1e, @challenge1f,...
    @demoMATLABTricks};

% Call test harness
runTests(varargin, fun_handles);

%--------------------------------------------------------------------------
% Academic Honesty Policy
%--------------------------------------------------------------------------
%%
function honesty()
% Type your full name and uni (both in string) to state your agreement 
% to the Code of Academic Integrity.
signAcademicHonestyPolicy('Tania Chopra', 'tc2744');

%--------------------------------------------------------------------------
% Tests for Challenge 1: Panoramic Photo App
%--------------------------------------------------------------------------

%%
function challenge1a()
% Test homography

orig_img = imread('portrait.png'); 
warped_img = imread('portrait_transformed.png');

% Choose 4 corresponding points (use ginput)

figure, imshow(orig_img);
hold on;

[xs, ys] = ginput(4);

figure, imshow(warped_img);
hold on;

[xd, yd] = ginput(4);

xs1 = xs(1);
xs2 = xs(2);
xs3 = xs(3);
xs4 = xs(4);

ys1 = ys(1);
ys2 = ys(2);
ys3 = ys(3);
ys4 = ys(4);


xd1 = xd(1);
xd2 = xd(2);
xd3 = xd(3);
xd4 = xd(4);

yd1 = yd(1);
yd2 = yd(2);
yd3 = yd(3);
yd4 = yd(4);

src_pts_nx2  = [xs1 ys1; xs2 ys2; xs3 ys3; xs4 ys4];
dest_pts_nx2 = [xd1 yd1; xd2 yd2; xd3 yd3; xd4 yd4];

H_3x3 = computeHomography(src_pts_nx2, dest_pts_nx2);
% src_pts_nx2 and dest_pts_nx2 are the coordinates of corresponding points 
% of the two images, respectively. src_pts_nx2 and dest_pts_nx2 
% are nx2 matrices, where the first column contains
% the x coodinates and the second column contains the y coordinates.
%
% H, a 3x3 matrix, is the estimated homography that 
% transforms src_pts_nx2 to dest_pts_nx2. 


% Choose another set of points on orig_img for testing.
% test_pts_nx2 should be an nx2 matrix, where n is the number of points, the
% first column contains the x coordinates and the second column contains
% the y coordinates.

figure, imshow(orig_img);
hold on;

[xt, yt] = ginput(4);

xt1 = xt(1);
xt2 = xt(2);
xt3 = xt(3);
xt4 = xt(4);

yt1 = yt(1);
yt2 = yt(2);
yt3 = yt(3);
yt4 = yt(4);

test_pts_nx2 = [xt1 yt1; xt2 yt2; xt3 yt3; xt4 yt4];

% Apply homography
dest_pts_nx2 = applyHomography(H_3x3, test_pts_nx2);
% test_pts_nx2 and dest_pts_nx2 are the coordinates of corresponding points 
% of the two images, and H is the homography.

% Verify homography 
result_img = showCorrespondence(orig_img, warped_img, test_pts_nx2, dest_pts_nx2);

imwrite(result_img, 'homography_result.png');

%%
function challenge1b()
% Test wrapping 

bg_img = im2double(imread('Osaka.png')); %imshow(bg_img);
portrait_img = im2double(imread('portrait_small.png')); %imshow(portrait_img);

% Estimate homography


figure, imshow(portrait_img);
hold on;

[xp, yp] = ginput(4);

xp1 = xp(1);
xp2 = xp(2);
xp3 = xp(3);
xp4 = xp(4);

yp1 = yp(1);
yp2 = yp(2);
yp3 = yp(3);
yp4 = yp(4);

figure, imshow(bg_img);
hold on;

[xb, yb] = ginput(4);

xb1 = xb(1);
xb2 = xb(2);
xb3 = xb(3);
xb4 = xb(4);

yb1 = yb(1);
yb2 = yb(2);
yb3 = yb(3);
yb4 = yb(4);

portrait_pts = [xp1 yp1; xp2 yp2; xp3 yp3; xp4 yp4];
bg_pts = [xb1 yb1; xb2 yb2; xb3 yb3; xb4 yb4];

H_3x3 = computeHomography(portrait_pts, bg_pts);

dest_canvas_width_height = [size(bg_img, 2), size(bg_img, 1)];

% Warp the portrait image
[mask, dest_img] = backwardWarpImg(portrait_img, inv(H_3x3), dest_canvas_width_height);
% mask should be of the type logical
mask = ~mask;
% Superimpose the image
result = bg_img .* cat(3, mask, mask, mask) + dest_img;
%figure, imshow(result);
imwrite(result, 'Van_Gogh_in_Osaka.png');

%%  
function challenge1c()
% Test RANSAC -- outlier rejection

imgs = imread('mountain_left.png'); imgd = imread('mountain_center.png');
[xs, xd] = genSIFTMatches(imgs, imgd);
% xs and xd are the centers of matched frames
% xs and xd are nx2 matrices, where the first column contains the x
% coordinates and the second column contains the y coordinates

before_img = showCorrespondence(imgs, imgd, xs, xd);
%figure, imshow(before_img);
imwrite(before_img, 'before_ransac.png');

% Use RANSAC to reject outliers
ransac_n = 200; % Max number of iteractions
ransac_eps = 2; % Acceptable alignment error 


[inliers_id, H_3x3] = runRANSAC(xs, xd, ransac_n, ransac_eps);

after_img = showCorrespondence(imgs, imgd, xs(inliers_id, :), xd(inliers_id, :));
%figure, imshow(after_img);
imwrite(after_img, 'after_ransac.png');

%%
function challenge1d()
% Test image blending

[fish, fish_map, fish_mask] = imread('escher_fish.png');
[horse, horse_map, horse_mask] = imread('escher_horsemen.png');

blended_result = blendImagePair(fish, fish_mask, horse, horse_mask,...
    'blend');
%figure, imshow(blended_result);
imwrite(blended_result, 'blended_result.png');

overlay_result = blendImagePair(fish, fish_mask, horse, horse_mask, 'overlay');
%figure, imshow(overlay_result);
imwrite(overlay_result, 'overlay_result.png');

%%
function challenge1e()
% Test image stitching

% stitch three images
imgc = im2single(imread('mountain_center.png'));
imgl = im2single(imread('mountain_left.png'));
imgr = im2single(imread('mountain_right.png'));

% You are free to change the order of input arguments
stitched_img = stitchImg(imgl, imgc, imgr);
%figure, imshow(stitched_img);
imwrite(stitched_img, 'mountain_panorama.png');

%%
function challenge1f()
% Your own panorama
%img1 = im2single(imread('Home1.png'));
%img2 = im2single(imread('Home2.png'));
%img3 = im2single(imread('Home3.png'));

img1 = im2single(imread('yosemite1.png'));
img2 = im2single(imread('yosemite2.png'));
img3 = im2single(imread('yosemite3.png'));
img4 = im2single(imread('yosemite4.png'));

% You are free to change the order of input arguments
stitched_img = stitchImg(img1, img2, img3, img4);
%figure, imshow(stitched_img);
%imwrite(stitched_img, 'Home_panorama.png');
imwrite(stitched_img, 'yosemite_panorama.png');