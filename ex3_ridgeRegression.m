clear all
clc
% Perform ridge regression on the data sets as generated in exercise 2 part a 
% for ? ranging from 10^?6 up to 10^3, and all powers of 10 in between. 
% What are the training and test mean squared errors? 
% Plot the training and test set errors as a function of ? (use a log scale for the ? axis).
d = 10; %Dimension
I = eye(d); % Identity matrix
max_iteration_size = 2;
[mean_square_error_train, mean_square_error_test] = deal(zeros(1,max_iteration_size));
j  = -6 : 3;
for idx = 1:numel(j)
    gamma=10^j(idx);
    for i=1:max_iteration_size
        i_train=[100,10];  %Size 100 training and 10 size training 
        i_test=500;  %Size 500 test 
        Xte=randn(i_test,d);   %X is drawn from the standard normal distribution.
        Xtr=randn(i_train(i),d);   %X is drawn from the standard normal distribution.
        n_test=randn(i_test,1);   %n is drawn from the standard normal distribution.
        n_train=randn(i_train(i),1);   %n is drawn from the standard normal distribution.
        w_test=randn(d,1); % weighted vector= random weight vector w ? R10
        w_train=randn(d,1); % weighted vector= random weight vector w ? R10
        y_train=Xtr*w_train+n_train; %Calculate gamma for training data
        y_test=Xte*w_test+n_test; %Calculate gamma for training data 
        l_train=i_train(i);
        l_test=i_test;

        wtr_est = (Xtr'*Xtr + gamma*I) \ Xtr'*y_train;

        % Using equation (3) compute the mean squared error on both the training
        % and test sets.
        mean_square_error_train(idx,i) = 1/l_train*((Xtr*wtr_est-y_train)'*(Xtr*wtr_est-y_train));
        mean_square_error_test(idx,i) = 1/l_train*((Xte*wtr_est-y_test)'*(Xte*wtr_est-y_test)); %Mean square error for the test data is way higher
    end
    
%     fprintf('gamma = %d\n',gamma);
%     disp('train:')
%     disp('    data100  data10')
%     disp(mean_square_error_train)
%     disp('test:')
%     disp('    data100  data10')
%     disp(mean_square_error_test)
    
end

% plotting graphs
figure
j  = -6 : 3;
% initialize multiple variables to speed up things
[mse_train_100,mse_test_100,mse_train_10,mse_test_10] = deal(zeros(1,numel(j)));
for idx = 1:numel(j)
    gamma(idx)=log(10^j(idx));
    mse_train_100(idx)=mean_square_error_train(idx,1);     
    mse_test_100(idx)=mean_square_error_test(idx,1);
    mse_train_10(idx)=mean_square_error_train(idx,2);
    mse_test_10(idx)=mean_square_error_test(idx,2);
%     fprintf('gamma = %d\n',gamma);
%     fprintf('mse_train_100 = %d\n',mse_train_100);
%     fprintf('mse_test_100 = %d\n',mse_test_100);
end
% a)
semilogx(gamma, mse_train_100, 'r',gamma, mse_test_100, 'b')
% b)
% semilogx(gamma, mse_train_10, 'r',gamma, mse_test_10, 'b')

grid on
title('Question 4')
xlabel('gamma')
ylabel('mean square error')

