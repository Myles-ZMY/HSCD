%%  Sub ftr
Ftr_mean=Ftr_MSPC.Ftr_mean;
Ftr_sigma=Ftr_MSPC.Ftr_sigma;
Ftr_corr=Ftr_MSPC.Ftr_corr;
Ftr_std=Ftr_MSPC.Ftr_std;
%% Ftr Weighted Dist Combination
% dist
Dist_MSPC_mean=L1_dist(Ftr_mean,1);
Dist_MSPC_sigma=L1_dist(Ftr_sigma,1);
Dist_MSPC_corr=L1_dist(Ftr_corr,1);
Dist_MSPC_std=L1_dist(Ftr_std,1);

wcb=[0.25,0.35,0.3,0.1]; 
Dist_cb=cat(3,Dist_MSPC_mean,Dist_MSPC_sigma,Dist_MSPC_corr,Dist_MSPC_std);
Dist_MSPC=GetDist_Combine(Dist_cb,wcb,2);
%% Save
save(['./data/' prefixstr '.mat'],'Dist_MSPC','Dist_MSPC_mean',...
    'Dist_MSPC_sigma','Dist_MSPC_corr','Dist_MSPC_std');

