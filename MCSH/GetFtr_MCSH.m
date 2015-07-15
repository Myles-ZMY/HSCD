function [ftr_hist,ftr_mu,ftr_sigma]=GetFtr_MCSH(CH,bin)
%% init
ftr_hist=[];
ftr_mu=[];
ftr_sigma=[];
[H,W,~]=size(CH);
num_ch=size(CH,3);

%% layer 1
for i=1:1
    for j=1:1
        h=H/1;
        w=W/1;
        Ch=CH((i-1)*h+1:i*h,(j-1)*w+1:j*w,:);
        for ch=1:num_ch
            [hist,mu,sigma]=Bk_SpatioHist(Ch(:,:,ch),h,w,h,w,4*bin);
            ftr_hist=[ftr_hist hist];
            ftr_mu=[ftr_mu mu];
            ftr_sigma(:,:,end+1:end+size(sigma,3))=sigma;
        end
    end
end

%% layer 2
for i=1:2
    for j=1:1
        h=H/2;
        w=W/1;
        Ch=CH((i-1)*h+1:i*h,(j-1)*w+1:j*w,:);
        for ch=1:num_ch
            [hist,mu,sigma]=Bk_SpatioHist(Ch(:,:,ch),h,w,h,w,3*bin);
            ftr_hist=[ftr_hist hist];
            ftr_mu=[ftr_mu mu];
            ftr_sigma(:,:,end+1:end+size(sigma,3))=sigma;
        end
    end
end

%% layer 3
for i=1:4
    for j=1:1
        h=H/4;
        w=W/1;
        Ch=CH((i-1)*h+1:i*h,(j-1)*w+1:j*w,:);
        for ch=1:num_ch
            [hist,mu,sigma]=Bk_SpatioHist(Ch(:,:,ch),h,w,h,w,2*bin);
            ftr_hist=[ftr_hist hist];
            ftr_mu=[ftr_mu mu];
            ftr_sigma(:,:,end+1:end+size(sigma,3))=sigma;
        end
    end
end

%% layer 4
for i=1:8
    for j=1:1
        h=H/8;
        w=W/1;
        Ch=CH((i-1)*h+1:i*h,(j-1)*w+1:j*w,:);
        for ch=1:num_ch
            [hist,mu,sigma]=Bk_SpatioHist(Ch(:,:,ch),h,w,h,w,bin);
            ftr_hist=[ftr_hist hist];
            ftr_mu=[ftr_mu mu];
            ftr_sigma(:,:,end+1:end+size(sigma,3))=sigma;
        end
    end
end
ftr_sigma(:,:,1)=[];
return;
