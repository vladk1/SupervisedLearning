function [ mse_train, mse_valid, mse_test] = get_mean_square_error_with_split( i_train_size, i_test_size, gamma, split_train, split_valid )
    d = 10; %Dimension
    I = eye(d); % Identity matrix
    
    i_valid_size = i_train_size * split_valid;
    i_new_train_size = i_train_size * split_train;

    Xtr=randn(i_new_train_size, d);   %X is drawn from the standard normal distribution.
    n_train=randn(i_new_train_size,1);   %n is drawn from the standard normal distribution. 
    w_train=randn(d,1); % weighted vector= random weight vector w ? R10 
    y_train=Xtr*w_train+n_train; %Calculate gamma for training data  
    l_train=i_new_train_size; 
    wtr_est = (Xtr'*Xtr + gamma*I) \ Xtr'*y_train;
    mse_train = 1/l_train*((Xtr*wtr_est-y_train)'*(Xtr*wtr_est-y_train)); 
    
    mse_valid = get_mse(i_valid_size, d, wtr_est);
    mse_test = get_mse(i_test_size, d, wtr_est);
   %     fprintf('function mse_train = %d mse_test = %d mse_valid = %d\n',mse_train,mse_test,mse_valid);
end

function [mse] = get_mse (i_size, d, wtr_est)
    X=randn(i_size, d);   %X is drawn from the standard normal distribution.    
    n=randn(i_size,1);   %n is drawn from the standard normal distribution.
    w=randn(d,1); % weighted vector= random weight vector w ? R10
    y=X*w+n; %Calculate gamma for training data 
    l=i_size;    
    % Using equation (3) compute the mean squared error on both the training
    % and test sets.
    mse = 1/l*((X*wtr_est-y)'*(X*wtr_est-y)); %Mean square error for the test data is way higher
end

