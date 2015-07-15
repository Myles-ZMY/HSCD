function nM=NormMat(M,l)
[m,n]=size(M);
nM=[];
for j=1:n
    nM(:,j)=norm(M(:,j),l);
end
nM=repmat(nM,[m,1]);
nM=M./nM;

