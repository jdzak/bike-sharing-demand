% Efficiencies:
% * Use Date (date = datenum(out{1});)
% * Don't use abs(answers)
% * Try different model for binary data (1 or 0)
%
%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
fid = fopen('train.csv');
train_raw = textscan(fid,'%*s%n%n%n%n%n%n%n%n%n%n%n%n','collectoutput',1,'delimiter',',','headerlines',1);
fclose(fid);

% ignore date column (column 1)
X = train_raw{1}(:,[2:9]);
y = train_raw{1}(:,12);

m = length(y);

% Print out some data points
fprintf('First 10 examples from the dataset: \n');
fprintf(' x = [%d, %d, %d, %d, %d, %d, %d, %d], y = %d \n', [X(1:10,:) y(1:10,:)]');

fprintf('Program paused. Press enter to continue.\n');
pause;

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];

%% ================ Part 2: Gradient Descent ================

fprintf('Running gradient descent ...\n');

% Choose some alpha value
alpha = 0.03;
num_iters = 400;

% Init Theta and Run Gradient Descent 
theta = zeros(size(X, 2), 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% Plot the convergence graph
% figure;
% plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
% xlabel('Number of iterations');
% ylabel('Cost J');

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');

%% ================ Part 3: Feature Normalization ================

fprintf('Loading data ...\n');

%% Load Data
fid = fopen('test.csv');
train_raw = textscan(fid,'%*s%n%n%n%n%n%n%n%n%n','collectoutput',1,'delimiter',',','headerlines',1);
fclose(fid);

% ignore date column (column 1)
X = train_raw{1}(:,[2:9]);

m = length(X);

% Print out some data points
fprintf('First 10 examples from the dataset: \n');
fprintf(' x = [%d, %d, %d, %d, %d, %d, %d, %d] \n', X(1:10,:));

fprintf('Program paused. Press enter to continue.\n');
pause;

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];

%% ================ Part 4: Guess Answers ================

% Make sure no negative answers
answers = abs(X * theta);

% Print out some answers
fprintf('First 10 answers: \n');
fprintf(' answers = %d \n', [answers(1:10,:)']);

%% ================ Part 5: Write Answers ================

csvwrite('answers.txt', answers);
