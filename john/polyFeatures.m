function [X_poly] = polyFeatures(X, p)
%POLYFEATURES Maps X (1D vector) into the p-th power
%   [X_poly] = POLYFEATURES(X, p) takes a data matrix X (size m x 1) and
%   maps each example into its polynomial features where
%   X_poly(i, :) = [X(i) X(i).^2 X(i).^3 ...  X(i).^p];
%


% You need to return the following variables correctly.
% X_poly = zeros(numel(X), p);

% ====================== YOUR CODE HERE ======================
% Instructions: Given a vector X, return a matrix X_poly where the p-th 
%               column of X contains the values of X to the p-th power.
%
% 
% p_vector = repmat([1:p], numel(X), 1);

% % disp('p_vector: '),disp(size(p_vector));
% % disp('X_poly: '),disp(X);
% % pause;

% m = size(X, 1);
% features = size(X, 2);
% disp()
% disp('X: ')
% disp(X(5, :));

% X_flat = reshape(X, features * m, 1);
% X_flat_poly = repmat(X_flat, 1, p) .^ p_vector;
% X_poly = reshape(X_flat_poly, features * p, m);
% disp('features: ');
% disp(features);
% disp('X_poly: ');
% disp(size(X_poly));

X_poly = X;
for i = 2:p
  X_poly = [X_poly X.^i];
end

% =========================================================================

end
