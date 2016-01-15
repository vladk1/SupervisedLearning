clc
clear all
% Boston housing kernels
% look into more details http://www.cs.toronto.edu/~delve/data/boston/bostonDetail.html
boston_table=load('boston.mat');

j  = -40 : -26; % gamma from 10^-40 up to 10^-26   
jj = 7.0:.5:13.0; % sigma from 10^7,10^7.5 to 10^13

for i_runs = 1:20

    for epoch_for_cross_validation = 1:1
        bostonArray=boston_table.boston;
        sizeBoston=size(bostonArray,1);
        BostonArrayRand=bostonArray(randperm(sizeBoston),:); 
        X = BostonArrayRand(:, 1:13); 
        X_size = size(X,1);
        y = BostonArrayRand(:, 14); 

        for i = 1:numel(j)
            gamma(i) = 2^j(i);    
            for ii = 1:numel(jj)
                sigma(ii) = 2^jj(ii);   
                
                K = get_kernel(X, sigma(ii));
                train_size = floor(X_size*2/3);
                K_train = K(1:train_size, 1:train_size); 
                y_train = y(1:train_size);
                K_test = K(train_size+1:X_size, 1:train_size); 
                y_test = y(train_size+1:X_size);

                [mse_train_epoch(epoch_for_cross_validation, i, ii), mse_valid_epoch(epoch_for_cross_validation, i, ii)] = get_kernel_cross_valid_score(K_train, y_train, gamma(i));                     
            end
        end
    end
    mse_train = squeeze(mean(mse_train_epoch,1));
    mse_valid = squeeze(mean(mse_valid_epoch,1));

    [min_value, min_index] = min(mse_valid(:));
    [min_gamma_index, min_sigma_index] = ind2sub(size(mse_valid),min_index);
    
    best_gamma = gamma(min_gamma_index);
    best_sigma = sigma(min_sigma_index);
    
    train_size = floor(X_size*2/3);
    K_best = get_kernel(X, best_sigma);
    K_best_train = K_best(1:train_size, 1:train_size); 
    K_best_test = K_best(train_size+1:X_size, 1:train_size); 
    
    dual_w = kridgereg(K_best_train, y_train, best_gamma);
    mse_best_train(i_runs) = dualcost(K_best_train, y_train, dual_w); 
    mse_best_test(i_runs) = dualcost(K_best_test, y_test, dual_w);
    fprintf('Run: %d\n', i_runs)
    fprintf('best: gamma=%d sigma=%d\n', best_gamma, best_sigma)
    fprintf('best trainMSE=%d testMSE=%d\n\n',mse_best_train(i_runs),mse_best_test(i_runs))
end

% c) 3d plot of "cross-validation error" as a function of y and ? of the
% last run:
figure 
surf(log2(sigma), log2(gamma),log2(mse_valid))
xlabel('log scale of the sigma variance parameter')
ylabel('log scale of the gamma parameter')
zlabel('log scale of the mean cross-validation error')

figure 
surf(sigma, gamma,mse_valid)
xlabel('sigma variance parameter')
ylabel('gamma parameter')
zlabel('mean cross-validation error')

% d)
mse_mean_best_train_over20runs=mean(mse_best_train);
mse_mean_best_test_over20runs=mean(mse_best_test);

mse_std_best_train_over20runs=std(mse_best_train);
mse_std_best_test_over20runs=std(mse_best_test);

mse_best_train_20runs = [mse_mean_best_train_over20runs,mse_std_best_train_over20runs]
mse_best_test_20runs = [mse_mean_best_test_over20runs,mse_std_best_test_over20runs]

