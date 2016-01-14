clear all
clc
% For the data set of exercise 2 part a. Plot the cross-validation score on top of the training and test
% set errors for different values ? = {10^?6,10^?5,..,10^3} of the regularization parameter.
dim = 10;
max_iteration_size = 200;
j  = -6 : 3; % from 10^?6 up to 10^3
% j = 10^-6 : 10^3; % for longer iterations
% initialize things:

for idx = 1:numel(j)
    gamma(idx)=10^j(idx);
    for i=1:max_iteration_size
        [X_600, y_600]= generate_data(600, dim);
        X_test = X_600(1:500,:);
        y_test = y_600(1:500,:);
        X_train_100 = X_600(501:600,:);
        y_train_100 = y_600(501:600,:);
        [mse_train_100_avr(i), mse_valid_100_avr(i), mse_test_100_avr(i)] = get_cross_valid_score(X_train_100,y_train_100,X_test,y_test,gamma(idx)); 
        
        X_train_10 = X_600(501:510,:);
        y_train_10 = y_600(501:510,:);
        [mse_train_10_avr(i), mse_valid_10_avr(i), mse_test_10_avr(i)] = get_cross_valid_score(X_train_10,y_train_10,X_test,y_test,gamma(idx)); 
    end
    mse_train_100(idx) = mean(mse_train_100_avr);
    mse_valid_100(idx) = mean(mse_valid_100_avr);
    mse_test_100(idx) = mean(mse_test_100_avr);
    mse_train_10(idx) = mean(mse_train_10_avr);
    mse_valid_10(idx) = mean(mse_valid_10_avr);
    mse_test_10(idx) = mean(mse_test_10_avr);
end
% plotting graphs
figure

% disp(gamma)
% a
% semilogx(gamma, mse_train_100, 'r', gamma, mse_valid_100, 'g', gamma, mse_test_100, 'b')
% legend({'--r','g','b'}, {'training data set (80 samples)','validation data set (20 samples)','test data set (500 samples)'})
% xlabel('log scale of the regularization parameter')
% ylabel('mean square error')
% grid on

% b
semilogx(gamma, mse_train_10, '--r', gamma, mse_valid_10, 'g', gamma, mse_test_10, 'b')
legend({'--r','g','b'}, {'training data set (8 samples)','validation data set (2 samples)','test data set (500 samples)'})
xlabel('log scale of the regularization parameter')
ylabel('mean square error')
grid on


