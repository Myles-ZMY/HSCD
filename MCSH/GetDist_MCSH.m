%%  %Sub ftr
Ftr_hist=Ftr_MCSH.Ftr_hist;
Ftr_mu=Ftr_MCSH.Ftr_mu;
Ftr_sigma=Ftr_MCSH.Ftr_sigma;
%%  %Norm
Ftr_hist=NormMat(Ftr_hist,1);
Ftr_mu=NormMat(Ftr_mu,1);
Ftr_sigma=NormMat(Ftr_sigma,2);
%% Ftr Weighted Dist Combination
% dist
Dist_MCSH_hist=L1_dist(Ftr_hist,1);
Dist_MCSH_mu=L1_dist(Ftr_mu,1);
Dist_MCSH_sigma=L1_dist(Ftr_sigma,1);
% combine
wcb=[0.5,0.35,0.15];
Dist_cb=cat(3,Dist_MCSH_hist,Dist_MCSH_mu,Dist_MCSH_sigma);
Dist_MCSH=GetDist_Combine(Dist_cb,wcb,1);
%% save
save(['./data/' prefixstr '.mat'],'Dist_MCSH','Dist_MCSH_hist','Dist_MCSH_mu','Dist_MCSH_sigma');
