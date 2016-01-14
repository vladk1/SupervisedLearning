clc
clear all
% Boston housing kernels
% look into more details http://www.cs.toronto.edu/~delve/data/boston/bostonDetail.html
boston_table=load('boston.mat');

bostonArray=boston_table.boston;


j  = -40 : -26; % from 10^-6 up to 10^3
jj = 7 : 13;

for i = 1:numel(j)
    gamma(i) = 10^j(i);
    
    for ii = 1:numel(jj)
        sigma = 10^jj(ii);
        
        sizeBoston=size(bostonArray,1);
        BostonArrayRand=bostonArray(randperm(sizeBoston),:);

        K = get_kernel(BostonArrayRand, sigma);
        fprintf('size(K,1)=%d\n',size(K,1));
        kernel_size = size(K,1);
        train_size = floor(sizeBoston*2/3);
        K_train = K(1:train_size, 1:train_size);
        K_test = K(train_size+1:kernel_size, 1:train_size);
        
        fprintf('K_train=%dx%d K_test=%dx%d\n',size(K_train,1), size(K_train,2), size(K_test,1), size(K_test,2));
%         K_train = get_kernel(TestBoston, TrainingBoston, sigma);
%         K_test = get_kernel(TestBoston, TestBoston, sigma);
%         
%         dual_w = kridgereg(K,y,gamma); 
%         
%         mse = dualcost(K,y,dual_w);
        
    end
end