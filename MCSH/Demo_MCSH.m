%% %Init
clc;
clear all;
close all;
addpath(genpath(fullfile('../lib')));
method='MCSH';
datasetname='VIPeR';
%% %Data
load('../data/VIPeR_H128_W48.mat');
dataset=VIPeR;
%% %Ftr
prefixstr=['Exp_' method '_' datasetname '_Ftr'];
if exist(['./data/' prefixstr '.mat'],'file')
    load(['./data/' prefixstr '.mat']);
else
    tic;
    GetFtr;
    toc;
end
%% %Dist
prefixstr=[prefixstr '_Dist'];
if exist(['./data/'  prefixstr  '.mat'],'file')
    load(['./data/'  prefixstr  '.mat']);
else
    tic;
    GetDist_MCSH;  
    toc;
end
Dist=Dist_MCSH;
%% %CV
load('../data/CVIdx_VIPeR.mat');
showrange=[1 50 10 100];
cvidx=CVIdx_VIPeR.SvsS_SDALF;
[CMN,CMR]=GetCV(Dist,cvidx,'SvsS',0,'');
Stat=PlotCMC(CMN, showrange, 1,50, 'MCSH',{},'',1);
%% %Plot
Plot_Result_MCSH;

