% Linear Regression
clc;clear;close all;

pathTr = '../DataSets/MPG_train.txt';
pathTe = '../DataSets/MPG_test.txt';
[dTr,dTe] = deal(load(pathTr),load(pathTe));

lambd = [0,1,5];
polynomial = 1:10;
train_e = zeros(length(polynomial),length(lambd));
test_e = zeros(length(polynomial),length(lambd));

for l = 1:length(lambd)
    for p = polynomial
        [train_e(p,l),test_e(p,l)] = lin_reg(dTr,dTe,p,lambd(l));
    end
end

figure
subplot(3,1,1)
plot(polynomial,train_e(:,1),'r*-');hold on;
plot(polynomial,test_e(:,1),'bo-');hold on;
legend('Training error','Testing error');
xlabel('polynomial');ylabel('RSS');title(['lambda = ',num2str(lambd(1))]);
subplot(3,1,2)
plot(polynomial,train_e(:,2),'r*-');hold on;
plot(polynomial,test_e(:,2),'bo-');hold on;
legend('Training error','Testing error');
xlabel('polynomial');ylabel('RSS');title(['lambda = ',num2str(lambd(2))]);
subplot(3,1,3)
plot(polynomial,train_e(:,3),'r*-');hold on;
plot(polynomial,test_e(:,3),'bo-');hold on;
legend('Training error','Testing error');
xlabel('polynomial');ylabel('RSS');title(['lambda = ',num2str(lambd(3))]);
