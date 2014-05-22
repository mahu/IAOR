function main

input = imread('input_exercise2.png');

grayscale = mean(input,3);
%normalize input
grayscale = ((grayscale-min(grayscale(:)))/(max(grayscale(:))-min(grayscale(:))));

%=================================================
%A.a-b)
%GoG(grayscale,0.5);
[Ix,Iy] = GoG(grayscale,0.5);
%=================================================
%A.c)
G = sqrt(Ix.^2 + Iy.^2);

%=================================================
%Results A

figure('name','Workflow Task A');
subplot(2,3,1), imshow(grayscale,[]),title('Grayscale Image','interpreter','latex','fontsize',18);
subplot(2,3,2), imshow((Ix),[]),title('$I_x$ (GoG)','interpreter','latex','fontsize',18');
subplot(2,3,3), imshow((Iy),[]),title('$I_y$ (GoG)','interpreter','latex','fontsize',18);
subplot(2,3,5), imshow((G),[]),title('Gradient Magnitude Image','interpreter','latex','fontsize',18);

%save Results (normalized)
Ix_norm = (Ix-min(Ix(:))/(max(Ix(:))-min(Ix(:))));
imwrite(Ix_norm,'Ix.jpg');

Iy_norm = (Iy-min(Iy(:))/(max(Iy(:))-min(Iy(:))));
imwrite(Iy_norm,'Iy.jpg');

imwrite(G,'GradientOfGaussian.jpg');

%=================================================
%B)
[Q,W,M_c] = FoerstnerOp(Ix,Iy,[5,5],1.0,0.5);

Q_bar = Q.*M_c;
W_bar = W.*M_c;

%Results B
figure('name','Workflow Task B');
subplot(2,3,1), imshow(W,[]),title('$W$','interpreter','latex','fontsize',18);
subplot(2,3,2), imshow(Q,[]),title('$Q$','interpreter','latex','fontsize',18);
subplot(2,3,3), imshow(M_c),title('$M_c$','interpreter','latex','fontsize',18);
subplot(2,3,4), imshow(Q_bar),title('$\overline{Q}$','interpreter','latex','fontsize',18);
subplot(2,3,5), imshow(W_bar),title('$\overline{W}$','interpreter','latex','fontsize',18);

%find Houghpeks
Q_bar = double(im2bw(Q_bar));
P = houghpeaks(Q_bar,100);

%set red channel of points of interest
input(:,:,1) = double(input(:,:,1)) + double(Q_bar*255);
input(:,:,2) = double(input(:,:,2)) - double(Q_bar*255);
input(:,:,3) = double(input(:,:,3)) - double(Q_bar*255);

%visualize result
figure('name','Result');
imshow(input),title('Result Image with Points of Interest','interpreter','latex','fontsize',18);
hold on
plot((P(:,2)),(P(:,1)),'+','color','blue');
hold off    