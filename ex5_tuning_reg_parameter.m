clear all
clc

max_iteration_size = 200;
j  = -6 : 7; % from 10^?6 up to 10^3
% j = 10^-6 : 10^3; % for longer iterations
disp(numel(j))
% initialize things:
[mse_test_100, mse_test_10] = deal(zeros(max_iteration_size, numel(j)));
[mse_train_100, mse_train_10] = deal(zeros(max_iteration_size, numel(j)));
[mse_valid_100, mse_valid_10] = deal(zeros(max_iteration_size, numel(j)));

for idx = 1:numel(j)
    gamma=10^j(idx);
    for i=1:max_iteration_size
        %Size 100 training and 10 size training; Size 500 test 0.8-t 0.2-v;
        [mse_train_100(i,idx), mse_valid_100(i,idx), mse_test_100(i,idx)] = get_mean_square_error_with_split(100,500,gamma,0.8,0.2);
        [mse_train_10(i,idx), mse_valid_10(i,idx), mse_test_10(i,idx)] = get_mean_square_error_with_split(10,500,gamma,0.8,0.2);
    end   
end

% plotting graphs
figure
% create array with gamma values 10^-6, 10^-5 and so on..
for idx = 1:numel(j)
    gamma(idx)=10^j(idx);
end
disp(gamma)

% min gamma accross average errors of 200 iterations
% a)
mse_train_100_avr = mean(mse_train_100(:,:),1); %# average along dim 1, i.e. average all rows
mse_valid_100_avr = mean(mse_valid_100(:,:),1);
[min_valid_error,min_valid_error_index] = min(mse_valid_100_avr);
min_gamma = gamma(min_valid_error_index);
fprintf('100: min_gamma=%d min_valid_error=%d\n',min_gamma,min_valid_error);
mse_test_100_avr = mean(mse_test_100(:,:),1); 
semilogx(gamma, mse_train_100_avr, '--r', gamma, mse_valid_100_avr, 'b', gamma, mse_test_100_avr, 'g')

% b)
% mse_train_10_avr = mean(mse_train_10(:,:),1); 
% mse_valid_10_avr =  mean(mse_valid_10(:,:),1); 
% [min_valid_error_10,min_valid_error_index_10] = min(mse_valid_10_avr);
% min_gamma_10 = gamma(min_valid_error_index_10);
% fprintf('10: min_gamma=%d min_valid_error=%d\n',min_gamma_10,min_valid_error_10);
% mse_test_10_avr = mean(mse_test_10(:,:),1); 
% semilogx(gamma, mse_train_10_avr, '--r', gamma, mse_valid_10_avr, 'b', gamma, mse_test_10_avr, 'g')

% c) 
% average min gamma accross iterations
[gamma_100, gamma_10] = deal(zeros(max_iteration_size));
for i=1:max_iteration_size
    mse_valid_10_iter = mse_valid_10(i,:);
    [min_valid_error_iter_10, min_valid_error_iter_10_index] = min(mse_valid_10_iter);
    gamma_10(i)=gamma(min_valid_error_iter_10_index);
    
    mse_valid_100_iter = mse_valid_100(i,:);
    [min_valid_error_iter_100, min_valid_error_iter_100_index] = min(mse_valid_100_iter);
    gamma_100(i)=gamma(min_valid_error_iter_100_index);
end
gamma_10_avr = mean(gamma_10);
gamma_100_avr = mean(gamma_100);
fprintf('gamma_10_avr=%d\ngamma_100_avr=%d\n',gamma_10_avr,gamma_100_avr);

title('Question 5')
xlabel('gamma')
ylabel('mean square error')

