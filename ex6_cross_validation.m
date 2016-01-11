clear all
clc
% For the data set of exercise 2 part a. Plot the cross-validation score on top of the training and test
% set errors for different values ? = {10^?6,10^?5,..,10^3} of the regularization parameter.
max_iteration_size = 200;
j  = -6 : 3; % from 10^?6 up to 10^3
% j = 10^-6 : 10^3; % for longer iterations
% initialize things:
[mse_test_100, mse_test_10] = deal(zeros(numel(j)));
[mse_train_100, mse_train_10] = deal(zeros(numel(j)));
[mse_valid_100, mse_valid_10] = deal(zeros(numel(j)));

for idx = 1:numel(j)
    gamma(idx)=10^j(idx);
    [mse_train_100(idx), mse_valid_100(idx), mse_test_100(idx)] = get_cross_valid_score(100,500,gamma(idx)); 
    [mse_train_10(idx), mse_valid_10(idx), mse_test_10(idx)] = get_cross_valid_score(10,500,gamma(idx)); 
end

% plotting graphs
figure

% disp(gamma)

semilogx(gamma, mse_train_100, '--r', gamma, mse_valid_100, 'b', gamma, mse_test_100, 'g')
% semilogx(gamma, mse_train_10, '--r', gamma, mse_valid_10, 'b', gamma, mse_test_10, 'g')

title('Question 6')
xlabel('gamma')
ylabel('mean square error')

