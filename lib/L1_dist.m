function dist = L1_dist(X,Y)
%% special
if size(Y,1)==1 && size(Y,2)==1
    if Y==1
        n=size(X,2);
        dist=zeros(n,n);
        for i=1:n-1
            for j=i+1:n
                dist(i,j)=sum(abs(X(:,i)-X(:,j)));% dist(i,j)=norm(X(:,i)-X(:,j),1);
            end;
        end;
        dist=dist+dist';
        return;
    end
end
%%
if size(X,1)~=size(Y,1)
    return;
end;
dist=[];
for i=1:size(X,2)
    for j=1:size(Y,2)
        dist(i,j)=sum(abs(X(:,i)-Y(:,j)));
    end;
end;




