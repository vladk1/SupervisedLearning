clear all
clc
% For the data set of exercise 2 part a. Plot the cross-validation score on top of the training and test
% set errors for different values ? = {10^?6,10^?5,..,10^3} of the regularization parameter.
dim = 10;
max_iteration_size = 200;
j  = -6 : 3; % from 10^?6 up to 10^3
% j = 10^-6 : 10^3; % for longer iterations
% initialize things:

for idx = 1:numel(j)
    gamma(idx)=10^j(idx);
    for i=1:max_iteration_size
        [X_600, y_600]= generate_data(600, dim);
        X_test = X_600(1:500,:);
        y_test = y_600(1:500,:);
        X_train_100 = X_600(501:600,:);
        y_train_100 = y_600(501:600,:);
        %q4
        [mse_train_100_avr_q4(i), mse_test_100_avr_q4(i)] = get_mean_square_error(X_train_100,y_train_100,X_test,y_test,gamma(idx));
        %q5
        [mse_train_100_avr_q5(i), mse_valid_100_avr_q5(i), mse_test_100_avr_q5(i)] = get_mean_square_error_with_split(X_train_100,y_train_100,X_test,y_test,gamma(idx),0.8,0.2);
        %q6
        [mse_train_100_avr_q6(i), mse_valid_100_avr_q6(i), mse_test_100_avr_q6(i)] = get_cross_valid_score(X_train_100,y_train_100,X_test,y_test,gamma(idx)); 
        
        X_train_10 = X_600(501:510,:);
        y_train_10 = y_600(501:510,:);
        %q4
        [mse_train_10_avr_q4(i), mse_test_10_avr_q4(i)] = get_mean_square_error(X_train_10,y_train_10,X_test,y_test,gamma(idx));
        %q5
        [mse_train_10_avr_q5(i), mse_valid_10_avr_q5(i), mse_test_10_avr_q5(i)] = get_mean_square_error_with_split(X_train_10,y_train_10,X_test,y_test,gamma(idx),0.8,0.2);
        %q6
        [mse_train_10_avr_q6(i), mse_valid_10_avr_q6(i), mse_test_10_avr_q6(i)] = get_cross_valid_score(X_train_10,y_train_10,X_test,y_test,gamma(idx)); 
      
    end
    
     % Get mean
    mse_train_100_q4(idx) = mean(mse_train_100_avr_q4);
    mse_test_100_q4(idx) = mean(mse_test_100_avr_q4);
    mse_train_10_q4(idx) = mean(mse_train_10_avr_q4);
    mse_test_10_q4(idx) = mean(mse_test_10_avr_q4);
   

    [mse_train_100_q5(idx), mse_valid_100_q5(idx), mse_test_100_q5(idx)] = get_mean(mse_train_100_avr_q5, mse_valid_100_avr_q5, mse_test_100_avr_q5);
    [mse_train_10_q5(idx), mse_valid_10_q5(idx), mse_test_10_q5(idx)] = get_mean(mse_train_10_avr_q5, mse_valid_10_avr_q5, mse_test_10_avr_q5);
    
    [mse_train_100_q6(idx), mse_valid_100_q6(idx), mse_test_100_q6(idx)] = get_mean(mse_train_100_avr_q6, mse_valid_100_avr_q6, mse_test_100_avr_q6);
    [mse_train_10_q6(idx), mse_valid_10_q6(idx), mse_test_10_q6(idx)] = get_mean(mse_train_10_avr_q6, mse_valid_10_avr_q6, mse_test_10_avr_q6);
    
    %Get std
     std_test_10_q4(idx) = std(mse_test_10_avr_q4);
    std_train_10_q4(idx) = std(mse_train_10_avr_q4);
     std_test_100_q4(idx) = std(mse_test_100_avr_q4);
     std_train_100_q4(idx) = std(mse_train_100_avr_q4);
    
     [std_train_100_q5(idx), std_valid_100_q5(idx), std_test_100_q5(idx)] = get_std(mse_train_100_avr_q5, mse_valid_100_avr_q5, mse_test_100_avr_q5);
    [std_train_10_q5(idx), std_valid_10_q5(idx), std_test_10_q5(idx)] = get_std(mse_train_10_avr_q5, mse_valid_10_avr_q5, mse_test_10_avr_q5);
    
    [std_train_100_q6(idx), std_valid_100_q6(idx), std_test_100_q6(idx)] = get_std(mse_train_100_avr_q6, mse_valid_100_avr_q6, mse_test_100_avr_q6);
    [std_train_10_q6(idx), std_valid_10_q6(idx), std_test_10_q6(idx)] = get_std(mse_train_10_avr_q6, mse_valid_10_avr_q6, mse_test_10_avr_q6);
    
    
end

% q4
[min_valid_error_10_q4,ind_10_q4] = min(mse_train_10_q4);
min_gamma_10_q4 = gamma(ind_10_q4);
fprintf('q4 10: min gamma=%d train_error=%d valid_error=%d test_error=%d train_std=%d  test_std=%d  \n',min_gamma_10_q4, mse_train_10_q4(ind_10_q4), min_valid_error_10_q4, mse_test_10_q4(ind_10_q4),std_train_10_q4(ind_10_q4),std_test_10_q4(ind_10_q4));

% q5
[min_valid_error_10_q5,ind_10_q5] = min(mse_valid_10_q5);
min_gamma_10_q5 = gamma(ind_10_q5);
fprintf('q5 10: min gamma=%d train_error=%d valid_error=%d test_error=%d train_std=%d  test_std=%d  \n',min_gamma_10_q5, mse_train_10_q4(ind_10_q5), min_valid_error_10_q5, mse_test_10_q5(ind_10_q5), std_train_10_q5(ind_10_q5),std_test_10_q5(ind_10_q5));

% q6
[min_valid_error_10_q6,ind_10_q6] = min(mse_valid_10_q6);
min_gamma_10_q6 = gamma(ind_10_q6);
fprintf('q6 10: min gamma=%d train_error=%d valid_error=%d test_error=%d train_std=%d  test_std=%d \n',min_gamma_10_q6, mse_train_10_q4(ind_10_q6), min_valid_error_10_q6, mse_test_10_q6(ind_10_q6),std_train_10_q6(ind_10_q6),std_test_10_q6(ind_10_q6));


% q4
[min_valid_error_100_q4,ind_100_q4] = min(mean(mse_train_100_q4));
min_gamma_100_q4 = gamma(ind_100_q4);
fprintf('q4 100: min_gamma=%d train_error=%d min_valid_error=%d test_error=%d train_std=%d  test_std=%d \n',min_gamma_100_q4, mse_train_100_q4(ind_10_q4), min_valid_error_100_q4, mse_test_100_q4(ind_100_q4),std_train_100_q4(ind_100_q4),std_test_100_q4(ind_100_q4));

% q5
[min_valid_error_100_q5,ind_100_q5] = min(mean(mse_valid_100_q5));
min_gamma_100_q5 = gamma(ind_100_q5);
fprintf('q5 100: min_gamma=%d train_error=%d min_valid_error=%d test_error=%d train_std=%d  test_std=%d \n',min_gamma_100_q5, mse_train_100_q4(ind_10_q5), min_valid_error_100_q5, mse_test_100_q5(ind_100_q5), std_train_100_q5(ind_100_q5), std_test_100_q5(ind_100_q5));

% q6
[min_valid_error_100_q6,ind_100_q6] = min(mean(mse_valid_100_q6));
min_gamma_100_q6 = gamma(ind_100_q6);
fprintf('q6 100: min_gamma=%d train_error=%d min_valid_error=%d test_error=%d train_std=%d test_std=%d \n',min_gamma_100_q6, mse_train_100_q4(ind_100_q6), min_valid_error_100_q6, mse_test_100_q6(ind_100_q6), std_train_100_q6(ind_100_q6), std_test_100_q6(ind_100_q6));

