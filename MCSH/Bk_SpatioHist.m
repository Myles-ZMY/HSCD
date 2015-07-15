function  [cascade_hist,cascade_mu,cascade_sigma]= Bk_SpatioHist(img,block_h,block_w,block_h_step,block_w_step,bins)
h=size(img,1);
w=size(img,2);
if (w<block_w)||(h<block_h)
    cascade_hist=[];
    return;
end;

point.x=1:block_w_step:w-block_w+1;
if point.x(:,end)<w-block_w+1
    point.x=[point.x w-block_w+1];
end;
point.y=1:block_h_step:h-block_h+1;
if point.y(:,end)<h-block_h+1
    point.y=[point.y h-block_h+1];
end;

cascade_hist=[];
cascade_mu=[];
cascade_sigma=[];

for i=1:length(point.y)
    for j=1:length(point.x)
        blockimg=img(point.y(i):point.y(i)+block_h-1,point.x(j):point.x(j)+block_w-1);
        [h1,mu1,sigma1] = GetImgSpatiogram_hy(blockimg,bins);
        cascade_hist=[cascade_hist h1];
        cascade_mu=[cascade_mu mu1];
        cascade_sigma(:,:,end+1:end+size(sigma1,3))=sigma1;
    end;
end
cascade_sigma(:,:,1)=[];

