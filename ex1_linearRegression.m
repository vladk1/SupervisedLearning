% Least squares regression LSR
%a 
clear all
clc
% te is test set
% tr is training set
d=1; %Dimension
for i=1:2
itr=[100,10];  %Size 100 training and 10 size training 
ite=500;  %Size 500 test 
Xte=randn(ite,1);   %X is drawn from the standard normal distribution.
Xtr=randn(itr(i),1);   %X is drawn from the standard normal distribution.
nte=randn(ite,1);   %n is drawn from the standard normal distribution.
ntr=randn(itr(i),1);   %n is drawn from the standard normal distribution.
wte=randn(d,1); % weighted vector which is random value where w is element in Real number, one dimensional
wtr=randn(d,1); % weighted vector which is random value where w is element in Real number, one dimensional
ytr=Xtr*wtr+ntr; %Calculate y for training data
yte=Xte*wte+nte; %Calculate y for training data 
ltr=itr(i);
lte=ite;
% b
% Note that in the special case where xi ? R is one-dimensional, X is a column vector, and X?X is a scalar then w will also be a scalar.
%wtr_est = mldivide(Xtr',Xtr)*Xtr'*ytr;  %Estimate w based on the training set.

% Need to use mldivide - but didn't make it to work!! 
wtr_est = inv(Xtr'*Xtr)*Xtr'*ytr;  %Estimate w based on the training set.

% Using equation (3) compute the mean squared error on both the training and test sets.
mean_square_error_tr(i)=1/ltr*((Xtr*wtr_est-ytr)'*(Xtr*wtr_est-ytr));
mean_square_error_te(i) = 1/ltr*((Xte*wtr_est-yte)'*(Xte*wtr_est-yte)); %Mean square error for the test data is way higher


end
mean_square_error_te
mean_square_error_tr
%%
mean_square_error_tr=[];
mean_square_error_te=[];

% d
for i=1:2
for ii=1:200
    d=1; %Dimension

itr=[100,10];  %Size 100 training and 10 size training 
ite=500;  %Size 500 test 
Xte=randn(ite,d);   %X is drawn from the standard normal distribution.
Xtr=randn(itr(i),d);   %X is drawn from the standard normal distribution.
nte=randn(ite,1);   %n is drawn from the standard normal distribution.
ntr=randn(itr(i),1);   %n is drawn from the standard normal distribution.
wte=randn(d,1); % weighted vector which is random value where w is element in Real number, one dimensional
wtr=randn(d,1); % weighted vector which is random value where w is element in Real number, one dimensional
ytr=Xtr*wtr+ntr; %Calculate y for training data
yte=Xte*wte+nte; %Calculate y for training data 
ltr=itr(i);
lte=ite;
% b
% Note that in the special case where xi ? R is one-dimensional, X is a column vector, and X?X is a scalar then w will also be a scalar.
%wtr_est = mldivide(Xtr',Xtr)*Xtr'*ytr;  %Estimate w based on the training set.

% Need to use mldivide - but didn't make it to work!! 
wtr_est = inv(Xtr'*Xtr)*Xtr'*ytr;  %Estimate w based on the training set.

% Using equation (3) compute the mean squared error on both the training and test sets.
mean_square_error_tr(ii)=1/ltr*((Xtr*wtr_est-ytr)'*(Xtr*wtr_est-ytr));
mean_square_error_te(ii) = 1/ltr*((Xte*wtr_est-yte)'*(Xte*wtr_est-yte)); %Mean square error for the test data is way higher
end
mean_square_error_tr_200Sampling(i)=mean(mean_square_error_tr);
mean_square_error_te_200Sampling(i)=mean(mean_square_error_te) ;    
end

mean_square_error_200Sampling_100data_10data=[mean_square_error_tr_200Sampling;mean_square_error_te_200Sampling]

