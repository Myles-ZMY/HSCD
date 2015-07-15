function DD=GetDist_Combine(D,w,mode)
n_P=size(D,1);
n_Q=size(D,2);
n_D=size(D,3);

if mode==1
    DD=zeros(n_P,n_Q);
    for i=1:n_P
        for j=1:n_D
            m=max(abs(D(i,:,j)));% norm by row ,max
            D(i,:,j)=D(i,:,j)/m;
            DD(i,:)=DD(i,:)+w(j)*D(i,:,j);
        end
    end
end

if mode==2
    DD=zeros(n_P,n_Q);
    for i=1:n_D
        Di=D(:,:,i);
        max_q=max(abs(Di));
        max_p=max(abs(Di'));
        max_Q=repmat(max_q,[n_P,1]);
        max_P=repmat(max_p',[1,n_Q]); 
        max_PQ=(max_P+max_Q)/2;
        Di=Di./max_PQ;
        DD=DD+w(i)*Di;
    end
end
