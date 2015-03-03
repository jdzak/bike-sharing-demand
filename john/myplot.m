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


% Plot the first feature vs # riders
figure;
X1 = X(:,1);
disp(size(X1));
disp(size(y));
plot(X1, y, '-b', 'markerstyle', 'circle', 'linestyle', 'noline');
xlabel('Season');
ylabel('Y');