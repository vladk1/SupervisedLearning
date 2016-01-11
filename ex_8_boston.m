clc
clear all
% Boston housing kernels
% look into more details http://www.cs.toronto.edu/~delve/data/boston/bostonDetail.html
boston_table=load('boston.mat');

bostonArray=boston_table.boston;
% The training set should be 2/3, and the test set should be 1/3, of your 
% data in (a)-(c). In the following average your results over 20 runs
% (each run based on a different (2/3,1/3) random split).

%Inital variables in example 1
bTraining_ex1=[];mse_train_ex1=[];mse_test_ex1=[];
%Inital variables in example 2
B_ex2=[];mse_train_ex2=[];mse_test_ex2=[]; 
%Inital variables in example 3
B_ex3=[];mse_train_ex3=[];mse_test_ex3=[];

for i_runs=1:20
    
sizeBoston=size(bostonArray,1);
BostonArrayRand=bostonArray(randperm(sizeBoston),:);
TestBoston=BostonArrayRand(1:floor(sizeBoston*2/3),:);
TrainingBoston=BostonArrayRand(floor(sizeBoston*2/3):sizeBoston,:);
sizeTraining=size(TrainingBoston,1);
sizeTest=size(TestBoston,1);


% Create a vector of ones that is the same length as the training set using the function ones. 
onesTest=ones(sizeTest,1);
onesTraining=ones(sizeTraining,1);
y_train=TrainingBoston(:,14); %True y.
y_test=TestBoston(:,14);

% Naive Regression. 
% By using ones vectors we will be learning the simple equation y_hat = b. 
% Perform linear regression on the training set. Calculate the MSE on the
% training and test sets and note down the results.
% b1 = x\y
%bTest=onesTest\TestBoston(:,14)
bTraining_ex1(i_runs)=onesTraining\TrainingBoston(:,14);  %wtr_est by using b1 = x\y
mse_train_ex1(i_runs)=MSEfunction(sizeTraining, onesTraining, bTraining_ex1(i_runs), TrainingBoston(:,14));
mse_test_ex1(i_runs)=MSEfunction(sizeTest, onesTest, bTraining_ex1(i_runs), TestBoston(:,14));

%  Predicting with a single attribute and a bias term.
% Linear Regression with single attributes. For each of the thirteen 
% attributes, perform a linear regression using only the single attribute
% but incorporating a bias term so that the inputs are augmented 
% with an additional 1 entry, (xi , 1), so that we learn a weight 
% vector w is element in  R^2


for i=1:13
x_train= cat(2,ones(sizeTraining,1) , TrainingBoston(:,i)); %cat(2,A,B) is the same as [A,B]
x_test= cat(2,ones(sizeTest,1) , TestBoston(:,i));
B_ex2(i,:)=x_train\y_train; %Linear regression with single attribute and bias term.
mse_train_ex2(i_runs,i)=MSEfunction(sizeTraining, x_train, B_ex2(i,:)', y_train);
mse_test_ex2(i_runs,i)=MSEfunction(sizeTest,  x_test, B_ex2(i,:)', y_test);
end

% mse_train_ex2
% mse_test_ex2

  
% Linear Regression using all attributes. Now we would like to perform
% linear regression using all of the data attributes at once. Perform
% linear regression on the training set using this regressor, and
% incorporate a bias term as above. Calculate the MSE on the training and
% test sets and note down the results. You should find that this method
% outperforms any of the individual regressors.

x_train_ex3= cat(2,ones(sizeTraining,1) , TrainingBoston(:,1:13)); %cat(2,A,B) is the same as [A,B]
x_test_ex3= cat(2,ones(sizeTest,1) , TestBoston(:,1:13));
B_ex3(:,i_runs)=x_train_ex3\y_train; %Linear regression with single attribute and bias term.
mse_train_ex3(i_runs)=MSEfunction(sizeTraining, x_train_ex3, B_ex3(:,i_runs), y_train);
mse_test_ex3(i_runs)=MSEfunction(sizeTest,  x_test_ex3, B_ex3(:,i_runs), y_test);


end

%Ex 1
avg_Btrain_ex1=mean(bTraining_ex1)
avg_mse_train_ex1=mean(mse_train_ex1)
avg_mse_train_ex1=mean(mse_test_ex1)

%Ex 2
avg_mse_train_ex2=mean(mse_train_ex2)
avg_mse_test_ex2=mean(mse_test_ex2)

%Ex 3
avg_Btrain_ex3=mean(B_ex3,2)
avg_mse_train_ex3=mean(mse_train_ex3)
avg_mse_test_ex3=mean(mse_test_ex3)

