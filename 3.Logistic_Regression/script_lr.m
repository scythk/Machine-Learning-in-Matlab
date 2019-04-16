% Logistic Regression
clc;clear;close all;

pathTr = '../DataSets/USPS_train.txt';	% USPS handwritten digits dataset
pathTe = '../DataSets/USPS_test.txt';
% pathTr = '../DataSet/Hyper_train.txt';	% Hyperspectral pixels
% pathTe = '../DataSet/Hyper_test.txt';
dTr = load(pathTr);
dTe = load(pathTe);

train_ratio = [0.25,0.5,0.75,1];
polynomial = 1:2;
[errTr,errTE] = deal(zeros(length(train_ratio),length(polynomial)));

for d = polynomial
    [errTr(:,d),errTE(:,d)] = log_reg(dTr,dTe,d,train_ratio);
end

figure
plot(train_ratio,errTr(:,polynomial(1)),'ro-');hold on;
plot(train_ratio,errTE(:,polynomial(1)),'r*-');hold on;
plot(train_ratio,errTr(:,polynomial(2)),'bo-');hold on;
plot(train_ratio,errTE(:,polynomial(2)),'b*-');hold on;
legend('Training error d=1','Testing error d=1','Training error d=2','Testing error d=2');
xlabel('Ratio of training data used');ylabel('Classification probability');
title('USPS handwritten digits');
% title('Hyperspectral pixels');
grid on;
