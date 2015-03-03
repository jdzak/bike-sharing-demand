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


%% =========== Part 3: Regularized Linear Regression Gradient =============
%  You should now implement the gradient for regularized linear 
%  regression.
% %

% theta = zeros(size(X, 2), 1);
% [J, grad] = linearRegCostFunction([ones(m, 1) X], y, theta, 1);

% fprintf('Program paused. Press enter to continue.\n');
% pause;


% %% =========== Part 4: Train Linear Regression =============
% %  Once you have implemented the cost and gradient correctly, the
% %  trainLinearReg function will use your cost function to train 
% %  regularized linear regression.
% % 
% %  Write Up Note: The data is non-linear, so this will not give a great 
% %                 fit.
% %

% %  Train linear regression with lambda = 0
% lambda = 0;
% [theta] = trainLinearReg([ones(m, 1) X], y, lambda);

% fprintf('Program paused. Press enter to continue.\n');
% pause;


% %% =========== Part 5: Learning Curve for Linear Regression =============
% %  Next, you should implement the learningCurve function. 
% %
% %  Write Up Note: Since the model is underfitting the data, we expect to
% %                 see a graph with "high bias" -- slide 8 in ML-advice.pdf 
% %

% lambda = 0;
% [error_train, error_val] = ...
%     learningCurve([ones(m, 1) X], y, ...
%                   [ones(size(Xval, 1), 1) Xval], yval, ...
%                   lambda);

% plot(1:m, error_train, 1:m, error_val);
% title('Learning curve for linear regression')
% legend('Train', 'Cross Validation')
% xlabel('Number of training examples')
% ylabel('Error')
% axis([0 13 0 150])

% fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
% for i = 1:m
%     fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
% end

% fprintf('Program paused. Press enter to continue.\n');
% pause;

%% ================ Part 3: Load Test data ================

fprintf('Loading data ...\n');

%% Load Data
fid = fopen('test.csv');
train_raw = textscan(fid,'%*s%n%n%n%n%n%n%n%n%n','collectoutput',1,'delimiter',',','headerlines',1);
fclose(fid);

% ignore date column (column 1)
Xtest = train_raw{1}(:,[2:9]);

fprintf('First 10 examples from the dataset: \n');
fprintf(' x = [%d, %d, %d, %d, %d, %d, %d, %d] \n', Xtest(1:10,:));

fprintf('Program paused. Press enter to continue.\n');


%% =========== Part 6: Feature Mapping for Polynomial Regression =============
%  One solution to this is to use polynomial regression. You should now
%  complete polyFeatures to map each example into its powers
%

p = 8;

% Map X onto Polynomial Features and Normalize
X_poly = polyFeatures(X, p);
[X_poly, mu, sigma] = featureNormalize(X_poly);  % Normalize
X_poly = [ones(m, 1), X_poly];                   % Add Ones

% Map X_poly_test and normalize (using mu and sigma)
X_poly_test = polyFeatures(Xtest, p);
X_poly_test = bsxfun(@minus, X_poly_test, mu);
X_poly_test = bsxfun(@rdivide, X_poly_test, sigma);
X_poly_test = [ones(size(X_poly_test, 1), 1), X_poly_test];         % Add Ones

fprintf('\nProgram paused. Press enter to continue.\n');
pause;



%% =========== Part 7: Learning Curve for Polynomial Regression =============
%  Now, you will get to experiment with polynomial regression with multiple
%  values of lambda. The code below runs polynomial regression with 
%  lambda = 0. You should try running the code with different values of
%  lambda to see how the fit and learning curve change.
%

lambda = 0;
[theta] = trainLinearReg(X_poly, y, lambda);

% % Plot training data and fit
% figure(1);
% plot(X, y, 'rx', 'MarkerSize', 10, 'LineWidth', 1.5);
% plotFit(min(X), max(X), mu, sigma, theta, p);
% xlabel('Change in water level (x)');
% ylabel('Water flowing out of the dam (y)');
% title (sprintf('Polynomial Regression Fit (lambda = %f)', lambda));

% figure(2);
% [error_train, error_val] = ...
%     learningCurve(X_poly, y, X_poly_val, yval, lambda);
% plot(1:m, error_train, 1:m, error_val);

% title(sprintf('Polynomial Regression Learning Curve (lambda = %f)', lambda));
% xlabel('Number of training examples')
% ylabel('Error')
% axis([0 13 0 100])
% legend('Train', 'Cross Validation')

% fprintf('Polynomial Regression (lambda = %f)\n\n', lambda);
% fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
% for i = 1:m
%     fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
% end

% fprintf('Program paused. Press enter to continue.\n');
% pause;

%% =========== Part 8: Validation for Selecting Lambda =============
%  You will now implement validationCurve to test various values of 
%  lambda on a validation set. You will then use this to select the
%  "best" lambda value.
%

% [lambda_vec, error_train, error_val] = ...
%     validationCurve(X_poly, y, X_poly_val, yval);

% close all;
% plot(lambda_vec, error_train, lambda_vec, error_val);
% legend('Train', 'Cross Validation');
% xlabel('lambda');
% ylabel('Error');

% fprintf('lambda\t\tTrain Error\tValidation Error\n');
% for i = 1:length(lambda_vec)
%   fprintf(' %f\t%f\t%f\n', ...
%             lambda_vec(i), error_train(i), error_val(i));
% end

% fprintf('Program paused. Press enter to continue.\n');
% pause;







%% ================ Part 4: Guess Answers ================

% Make sure no negative answers
answers = X_poly_test * theta;
indices = find(answers < 0);
answers(indices) = 0;
answers = uint32(answers);


% Print out some answers
fprintf('First 10 answers: \n');
fprintf(' answers = %d \n', [answers(1:10,:)']);

%% ================ Part 5: Write Answers ================

csvwrite('answers.txt', answers);
