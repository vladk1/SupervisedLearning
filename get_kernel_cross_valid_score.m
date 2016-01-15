function [ mean_mse_train, mean_mse_valid ] = get_kernel_cross_valid_score(K, y, gamma )
    % 5 cross validation
    k = 5; 
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
    end
    mean_mse_train = mean(mse_train);
    mean_mse_valid = mean(mse_valid);
end

