function [mse_train, mse_test] = get_mean_square_error(i_train_size, i_test_size, gamma)
    d = 10; %Dimension
    I = eye(d); % Identity matrix

    Xte=randn(i_test_size, d);   %X is drawn from the standard normal distribution.
    Xtr=randn(i_train_size, d);   %X is drawn from the standard normal distribution.
    
    n_test=randn(i_test_size,1);   %n is drawn from the standard normal distribution.
    n_train=randn(i_train_size,1);   %n is drawn from the standard normal distribution.
    
    w_test=randn(d,1); % weighted vector= random weight vector w ? R10
    w_train=randn(d,1); % weighted vector= random weight vector w ? R10
    
    y_train=Xtr*w_train+n_train; %Calculate gamma for training data
    y_test=Xte*w_test+n_test; %Calculate gamma for training data 
    
    l_train=i_train_size; 
    l_test=i_test_size;
%     fprintf('l_train = %d l_test = %d\n',l_train,l_test);

    wtr_est = (Xtr'*Xtr + gamma*I) \ Xtr'*y_train;
    
    % Using equation (3) compute the mean squared error on both the training
    % and test sets.
    mse_train = 1/l_train*((Xtr*wtr_est-y_train)'*(Xtr*wtr_est-y_train)); 
    mse_test = 1/l_test*((Xte*wtr_est-y_test)'*(Xte*wtr_est-y_test)); %Mean square error for the test data is way higher
%     fprintf('function mse_train = %d mse_test = %d\n',mse_train,mse_test);
end