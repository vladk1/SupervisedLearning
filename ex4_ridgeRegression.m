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
d = 10;
for idx = 1:numel(j)
    gamma(idx)=10^j(idx);
    for i=1:max_iteration_size
        [X_600, y_600]= generate_data(600, d);
        X_test = X_600(1:500,:);
        y_test = y_600(1:500,:);
        X_train_100 = X_600(501:600,:);
        y_train_100 = y_600(501:600,:);
        X_train_10 = X_600(501:510,:);
        y_train_10 = y_600(501:510,:);
        
        [mse_train_100(i,idx), mse_test_100(i,idx)] = get_mean_square_error(X_train_100,y_train_100,X_test,y_test,gamma(idx));
        [mse_train_10(i,idx), mse_test_10(i,idx)] = get_mean_square_error(X_train_10,y_train_10,X_test,y_test,gamma(idx));  
%         fprintf('gamma=%d mse_train=%d mse_test=%d\n',gamma(idx), mse_train_100(i,idx),mse_test_100(i,idx));
    end   
end

% plotting graphs
figure

% a)
% 1 for first iteration
% disp(mse_train_100(1,:))
% disp(mse_test_100(1,:))
% semilogx(gamma, mse_train_100(1,:),'r',gamma, mse_test_100(1,:), 'b')
% title('Question 4.a) training data size = 100')
% xlabel('log scale of the regularization parameter')
% ylabel('mean square error')
% legend({'r','b'}, {'training data set (100 samples)','test data set (500 samples)'})
% b)
% disp(mse_train_10(1,:))
% disp(mse_test_10(1,:))
% semilogx(gamma, mse_train_10(1,:), 'r', gamma, mse_test_10(1,:), 'b')
% title('Question 4.b) training data size = 10')
% xlabel('log scale of the regularization parameter')
% ylabel('mean square error')
% legend({'r','b'}, {'training data set (10 samples)','test data set (500 samples)'})
% c)
% average erros accross 200 iterations
% disp(mse_train_100_avr)
% disp(mse_test_100_avr) 
% semilogx(gamma, mean(mse_train_100), 'r',gamma, mean(mse_test_100), 'b')
% title('Question 4.c) Averaged (200 runs) MSE for training data (100 samples) and test data sets')
% xlabel('log scale of the regularization parameter')
% ylabel('mean square error')
% legend({'r','b'}, {'training data set (100 samples)','test data set (500 samples)'})

% disp(mse_train_10_avr)
% disp(mse_test_10_avr) 
semilogx(gamma, mean(mse_train_10), 'r',gamma, mean(mse_test_10), 'b')
grid on
title('Question 4.c) Averaged (200 runs) MSE for training data (10 samples) and test data sets')
xlabel('gamma')
ylabel('mean square error')
legend({'r','b'}, {'training data set (10 samples)','test data set (500 samples)'})

