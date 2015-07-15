function [Stat]=PlotCMC(CMN,showrange,isALL,plotrank,method,color,comment,isplot)
%%
num_method=size(CMN,1);
num_gallery=size(CMN,2);
num_probe=max(max(CMN));%% maybe bug
CMR=100*CMN/num_probe;
%%
if ~exist('showrange','var')
    showrange=[1 num_gallery 0 100];
end;

if ~exist('isALL','var')
    isALL=0;
    if showrange(2)==num_gallery
        isALL=1;
    end;
end

if  exist('isALL','var')
    if isALL==1
        MN=CMN(:,1);
        for i=2:num_gallery
            MN(:,i)=CMN(:,i)-CMN(:,i-1);
        end
        MR=MN./num_probe;
        ER=zeros(num_method,1);
        for i=1:num_gallery
            ER=ER+i*MR(:,i);
        end
        MR(MR==0)=eps;
    end
end

if ~exist('method','var') || isempty(method)
    method={};
    for i=1:num_method
        method(i)={''};
    end;
    method=char(method);
else
    method=char(method);
end;

if ~exist('color','var') || isempty(color)
    color={};
    for i=1:num_method
        color(i)={'-b'};
    end;
    color=char(color);
else
    color=char(color);
end;
if ~exist('isplot','var')
    isplot=1;
end;

Stat=zeros(num_method,1);
%%
fprintf(['%% ---- Method Number : ' num2str(num_method) ...
    '; CMC Probe Number : ' num2str(num_probe)...
    '; CMC Gallery Number : ' num2str(num_gallery) ' ---- %%\n']);
if exist('comment','var')
    fprintf([comment '\n']);
end
fprintf([datestr(now,'yyyy mm dd, HH:MM:SS AM') '\n\n']);
if isplot==1
    figure;
end
for i=1:num_method
    if isplot==1
        plot(1:num_gallery,CMR(i,:),color(i,:));
        axis(showrange);
        grid on
        hold on
    end
    %method
    fprintf(['%% Method ' num2str(i) ':' method(i,:) '\n']);
    num=0;
    %rank 1
    str1=num2str(CMN(i,1));
    str2=num2str(sprintf('%.2f',CMR(i,1)));
    fprintf(['rank-1: ' str1   ' ( '  str2 '%% )\n' ]);
    num=num+1;
    Stat(i,num)=CMN(i,1);
    num=num+1;
    Stat(i,num)=CMR(i,1);
    %rank 10%
    str1=num2str(CMN(i,round(0.1*num_gallery)));
    str2=num2str(sprintf('%.2f',CMR(i,round(0.1*num_gallery))));
    str3=num2str(round(0.1*num_gallery));
    fprintf(['rank-10%%(' str3  '): '  str1  ' ( '  str2  '%% )\n' ]);
    num=num+1;
    Stat(i,num)=CMN(i,round(0.1*num_gallery));
    num=num+1;
    Stat(i,num)=CMR(i,round(0.1*num_gallery));
    %show given rank
    if exist('plotrank','var')
        str1=num2str(CMN(i,plotrank));
        str2=num2str(sprintf('%.2f',CMR(i,plotrank)));
        fprintf(['rank-' num2str(plotrank) ': ' str1   ' ( '  str2 '%% )\n' ]);
        num=num+1;
        Stat(i,num)=CMN(i,plotrank);
        num=num+1;
        Stat(i,num)=CMR(i,plotrank);
    end
    %rank 50%
    str1=num2str(CMN(i,round(0.5*num_gallery)));
    str2=num2str(sprintf('%.2f',CMR(i,round(0.5*num_gallery))));
    str3=num2str(round(0.5*num_gallery));
    fprintf(['rank-50%%(' str3  '): '  str1  ' ( '  str2  '%% )\n' ]);
    num=num+1;
    Stat(i,num)=CMN(i,round(0.5*num_gallery));
    num=num+1;
    Stat(i,num)=CMR(i,round(0.5*num_gallery));
    %100% CMR rank
    str1=num2str(sum(CMR(i,:)<100)+1);
    fprintf(['CMR-100%%: '  str1  '\n' ]);
    %CMC Area
    area=sum(CMR(i,:))/(size(CMR,2));
    fprintf(['normorlized area: '  num2str(sprintf('%.2f',area)) '\n']);
    num=num+1;
    Stat(i,num)=area;
    %CMC Area 10%
    area2=sum(CMR(i,1:round(0.1*num_gallery)))/(round(0.1*num_gallery));
    str3=num2str(round(0.1*num_gallery));
    fprintf(['normorlized area 10%%(' str3  '): '  num2str(sprintf('%.2f',area2)) '\n']);
    num=num+1;
    Stat(i,num)=area2;
    %PUR
    if isALL==1
        S=num_gallery;
        PUR=100*(log(S)+sum(MR(i,:).*log(MR(i,:))))/log(S);
        fprintf(['PUR: '  num2str(sprintf('%.2f',PUR)) '\n']);
        num=num+1;
        Stat(i,num)=PUR;
    end
    fprintf(['\n']);
end;
%%
if isplot==1
    xlabel('rank');
    ylabel('recognition percentage');
end
%%
str={};
for i=1:size(CMR,1)
    str(i)={[method(i,:) ]};
end;
if isplot==1
    legend(str,4);
end
% ACI
if num_method>1
    w=[1/4 1/4 1/2];
    ACI=w(1)*Stat(:,2)/max(Stat(:,2))+w(2)*Stat(:,4)/max(Stat(:,4))+w(3)*Stat(:,8)/max(Stat(:,8));
    for i=1:num_method
        fprintf(['%% ' num2str(i) ':' method(i,:) ' ACI -- '  num2str(sprintf('%.2f',100*ACI(i))) '\n']);
    end
    fprintf(['\n']);
end

if isplot==1
    hold off;
end
end
