Challenge 1b

The formula used for calculating the normal vector is according to the theory learned in written Question2.
The normal vector is from the center of the sphere to a point(point_x, point_y) on the sphere.

The x,y,z co-ordinates are calculates as follows - 

   diff_x = point_x - center(1);
   diff_y = point_y - center(2);
   z = sqrt(radius^2 - diff_x^2 - diff_y^2);
   


Also, it is safe to assume that the direction can be identified by the normal to the brighest point on the sphere because.

Illumination = (rho/pi * k * c)cos(theta) 	where theta = angle between source direction and normal

If illumination is max (brightest point)
 ---  cos(theta) is max (=1)
 ---  theta=0, i.e., normal and source are in same direction

		