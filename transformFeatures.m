function [y_trans] = transfromFeatures(y,p)
%TransformFeatures takes a m x 1 solution set and adds more transforms to it.
%   For the quadratic model it will create p quadratic options 
%    (e.g. p=3 is y,y^2 and y^3)   
%   [y_trans] = transfromFeaturesBasic(y) 
%   Just doing basic transforms here
%   See http://stattrek.com/regression/linear-transformation.aspx


% You need to return the following variables correctly.
m = length(y);
y_trans = zeros(numel(y),3);

% ====================== YOUR CODE HERE ======================
% Instructions: Given a vector X, return a matrix X_poly where the p-th 
%               column of X contains the values of X to the p-th power.
%
% 
y_trans = y;
% add Quadratic model
for i = 2:p
          y_trans = [y_trans y_trans.^(1/p)];
       end

% if there exists any zeros in y then the log(y) and 1/y won't work.  
% First we do a check 
if all(y(:,1)==0
	% add Exponential model
	y_trans = [y_trans log(y)];
	% add Reciprocal model
	y_trans = [y_trans 1./y];
      endif




% =========================================================================

end
