clc
clear all
% Boston housing kernels
% look into more details http://www.cs.toronto.edu/~delve/data/boston/bostonDetail.html
boston_table=load('boston.mat');

bostonArray=boston_table.boston;
sizeBoston=size(bostonArray,1);
BostonArrayRand=bostonArray(randperm(sizeBoston),:); % 506x14
X = BostonArrayRand(:, 1:13); % 506x13
y = BostonArrayRand(:, 14); % 506

j  = -40 : -26; % gamma from 10^-6 up to 10^3   -40 : -39;%
jj = 7.0:.5:13.0; % sigma from 10^7, 10^7.5 to 10^13   7.0:.5:8.0;%
for i = 1:numel(j)
    gamma(i) = 10^j(i);    
    for ii = 1:numel(jj)
        sigma(ii) = 10^jj(ii);      
        
        K = get_kernel(X, sigma(ii));
%         dim 
%         fprintf('K=%dx%d\n',size(K,1),size(K,2));
        
        kernel_size = size(K,1);
        train_size = floor(sizeBoston*2/3);
        K_train = K(1:train_size, 1:train_size); % 337x337
        y_train = y(1:train_size);
        K_test = K(train_size+1:kernel_size, 1:train_size); % 169x337
        y_test = y(train_size+1:sizeBoston);
        
%         dim  
%         fprintf('BostonArrayRand=%dx%d\n',size(X,1),size(X, 2));
%         fprintf('K_train=%dx%d K_test=%dx%d\n',size(K_train,1), size(K_train,2), size(K_test,1), size(K_test,2));
%         fprintf('y_train size=%d\n', size(y_train,1))
%         fprintf('y_test size=%d\n', size(y_test,1))
        
        [mse_train(i, ii), mse_valid(i, ii)] = get_kernel_cross_valid_score(K_train, y_train, gamma(i));                     
    end
end
disp(mse_valid)
[min_value, min_index] = min(mse_valid(:));
fprintf('min_index %d\n', min_index);
fprintf('min_value %d\n', min_value);

[min_gamma_index, min_sigma_index] = ind2sub(size(mse_valid),min_index);
fprintf('min_gamma_index %d\n', min_gamma_index);
fprintf('min_sigma_index %d\n', min_sigma_index);

best_gamma = gamma(min_gamma_index);
best_sigma = sigma(min_sigma_index);
% fprintf('min value %d\n', mse_valid(min_gamma_index, min_sigma_index));
fprintf('best gamma %d\n', best_gamma);
fprintf('best sigma %d\n', best_sigma);

K_best = get_kernel(X, best_sigma);
K_best_train = K_best(1:train_size, 1:train_size); 
K_best_test = K_best(train_size+1:kernel_size, 1:train_size); 
dual_w = kridgereg(K_train, y_train, best_gamma);
mse_best_train = dualcost(K_best_train, y_train, dual_w); 
mse_best_test = dualcost(K_best_test, y_test, dual_w);
fprintf('mse_best_test=%d\n',mse_best_test)


