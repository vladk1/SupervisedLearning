clear all
clc
% Perform ridge regression on the data sets as generated in exercise 2 part a 
% for ? ranging from 10^?6 up to 10^3, and all powers of 10 in between. 
% What are the training and test mean squared errors? 
% Plot the training and test set errors as a function of ? (use a log scale for the ? axis).

max_iteration_size = 200;
j  = -6 : 3; % from 10^?6 up to 10^3

[mse_test_100, mse_test_10] = deal(zeros(max_iteration_size, numel(j)));
[mse_train_100, mse_train_10] = deal(zeros(max_iteration_size, numel(j)));

for idx = 1:numel(j)
    gamma=10^j(idx);
    for i=1:max_iteration_size
        %Size 100 training and 10 size training; Size 500 test;
        [mse_train_100(i,idx), mse_test_100(i,idx)] = get_mean_square_error(100, 500, gamma);
        [mse_train_10(i,idx), mse_test_10(i,idx)] = get_mean_square_error(10, 500, gamma);  
%         fprintf('mse_train = %d mse_test = %d\n',mse_train_100(i,idx),mse_test_100(i,idx));
    end   
end

% plotting graphs
figure
% initialize multiple variables to speed up things
for idx = 1:numel(j)
    gamma(idx)=10^j(idx);
end
% a)
% semilogx(gamma, mse_train_100(1,:),'r',gamma, mse_test_100(1,:), 'b')
% b)
% semilogx(gamma, mse_train_10(1,:), 'r',gamma, mse_test_10(1,:), 'b')
% c)
% average erros accross 200 iterations
mse_train_100_avr = mean(mse_train_100(:,:),1); %# average along dim 1, i.e. average all rows
mse_test_100_avr = mean(mse_test_100(:,:),1); %# average along dim 1, i.e. average all rows
mse_train_10_avr = mean(mse_train_10(:,:),1); %# average along dim 1, i.e. average all rows
mse_test_10_avr = mean(mse_test_10(:,:),1); %# average along dim 1, i.e. average all rows
% disp(mse_train_100_avr) % display to test
  semilogx(gamma, mse_train_100_avr, 'r',gamma, mse_test_100_avr, 'b')
%  semilogx(gamma, mse_train_10_avr, 'r',gamma, mse_test_10_avr, 'b')

grid on
title('Question 4')
xlabel('gamma')
ylabel('mean square error')

