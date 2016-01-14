function [ mean_mse_train, mean_mse_valid ] = get_kernel_cross_valid_score(K, y, gamma )

    k = 5; % 5 cross validation
    l_train = size(K, 1);  
    k_size = floor(l_train / k);
        
    for i = 1:k
        a = k_size*(i-1)+1; 
        b = i*k_size;
        K_train = K([1:a-1 b+1:l_train], [1:a-1 b+1:l_train]);
        y_train = y([1:a-1 b+1:l_train]);
        
        K_valid = K(a:b, [1:a-1 b+1:l_train]);
        y_valid = y(a:b);
        
        dual_w = kridgereg(K_train, y_train, gamma);
        
        mse_train(i) = dualcost(K_train, y_train, dual_w);          
        mse_valid(i) = dualcost(K_valid, y_valid, dual_w);
        
%         fprintf('k_size=%d\n',k_size)
%         fprintf('dual_w %d\n', size(dual_w,1))
%         fprintf('K_train %dx%d\n', size(K_train,1), size(K_train,2))
%         fprintf('y_train %d\n', size(y_train,1))
%         fprintf('K_valid %dx%d\n', size(K_valid,1), size(K_valid,2))
%         fprintf('y_valid %d\n', size(y_valid,1))
    end
    mean_mse_train = mean(mse_train);
    mean_mse_valid = mean(mse_valid);
end

