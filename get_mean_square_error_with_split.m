function [ mse_train, mse_valid, mse_test] = get_mean_square_error_with_split( Xtr, y_tr, Xte, y_test, gamma, split_train, split_valid ) 
    len_te = size(Xte, 1);
    len_train = size(Xtr, 1)*split_train;
    len_valid = size(Xtr, 1)*split_valid;
%     fprintf('len_te=%d len_train=%d len_valid=%d\n',len_te,len_train,len_valid);
    
%     Dividing training set into training data set and validation training
%     set with split_train/split_valid ratio
    X_train = Xtr(1:len_train,:);
    X_valid = Xtr(len_train+1:len_train+len_valid,:);
    y_train = y_tr(1:len_train,:);
    y_valid = y_tr(len_train+1:len_train+len_valid,:);
%     fprintf('size(X_train, 1)=%d size(X_valid, 1)=%d size(y_train, 1)=%d size(y_valid, 1)=%d\n',size(X_train, 1),size(X_valid, 1),size(y_train, 1), size(y_valid, 1));
       
    dim = size(X_train, 2);
    wtr_est = ((X_train' * X_train) + (gamma*len_train*eye(dim))) \ (X_train'*y_train);
 
    mse_train = get_mse(X_train, y_train, wtr_est, len_train);
    mse_valid = get_mse(X_valid, y_valid, wtr_est, len_valid);
    mse_test = get_mse(Xte, y_test, wtr_est, len_te);
   %     fprintf('function mse_train = %d mse_test = %d mse_valid = %d\n',mse_train,mse_test,mse_valid);
end

function mse = get_mse(X, Y, w, len)
    mse = (1.0/len) * (w' * (X)' * X * w - 2 * Y' * X * w + Y' * Y);
end

% function [mse] = get_mse (i_size, d, wtr_est)
%     X=randn(i_size, d);   %X is drawn from the standard normal distribution.    
%     n=randn(i_size,1);   %n is drawn from the standard normal distribution.
%     w=randn(d,1); % weighted vector= random weight vector w ? R10
%     y=X*w+n; %Calculate gamma for training data 
%     l=i_size;    
%     % Using equation (3) compute the mean squared error on both the training
%     % and test sets.
%     mse = 1/l*((X*wtr_est-y)'*(X*wtr_est-y)); %Mean square error for the test data is way higher
% end

