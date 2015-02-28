%% This is a test run of octave using machine learning class code
%

%% Initialization
%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
traindata = csvread('TrainSet.csv');
[m,n] = size(traindata);


%%  Inputs to change later
k = 9;  % variables that train 
X = traindata(:, 1:k);
y = traindata(:, n);

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];


%% ================ Part 2: Gradient Descent ================
%

fprintf('Running gradient descent ...\n');

% Choose some alpha value
alpha = 0.01;
num_iters = 400;

%% Initialize Tranform Features
num_poly=4;
y_trans=transformFeatures(y,num_poly);
[m_trans, n_trans] = size(y_trans);
J_trans=zeros(3,n_trans); %initailize variable


for i=1:n_trans

% Init Theta and Run Gradient Descent 
y=y_trans(:,i)
theta = zeros(k+1, 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);
J_trans(:,i) = [J_history(1);J_history(num_iters);J_history(num_iters)/J_history(1)];


%% =================== Plot Results ======================
% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');
endfor


% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');

% Display Final Cost Function result
fprintf('J computed from Cost Function: \n');
 J_trans  % first row is initial Cost value, second row is final cost value, 
          % third row is ratio (the lower the better)
fprintf('\n');




