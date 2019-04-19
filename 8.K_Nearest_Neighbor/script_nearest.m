% K Nearest Neighbor
clc;clear;close all;

% input arguement
pathTr = '../DataSets/USPS_train.txt';
pathTe = '../DataSets/USPS_test.txt';
K = 1:2:20;	% k-nearest neighbor

[dTr,dTe] = deal(load(pathTr),load(pathTe));
[x,y] = deal(dTr(:,1:end-1),dTr(:,end));
[xTe,yTe] = deal(dTe(:,1:end-1),dTe(:,end));
% pre-processing
xhat = (x-mean(x))./std(x);
xTehat = (xTe-mean(xTe))./std(xTe);

[accEucl,accManh] = deal(zeros(length(K),1));
[yPreEucl,yPreManh] = deal(zeros(length(xTe),1));
% testing
for k = 1:length(K)
    for i = 1:length(xTehat)
        dEucl = sqrt(sum((xTehat(i,:)-xhat).^2,2));	% Euclidean distance
        dManh = sum(abs(xTehat(i,:)-xhat),2);       % Manhattan distance
        [~,kIndEucl] = mink(dEucl,K(k));    % k smallest elements
        [~,kIndManh] = mink(dManh,K(k));
        yPreEucl(i) = mode(y(kIndEucl));    % Most frequent value
        yPreManh(i) = mode(y(kIndManh));
        fprintf('object ID:%d; Euclidean:%d, Manhattan:%d; true:%d\n',i,yPreEucl(i),yPreManh(i),yTe(i));
    end
    accEucl(k) = sum((yPreEucl-yTe)==0)/length(xTe);
    accManh(k) = sum((yPreManh-yTe)==0)/length(xTe);
    fprintf('The accuracy of Euclidean is %f\nThe accuracy of Manhattan is %f\n',accEucl(k),accManh(k));
end
% plot
figure
plot(K,accEucl,'ro-');hold on;
plot(K,accManh,'b*-');hold on;
grid on;
xlabel('K-Nearest-Neighbor');ylabel('Testing accuracy');
legend('Euclidean','Manhattan');