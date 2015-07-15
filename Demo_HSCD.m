%% %Init
clc;
clear all;
close all;
addpath(genpath(fullfile('./lib')));
addpath(genpath(fullfile('./MCSH')));
addpath(genpath(fullfile('./MSPC')));
%% MCSH
cd ./MCSH
Demo_MCSH;
cd ..
%% MSPC
cd ./MSPC
Demo_MSPC;
cd ..
%% HSCD
Plot_Result_HSCD;