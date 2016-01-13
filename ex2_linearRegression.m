% Least squares regression LSR
%a
clear all
clc
d=10; %Dimension

       [X_600, y_600]= generate_data(600, d);
        X_test = X_600(1:501,:);
        y_test = y_600(1:501,:);
        X_train_100 = X_600(501:600,:);
        y_train_100 = y_600(501:600,:);
        X_train_10 = X_600(501:510,:);
        y_train_10 = y_600(501:510,:);

% b) Note that in the special case where x_i is in R is one-dimensional, X
% is a column vector, and X'X is a scalar then w will also be a scalar.
wtr_est_100 = (X_train_100'*X_train_100) \ X_train_100'*y_train_100;  %Estimate w based on the training set.
wtr_est_10 = (X_train_10'*X_train_10) \ X_train_10'*y_train_10; 
% Using equation (3) compute the mean squared error on both the training
% and test sets.

mean_square_error_train_100= MSEfunction(100, X_train_100, wtr_est_100,y_train_100)
mean_square_error_test_100= MSEfunction(500, X_test, wtr_est_100,y_test)
mean_square_error_train_10= MSEfunction(10, X_train_10, wtr_est_10,y_train_10)
mean_square_error_test_10= MSEfunction(500, X_test, wtr_est_10,y_test)

%% d
clear all
d=10; %Dimension
for ii=1:200
       [X_600, y_600]= generate_data(600, d);
        X_test = X_600(1:501,:);
        y_test = y_600(1:501,:);
        X_train_100 = X_600(501:600,:);
        y_train_100 = y_600(501:600,:);
        X_train_10 = X_600(501:510,:);
        y_train_10 = y_600(501:510,:);

% b) Note that in the special case where x_i is in R is one-dimensional, X
% is a column vector, and X'X is a scalar then w will also be a scalar.
wtr_est_100 = (X_train_100'*X_train_100) \ X_train_100'*y_train_100;  %Estimate w based on the training set.
wtr_est_10 = (X_train_10'*X_train_10) \ X_train_10'*y_train_10; 
% Using equation (3) compute the mean squared error on both the training
% and test sets.

mean_square_error_train_100(ii)= MSEfunction(100, X_train_100, wtr_est_100,y_train_100);
mean_square_error_test_100(ii)= MSEfunction(500, X_test, wtr_est_100,y_test);
mean_square_error_train_10(ii)= MSEfunction(10, X_train_10, wtr_est_10,y_train_10);
mean_square_error_test_10(ii)= MSEfunction(500, X_test, wtr_est_10,y_test);
end


mean_square_error_train_100_200sampling=mean(mean_square_error_train_100)
mean_square_error_test_100_200sampling=mean(mean_square_error_test_100)
mean_square_error_train_10_200sampling=mean(mean_square_error_train_10)
mean_square_error_test_10_200Sampling=mean(mean_square_error_test_10)

allData=[mean_square_error_train_100_200sampling,mean_square_error_test_100_200sampling;mean_square_error_train_10_200sampling,mean_square_error_test_10_200Sampling]
