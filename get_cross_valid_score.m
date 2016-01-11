function [ mse_train, mse_valid, mse_test] = get_cross_valid_score( i_train_size, i_test_size, gamma )
    %5-fold cross validation 
    k = 5;
    d = 10; %Dimension
    I = eye(d); % Identity matrix
    
    [X_train, y_train, l_train]= generate_data(i_train_size);
    [X_test, y_test, l_test]= generate_data(i_test_size);
    l_valid = l_train / k;
    
    wtr_est = (X_train'*X_train + gamma*l_train*I) \ X_train'*y_train;
    mse_train = get_mse(X_train, y_train, l_train, wtr_est);
    mse_test = get_mse(X_test, y_test, l_test, wtr_est);
   
    for i = 1:k
        a = l_valid*(i-1)+1; 
        b = i*l_valid;
        fprintf('i: %d \n',i);
        fprintf('valid a:');
        disp(a)
        fprintf('valid b:');
        disp(b)

        X_valid = X_train(a:b,:);
%         fprintf('X_valid:');
%         disp(X_valid)
        y_valid = y_train(a:b,:);
%         fprintf('y_valid:');
%         disp(y_valid)

%         fprintf('train [1:a b:l_train]:');
%         disp([1:a b:l_train])
       
        X_train_i= X_train([1:a b:l_train],:);
%         fprintf('X_train_i:');
%         disp(X_train_i)
        
        y_train_i= y_train([1:a b:l_train],:);
%         fprintf('y_train_i:');
%         disp(y_train_i)
        l_train_i= l_train - l_valid;
%         fprintf('l_train_i:');
%         disp(l_train_i)
        
        wtr_est_i = (X_train_i'*X_train_i + gamma*l_train_i*I) \ X_train_i'*y_train_i;
        
%         mse_train_i(i) = get_mse(X_train_i, y_train_i, l_train_i, wtr_est_i); 
        mse_valid_i(i) = get_mse(X_valid, y_valid, l_valid, wtr_est_i); 
%         mse_test_i(i) = get_mse(X_test, y_test, l_test, wtr_est_i);
    end
    
    mse_valid = mean(mse_valid_i);
    fprintf('mse_train:%d mse_valid:%d mse_test:%d \n',mse_train, mse_valid, mse_test);
end

function [X, y, l] = generate_data(size)
    d = 10; %Dimension
    X = randn(size, d);
    n = randn(size,1);
    w = randn(d,1); 
    y = X * w + n; 
    l = size;
end

function [mse] = get_mse (X, y, l, wtr_est)
    % Using equation (3) compute the mean squared error on both the training
    % and test sets.
    mse = 1/l*((X*wtr_est-y)'*(X*wtr_est-y)); %Mean square error for the test data is way higher
end

