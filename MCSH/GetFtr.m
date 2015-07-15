%% %ftr param
H=17:112;
W=11:38;
bin=8;
%% %get ftr
Ftr_hist=[];
Ftr_mu=[];
Ftr_sigma=[];
imgsnum=dataset.imgsnum;
for i=1:imgsnum
    img=dataset.data(:,:,:,i);
    img=img(H,W,:);
    % get channels
    CH=GetCHImg_MCSH(img);
    CH=uint8(CH);
    % get ftrs
    [ftr_hist,ftr_mu,ftr_sigma]=GetFtr_MCSH(CH,bin);
    Ftr_hist(:,i)=ftr_hist;
    Ftr_mu(:,:,i)=ftr_mu;
    Ftr_sigma(:,:,:,i)=ftr_sigma;
end
%% %save ftr
Ftr_MCSH.Ftr_hist=Ftr_hist;
Ftr_MCSH.Ftr_mu=squeeze(Ftr_mu(1,:,:));
Ftr_MCSH.Ftr_sigma=sqrt(squeeze(Ftr_sigma(1,1,:,:)));
save(['./data/'  prefixstr  '.mat'], 'Ftr_MCSH');

