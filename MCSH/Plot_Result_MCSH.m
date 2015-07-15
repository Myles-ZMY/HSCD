load(['./data/Exp_MCSH_VIPeR_Ftr_Dist.mat']);
ds=0;
cvmode='SvsS';
cvidx=CVIdx_VIPeR.SvsS_SDALF;
[CMN_MCSH,~]=GetCV(Dist_MCSH,cvidx,cvmode,ds,'');
[CMN_MCSH_hist,~]=GetCV(Dist_MCSH_hist,cvidx,cvmode,ds,'');
[CMN_MCSH_mu,~]=GetCV(Dist_MCSH_mu,cvidx,cvmode,ds,'');
[CMN_MCSH_sigma,~]=GetCV(Dist_MCSH_sigma,cvidx,cvmode,ds,'');
% TSM
load(['./data/Exp_TSM_VIPeR_Dist.mat']);
ds=1;
[CMN_TSM,~]=GetCV(Dist_TSM,cvidx,cvmode,ds,'');
% 
CMN_MCSH_Intra=cat(1,CMN_MCSH,CMN_MCSH_hist,CMN_MCSH_mu,CMN_MCSH_sigma,CMN_TSM);
save(['./data/CMN_MCSH_Intra.mat'],'CMN_MCSH_Intra');
%% plot
load(['./data/CMN_MCSH_Intra.mat'],'CMN_MCSH_Intra');
showrange=[1 50 10 100];
isplot=1;
Method={'MCSH','MCSH-Hist','MCSH-Ymean','MCSH-Ystd','MCSH-TSM'};
Color={'-r+','-kdiamond','-ko','-bx','-g*'};
Stat=PlotCMC(CMN_MCSH_Intra, showrange, 1,60, Method,Color,'',isplot);

