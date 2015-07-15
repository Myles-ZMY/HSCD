function [CMN_ave,CMR_ave]=GetCV(Dist,CVIdx,mode,ds,fuseM)
CMN_all=[];
CMR_all=[];
round=size(CVIdx.Gly_picidx,1);
global prbidx1 Pid_P1 glyidx1 Pid_G1;
glyidx1=CVIdx.Gly_picidx(1,:);
Pid_G1=CVIdx.Gly_picidx_Pid(1,:);
prbidx1=CVIdx.Prb_picidx(1,:);
Pid_P1=CVIdx.Prb_picidx_Pid(1,:);
%% 
for r=1:round
    glyidx=CVIdx.Gly_picidx(r,:);
    Pid_G=CVIdx.Gly_picidx_Pid(r,:);
    prbidx=CVIdx.Prb_picidx(r,:);
    Pid_P=CVIdx.Prb_picidx_Pid(r,:);
    %% CMC test
    [CMN,CMR]=GetCMCbyDist(Dist(prbidx,glyidx),Pid_P,Pid_G,ds,mode,fuseM);
    CMN_all=[CMN_all;CMN];
    CMR_all=[CMR_all;CMR];
end
CMN_ave=mean(CMN_all,1);
CMR_ave=mean(CMR_all,1);

