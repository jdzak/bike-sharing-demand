%% This file reads in an dataset (currently a .csv) and splits it
%  into a training set and a cross validation set.
%% Initialization

%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

%% Load Data
data = csvread('train_mult2.csv');
[m,n] = size(data);
data = data(2:m,1:n);  %  This deletes the header
m=m-1;   % with the header deleted m has one less row.

%% Split the matrix
m_cv = round(.3*m);
separate = sort(randperm(m,m_cv),'descend');

for i=1:m_cv
    X_cv(i,:)=data(separate(i),:);  % creating cross-validation set
    data(separate(i),:)=[];   % will be training set
endfor

csvwrite("TrainSet.csv",data);
csvwrite("CrossValSet.csv",X_cv);
