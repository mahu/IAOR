% e)-------------------
function [H,r,t] = hough_edge_detect(Ix,Iy,Bin)

[row,col] = find(Bin>0);

rho_max = 2 * sqrt( size(Bin,1)^2 + size(Bin,2)^2);
t = (-90:89);
r = (-floor( rho_max - rho_max/2):floor( rho_max - rho_max/2));
H = zeros(size(t,2),size(r,2));

for j = 1 : size(col)
   theta = atan( (Iy(row(j),col(j)))  /  (Ix(row(j),col(j))));
   rho = col(j) * cos(theta) + row(j) * sin(theta);
   t_deg = floor(rad2deg(theta));
   r_floor = floor(rho);
   H(find(t==t_deg), find(r==r_floor)) = H(find(t==t_deg), find(r==r_floor)) + 1;  
end
