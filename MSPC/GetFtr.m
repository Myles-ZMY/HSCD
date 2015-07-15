%% %ftr param
H=17:112;
W=13:36;
%% %get ftr
Ftr_mean=[];
Ftr_sigma=[];
Ftr_corr=[];
Ftr_std=[];
imgsnum=dataset.imgsnum;
for i=1:imgsnum
    img=dataset.data(:,:,:,i);
    img=img(H,W,:);
    %get channels
    CH=GetCHImg_MSPC(img);
    CH=uint8(CH);
    %get ftrs
    [ftr_mean,ftr_sigma,ftr_corr,ftr_std]=GetFtr_MSPC(CH);
    Ftr_mean(:,i)=ftr_mean;
    Ftr_sigma(:,i)=ftr_sigma;
    Ftr_corr(:,i)=ftr_corr;
    Ftr_std(:,i)=ftr_std;
end
%% %save ftr for MSPC
Ftr_MSPC.Ftr_mean=Ftr_mean;
Ftr_MSPC.Ftr_sigma=Ftr_sigma;
Ftr_MSPC.Ftr_corr=Ftr_corr;
Ftr_MSPC.Ftr_std=Ftr_std;
save(['./data/' prefixstr  '.mat'], 'Ftr_MSPC');
