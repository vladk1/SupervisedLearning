% Perform ridge regression on the data sets as generated in exercise 2 part a for ? ranging from 10?6
% up to 103
% , and all powers of 10 in between. What are the training and test mean squared errors? Plot
% the training and test set errors as a function of ? (use a log scale for the ? axis).
clear all
clc
% te is test set tr is training set
d=10; %Dimension
for i=1:2
itr=[100,10];  %Size 100 training and 10 size training 
ite=500;  %Size 500 test 
Xte=randn(ite,d);   %X is drawn from the standard normal distribution.
Xtr=randn(itr(i),d);   %X is drawn from the standard normal distribution.
nte=randn(ite,1);   %n is drawn from the standard normal distribution.
ntr=randn(itr(i),1);   %n is drawn from the standard normal distribution.
wte=randn(d,1); % weighted vector= random weight vector w ? R10
wtr=randn(d,1); % weighted vector= random weight vector w ? R10
ytr=Xtr*wtr+ntr; %Calculate y for training data
yte=Xte*wte+nte; %Calculate y for training data 
ltr=itr(i);
lte=ite;

% Need to use mldivide - but didn't make it to work!!
wtr_est = inv(Xtr'*Xtr)*Xtr'*ytr;  %Estimate w based on the training set.

% Using equation (3) compute the mean squared error on both the training
% and test sets.
mean_square_error_tr(i)=1/ltr*((Xtr*wtr_est-ytr)'*(Xtr*wtr_est-ytr));
mean_square_error_te(i) = 1/ltr*((Xte*wtr_est-yte)'*(Xte*wtr_est-yte)); %Mean square error for the test data is way higher
