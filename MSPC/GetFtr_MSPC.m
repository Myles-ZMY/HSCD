function [ftr_mean,ftr_sigma,ftr_corr,ftr_std]=GetFtr_MSPC(CH)
[CovMat,MeanVec]=GetFtr_CovMat(CH);
[ftr_mean,ftr_sigma,ftr_corr,ftr_std]=GetFtr_MSPC_From_CovMat(CovMat,MeanVec);
end
% GetFtr_CovMat
function [CovMat,MeanVec]=GetFtr_CovMat(CH)
H=size(CH,1);
W=size(CH,2);
%% multi region
num_CovMat=0;
%level 0
num_CovMat=num_CovMat+1;
[CovMat(:,:,num_CovMat),MeanVec(:,num_CovMat)]=getftr_covmat(CH,0);
%level 1
partW=1;
partH=2;
for w=1:partW
    for h=1:partH
        x=(w-1)*W/partW+1:w*W/partW;
        y=(h-1)*H/partH+1:h*H/partH;
        num_CovMat=num_CovMat+1;
        [CovMat(:,:,num_CovMat),MeanVec(:,num_CovMat)]=getftr_covmat(CH(y,x,:),0);
    end
end
%level 2
partW=2;
partH=4;
for w=1:partW
    for h=1:partH
        x=(w-1)*W/partW+1:w*W/partW;
        y=(h-1)*H/partH+1:h*H/partH;
        num_CovMat=num_CovMat+1;
        [CovMat(:,:,num_CovMat),MeanVec(:,num_CovMat)]=getftr_covmat(CH(y,x,:),0);
    end
end
%level 3
partW=1;
partH=8;
for w=1:partW
    for h=1:partH
        x=(w-1)*W/partW+1:w*W/partW;
        y=(h-1)*H/partH+1:h*H/partH;
        num_CovMat=num_CovMat+1;
        [CovMat(:,:,num_CovMat),MeanVec(:,num_CovMat)]=getftr_covmat(CH(y,x,:),0);
    end
end
end

%% getftr_covmat
function [covMat,meanVec]=getftr_covmat(ImgCH,maskup)
w=size(ImgCH,2);
h=size(ImgCH,1);
num_ftr=size(ImgCH,3);
ftr=zeros(w*h,num_ftr+1);
i=0;
for x=1:w
    for y=1:h
        i=i+1;
        ftr(i,:)=[ y reshape(ImgCH(y,x,:),[1,size(ImgCH,3)])];
    end
end
if maskup==1
    mask=getmask(w,h);
    ftr=ftr(mask==1,:);
end
covMat=cov(ftr);
meanVec=mean(ftr)';
end

%% GetFtr_MSPC_From_CovMat
function [ftr_mean,ftr_sigma,ftr_corr,ftr_std]=GetFtr_MSPC_From_CovMat(CovMat,MeanVec)
d=size(CovMat,1);
n=size(CovMat,3);
ftr_mean=[];
ftr_sigma=[];
ftr_corr=[];
ftr_std=[];
for i=1:n
    covMat=CovMat(:,:,i)+1e-6.*eye(d);
    corrMat=corrcov(covMat);
    L=chol(corrMat);
    L=L';
    meanvec=MeanVec(:,i);
    varvec=sqrt(diag(covMat));
    sigmapoint=[];
    for j=1:d
        sigmapoint=[sigmapoint;L(j:d,j)];
    end;
    corrcoef=[];
    for j=1:d
        corrcoef=[corrcoef;corrMat(j+1:d,j)];
    end;
    %L1
    ftr_mean=[ftr_mean; meanvec/norm(meanvec,1)];
    ftr_sigma=[ftr_sigma; sigmapoint/norm(sigmapoint,1)];
    ftr_corr=[ftr_corr; corrcoef/norm(corrcoef,1)];
    ftr_std=[ftr_std; varvec/norm(varvec,1)];
end
end
