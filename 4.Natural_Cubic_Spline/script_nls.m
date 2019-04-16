% Natural cubic spline fitting
clc;clear;close all;

pathTr = '../DataSets/NLS_train.txt';
lambd = 0:2:50; % curvature penalization term
EPE = zeros(1,length(lambd));   % Expected prediction error
% dataTr = sortrows(load(path_tr),1);
dTr = load(pathTr);
% Set knots
knot = 20;
% kIndex = knotFun(dataTr,knot);
% xi = dataTr(kIndex);
xi = knotFun(dTr,knot);
%%% function part

[dLength,~] = size(dTr);
[X,y]= deal(dTr(:,1),dTr(:,2));

% Calculate Omega
Omega = omegaFun(xi,knot);

%%% function part
for l = 1:length(lambd)
%     t = N'*N + lambd(l)*Omega;
%     theta = inv(t)*N'*y;
%     SLbd = N*inv(t)*N';
    
    [EPE(l),theta] = nls(dTr,lambd(l),xi,knot,Omega);
%     for i = 1:dLength
%         xS1 = X;xS1(i) = [];
%         yS1 = y;yS1(i) = [];
%         xCv = X(i);
%         % Calculate N
%         N = NFun(xS1,xi,knot);
%         
%         t = N'*N + lambd(l)*Omega;
%         theta = t\(N'*yS1);
%         SLbd = N*(t\N');
%         
%         % Cross-validation
%         NCv = NFun(xCv,xi,knot);
%         SCv = NCv*inv(NCv'*NCv+lambd(l)*Omega)*NCv';
%         err(i) = ((NCv*theta-y(i))/(1-SCv)).^2;
%     end
%     EPE(l) = mean(err);
end
[EPEMin,lMinIndex] = min(EPE);
N = NFun(X,xi,knot);
SMin = N*inv(N'*N + lambd(lMinIndex)*Omega)*N';
% DOF
dfLambd = trace(SMin);
fprintf('DOF of lambda=%d is %f\n',lambd(lMinIndex),dfLambd);

figure
plot(lambd,EPE);hold on;
plot(lambd(lMinIndex),EPEMin,'r*');hold on;
xlabel('\lambda');ylabel('Expected Prediction Error');
title('\lambda versus EPE');
grid on;

XTest = 0:0.01:1;
NTest = NFun(XTest',xi,knot);
yTest = NTest*theta;

% plot estimated function
figure
plot(dTr(:,1),dTr(:,2),'o');hold on;
plot(XTest,yTest,'-');hold on;
for i = 1:knot
    plot([xi(i) xi(i)],[-6 4],'linewidth',1);
end
title(['Estimated function for \lambda=',num2str(lambd(lMinIndex))]);
grid on;
