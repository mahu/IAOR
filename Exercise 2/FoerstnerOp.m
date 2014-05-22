function [Q,W,M_c] = FoerstnerOp(Ix,Iy,window_size,t_w,t_q)

Ix_Iy = Ix.*Iy;

Ix_sq = Ix.^2;

Iy_sq = Iy.^2;

%calculate the origin of the window
origin = floor((window_size+1)/2);

%compute M and store cornerness & roundness
W = zeros(size(Ix)-((origin-1)*2));
Q = zeros(size(Ix)-((origin-1)*2));
M_c = zeros(size(Ix)-((origin-1)*2));
for i = origin(1) : ((size(Ix,1)-origin(1)-1))
    for j = origin(2) : ((size(Ix,2)-origin(2)-1))
        
       %=================================================
       %B.a)
       %create submatrices
       Ix_Iy_local = Ix_Iy(i-origin(1)+1:i+origin(1)-1,j-origin(2)+1:j+origin(2)-1);
       Ix_sq_local = Ix_sq(i-origin(1)+1:i+origin(1)-1,j-origin(2)+1:j+origin(2)-1);
       Iy_sq_local = Iy_sq(i-origin(1)+1:i+origin(1)-1,j-origin(2)+1:j+origin(2)-1);
       
       Ix_Iy_sum = sum(Ix_Iy_local(:));
       Ix_sq_sum = sum(Ix_sq_local(:));
       Iy_sq_sum = sum(Iy_sq_local(:));
       
       M = [Ix_sq_sum,Ix_Iy_sum;Ix_Iy_sum,Iy_sq_sum];
       
       
       %=================================================
       %B.b)
       %just compute once:
       trace_M = trace(M);
       det_M = det(M);
       
       w = (0.5*trace_M) - sqrt((0.5*trace_M)^2 - det_M);
       q=0;
       
       if trace_M > 0
        q = (4*det_M)/(trace_M^2);
       end
       
       if w > t_w
        W(i,j) = w;
       end
      
       if q >t_q
        Q(i,j) = q;
       end
       
       %=================================================
       %B.c)
       if (w > t_w) && (q > t_q)
        M_c(i,j) = 1;
       end
        
    end
end
