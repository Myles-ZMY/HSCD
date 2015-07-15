function Sel_Ch=GetCHImg_MSPC(img)
%% Pre Process
% Pre1: Illuminance normalization
img_nf = illuminant_normalization(img);
img_n=uint8(img_nf);
% Pre2: Histogram equalization
img_neq=cat(3,histeq(img_n(:,:,1)),histeq(img_n(:,:,2)),histeq(img_n(:,:,3)));
%% Channels
Sel_Ch_num=0;
Sel_Ch=zeros(size(img,1),size(img,2));
R=double(img_neq(:,:,1));
G=double(img_neq(:,:,2));
B=double(img_neq(:,:,3));
%% NRGB
NR=uint8(255*R./(sqrt(R.^2+G.^2+B.^2)+(R==0 & G==0 & B==0)));
Sel_Ch_num=Sel_Ch_num+1;
Sel_Ch(:,:,Sel_Ch_num)=NR;
NG=uint8(255*G./(sqrt(R.^2+G.^2+B.^2)+(R==0 & G==0 & B==0)));
Sel_Ch_num=Sel_Ch_num+1;
Sel_Ch(:,:,Sel_Ch_num)=NG;
%% YCbCr
YCbCr=rgb2ycbcr(img);
YCbCr_neq=rgb2ycbcr(img_neq);
Y=histeq(YCbCr_neq(:,:,1));
Cb=YCbCr(:,:,2);
Cr=YCbCr(:,:,3);
Sel_Ch_num=Sel_Ch_num+1;
Sel_Ch(:,:,Sel_Ch_num)=Y;
Sel_Ch_num=Sel_Ch_num+1;
Sel_Ch(:,:,Sel_Ch_num)=Cb;
Sel_Ch_num=Sel_Ch_num+1;
Sel_Ch(:,:,Sel_Ch_num)=Cr;
%% HSV
HSV=rgb2hsv(img);
H=round(255*HSV(:,:,1));
H=uint8(H);
S=round(255*HSV(:,:,2));
S=uint8(S);
Sel_Ch_num=Sel_Ch_num+1;
Sel_Ch(:,:,Sel_Ch_num)=H;
Sel_Ch_num=Sel_Ch_num+1;
Sel_Ch(:,:,Sel_Ch_num)=S;
%% Lab
cf=makecform('srgb2lab');
Lab=applycform(img,cf);
L=Lab(:,:,1);
a=Lab(:,:,2);
b=Lab(:,:,3);
Sel_Ch_num=Sel_Ch_num+1;
Sel_Ch(:,:,Sel_Ch_num)=a;
Sel_Ch_num=Sel_Ch_num+1;
Sel_Ch(:,:,Sel_Ch_num)=b;
%% First & second order gradients
I=double(Y);
[Ix,Iy]=gradient(I);
Ix=abs(Ix);
Iy=abs(Iy);
Sel_Ch_num=Sel_Ch_num+1;
Sel_Ch(:,:,Sel_Ch_num)=Ix;
Sel_Ch_num=Sel_Ch_num+1;
Sel_Ch(:,:,Sel_Ch_num)=Iy;
w=[-1,2,-1];
Ixx=imfilter(I,w,'conv','replicate');
Ixx=abs(Ixx);
Sel_Ch_num=Sel_Ch_num+1;
Sel_Ch(:,:,Sel_Ch_num)=Ixx;
w=[-1,2,-1];
Iyy=imfilter(I,w','conv','replicate');
Iyy=abs(Iyy);
Sel_Ch_num=Sel_Ch_num+1;
Sel_Ch(:,:,Sel_Ch_num)=Iyy;