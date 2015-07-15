%% Intra methods
datasetname='VIPeR';
load(['./MCSH/data/Exp_MCSH_VIPeR_Ftr_Dist.mat']);
load(['./MSPC/data/Exp_MSPC_VIPeR_Ftr_Dist.mat']);
Dist_cb1=Dist_MCSH;
Dist_cb2=Dist_MSPC;
wcb=[0.5,0.5];
Dcb=[];
Dcb(:,:,1)=Dist_cb1;
Dcb(:,:,2)=Dist_cb2;
Dist_cb=GetDist_Combine(Dcb,wcb,2);
Dist_HSCD=Dist_cb;

ds=0;
cvmode='SvsS';
load('./data/CVIdx_VIPeR.mat');
cvidx=CVIdx_VIPeR.SvsS_SDALF;
%HSCD
[CMN_HSCD,CMR_HSCD]=GetCV(Dist_HSCD,cvidx,cvmode,ds,'');
Stat=PlotCMC(CMN_HSCD,[1 50 10 100], 1,60,{},{},'',0);
[CMN_MCSH,~]=GetCV(Dist_MCSH,cvidx,cvmode,ds,'');
[CMN_MSPC,~]=GetCV(Dist_MSPC,cvidx,cvmode,ds,'');
%MCSH
[CMN_MCSH_hist,~]=GetCV(Dist_MCSH_hist,cvidx,cvmode,ds,'');
[CMN_MCSH_mu,~]=GetCV(Dist_MCSH_mu,cvidx,cvmode,ds,'');
[CMN_MCSH_sigma,~]=GetCV(Dist_MCSH_sigma,cvidx,cvmode,ds,'');
% TSM
load(['./MCSH/data/Exp_TSM_VIPeR_Dist.mat']);
ds=1;
[CMN_MCSH_TSM,~]=GetCV(Dist_TSM,cvidx,cvmode,ds,'');
%MSPC
[CMN_MSPC_mean,~]=GetCV(Dist_MSPC_mean,cvidx,cvmode,ds,'');
[CMN_MSPC_sigma,~]=GetCV(Dist_MSPC_sigma,cvidx,cvmode,ds,'');
[CMN_MSPC_corr,~]=GetCV(Dist_MSPC_corr,cvidx,cvmode,ds,'');
[CMN_MSPC_std,~]=GetCV(Dist_MSPC_std,cvidx,cvmode,ds,'');
% TCM
load(['./MSPC/data/Exp_TCM_VIPeR_Dist.mat']);
ds=0;
[CMN_TCM,~]=GetCV(Dist_TCM,cvidx,cvmode,ds,'');
% save
CMN_HSCD_Intra=cat(1,CMN_HSCD,CMN_MCSH,CMN_MSPC,CMN_MCSH_hist,CMN_MCSH_mu,CMN_MCSH_sigma,CMN_MCSH_TSM, ...
                           CMN_MSPC_mean,CMN_MSPC_sigma,CMN_MSPC_corr,CMN_MSPC_std,CMN_TCM);
save(['./data/CMN_HSCD_' datasetname '_Intra.mat'],'CMN_HSCD_Intra');
%% Compared methods
load(['./data/CMN_HSCD_VIPeR_Intra.mat'],'CMN_HSCD_Intra');
CMN_HSCD=CMN_HSCD_Intra(1,:); 
GetCMC;
CMR_Comp=cat(1,CMR_SDALF,CMR_eBicov,CMR_SCEAF,CMR_eSDC,CMR_MCTCS,CMR_RS_KISS,CMR_LF);
Num_Gly=316;
Num_Prb=316;
Num_Gly_Show=50;
CMN_Comp=CMR_Comp*Num_Prb/100;
CMN_Comp(:,Num_Gly_Show+1:Num_Gly)=Num_Prb;
CMN_HSCD_Inter=cat(1,CMN_Comp,CMN_HSCD);
save(['./data/CMN_HSCD_VIPeR_Inter.mat'],'CMN_HSCD_Inter');
%% plot
load(['./data/CMN_HSCD_VIPeR_Inter.mat'],'CMN_HSCD_Inter');
showrange=[1 50 10 100];
isplot=1;
Method={'SDALF','eBiCov','SCEAF', 'eSDC','MCTCS','RS-KISS','LF','HSCD'};
Color={'-kdiamond','-m+','-ko','-bx','-y+','-bo','-m*','-r+'};
Stat=PlotCMC(CMN_HSCD_Inter, showrange, 1,50, Method,Color,'',isplot);