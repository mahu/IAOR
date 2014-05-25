%=================================================
%e)
function [H,t,r] = hough_edge_detect(Ix,Iy,Bin)

[row,col] = find(Bin);

rho_max = 2 * sqrt( size(Bin,1)^2 + size(Bin,2)^2);
t = (-90:89);
r = (-floor(rho_max -rho_max/2) : floor(rho_max-rho_max/2));
H = zeros(size(t,2),size(r,2));

for j = 1 : size(col)
   theta = atan(Iy(row(j),col(j))  /  (Ix(row(j),col(j))));
   rho = col(j) * cos(theta) + row(j) * sin(theta);
   
   % convert theta to degrees
   t_deg = floor(180*theta/pi);
   r_floor = floor(rho);
   
   t_index = find(t==t_deg);
  
   r_index = find(r==r_floor);
   H(t_index, r_index) = H(t_index, r_index) + 1;  
end

