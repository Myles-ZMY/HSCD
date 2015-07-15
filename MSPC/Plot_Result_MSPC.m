% Intra methods
load(['./data/Exp_MSPC_VIPeR_Ftr_Dist.mat']);
ds=0;
cvmode='SvsS';
cvidx=CVIdx_VIPeR.SvsS_SDALF;
[CMN_MSPC,~]=GetCV(Dist_MSPC,cvidx,cvmode,ds,'');
[CMN_MSPC_mean,~]=GetCV(Dist_MSPC_mean,cvidx,cvmode,ds,'');
[CMN_MSPC_sigma,~]=GetCV(Dist_MSPC_sigma,cvidx,cvmode,ds,'');
[CMN_MSPC_corr,~]=GetCV(Dist_MSPC_corr,cvidx,cvmode,ds,'');
[CMN_MSPC_std,~]=GetCV(Dist_MSPC_std,cvidx,cvmode,ds,'');
% TSM
load(['./data/Exp_TCM_VIPeR_Dist.mat']);
ds=0;
[CMN_TCM,~]=GetCV(Dist_TCM,cvidx,cvmode,ds,'');
% 
CMN_MSPC_Intra=cat(1,CMN_MSPC,CMN_MSPC_mean,CMN_MSPC_sigma,CMN_MSPC_corr,CMN_MSPC_std,CMN_TCM);
save(['./data/CMN_MSPC_Intra.mat'],'CMN_MSPC_Intra');
%% plot
load(['./data/CMN_MSPC_Intra.mat'],'CMN_MSPC_Intra');
showrange=[1 50 10 100];
isplot=1;
Method={'MSPC','MSPC-Mean','MSPC-Sigma','MSPC-Corr','MSPC-Std','MSPC-TSM'};
Color={'-r+','-kdiamond','-ko','-bx','-g*','-b+'};
Stat=PlotCMC(CMN_MSPC_Intra, showrange, 1,60, Method,Color,'',isplot);

