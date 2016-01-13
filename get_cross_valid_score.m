function [ mse_train, mse_valid, mse_test] = get_cross_valid_score( X_train, y_train, X_test, y_test, gamma )
    %5-fold cross validation 
    k = 5;
    d = size(X_train, 2); %Dimension
    I = eye(d); % Identity matrix

    l_test = size(X_test, 1);
    l_train = size(X_train, 1);
    l_valid = l_train / k;
    
%     fprintf('size(X_test,1)=%d\n',size(X_test,1));
    
%     wtr_est = (X_train'*X_train + gamma*l_train*I) \ X_train'*y_train;
%     mse_train = get_mse(X_train, y_train, l_train, wtr_est);
%     mse_test = get_mse(X_test, y_test, l_test, wtr_est);
   
    for i = 1:k
        a = l_valid*(i-1)+1; 
        b = i*l_valid;

        X_valid = X_train(a:b,:);
        y_valid = y_train(a:b,:);
%         fprintf('size(X_valid,1)=%d\n',size(X_valid,1));

        X_train_i = X_train([1:a-1 b+1:l_train],:);        
        y_train_i = y_train([1:a-1 b+1:l_train],:);
%         fprintf('size(X_train_i,1)=%d\n',size(X_train_i,1));
        l_train_i = l_train - l_valid;
        
        wtr_est_i = ((X_train_i' * X_train_i) + (gamma*l_train_i*I)) \ (X_train_i'*y_train_i);
       
        mse_valid_i(i) = get_mse(X_valid, y_valid, l_valid, wtr_est_i); 
        mse_train_i(i) = get_mse(X_train, y_train, l_train, wtr_est_i); 
        mse_test_i(i) = get_mse(X_test, y_test, l_test, wtr_est_i); 
    end
    
    mse_valid = mean(mse_valid_i);
    mse_train = mean(mse_train_i);
    mse_test = mean(mse_test_i);
end


function mse = get_mse(X, Y, len, w)
    mse = (1.0/len) * (w' * (X)' * X * w - 2 * Y' * X * w + Y' * Y);
end

