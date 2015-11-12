function [inliers_id, H] = runRANSAC(Xs, Xd, ransac_n, eps)

H_3x3xR = zeros(3,3,ransac_n);

height = size(Xs,1);

for i=1:ransac_n
   random_integers = randi(height,4,1);
   sample_Xs = Xs(random_integers,:);
   sample_Xd = Xd(random_integers,:);
   
   h = computeHomography(sample_Xs, sample_Xd);
   H_3x3xR(:,:,i) = h;
   
   new_Xd = applyHomography(h, Xs);
   
   Xd_xdiff = new_Xd(:,1)-Xd(:,1);
   Xd_ydiff = new_Xd(:,2)-Xd(:,2);

   error = sqrt(Xd_xdiff.^2 + Xd_ydiff.^2);
   
   inliers = find(eps >= error);
   
   num_inliers(i, 1) = size(inliers,1);
end

largest_num_inliers = max(num_inliers);

best_model = find(num_inliers == largest_num_inliers);

H1 = H_3x3xR(:,:,best_model);
H = H1(:,:,1);

new_Xd = applyHomography(H, Xs);

Xd_xdiff = new_Xd(:,1)-Xd(:,1);
Xd_ydiff = new_Xd(:,2)-Xd(:,2);

error = sqrt(Xd_xdiff.^2 + Xd_ydiff.^2);

inliers_id = find(eps >= error);

end
