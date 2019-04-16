% Neural Network
clc;clear;close all;

% input arguement
pathTr = '../DataSets/USPS_train.txt';
pathTe = '../DataSets/USPS_test.txt';
[dTr,dTe] = deal(load(pathTr),load(pathTe));
L = 5;	% # of layers
numH = [5,5,5];	% # of nodes in each hidden layer
ITER = 300;

% normalizing
kMaxTr = [max(dTr(:,1:end-1)),1];
kMaxTe = [max(dTe(:,1:end-1)),1];
[dTrP,dTeP] = deal(dTr./kMaxTr,dTe./kMaxTe);

% initializing
[x,y] = deal(dTrP(:,1:end-1),dTrP(:,end));
[xTe,yTe] = deal(dTeP(:,1:end-1),dTeP(:,end));
[NTr,D] = size(x);	% length and dimension of data
[NTe,~] = size(xTe);
K = numel(unique(y));
[mseTr,mseTe] = deal(zeros(1,ITER));

numL = [D+1,numH+1,K+1];	% Add bias node to each layer
% U = sum(numL);	% Input+hidden+output
[z,a,delta]= deal(cell(1,L));
t = full(ind2vec(y'+1));    % target vector
tTe = full(ind2vec(yTe'+1));

w = cell(1,L);  % weight matrix
for l = 1:L-1
    w{l} = -0.05+0.1*rand(numL(l+1),numL(l));
end

% plot
figure;hold on;grid on;
xlabel('Number of iteration');ylabel('Mean square error');
% hwait = waitbar(0,'Please wait');
for r = 1:ITER
%     waitbar(r/ITER,hwait,['iter=',num2str(r)]);
    %% train
    eta = 0.98^(r-1);  % step size
    se = zeros(1,NTr);
    for n = 1:NTr
        % forward
        z{1} = [1;x(n,:)'];  % output of 1st layer
        for l = 2:L
            a{l} = w{l-1}*z{l-1};       % input to layer l
            z{l} = 1./(1+exp(-a{l}));	% output of layer l
            z{l}(1) = 1;	% the output of bias node is always 1
        end
        % backward
        delta{L} = (z{L}-[1;t(:,n)]).*z{L}.*(1-z{L});   % output layer
        for l = L-1:-1:2
            delta{l} = (w{l}'*delta{l+1}).*z{l}.*(1-z{l});
        end
        for l = 2:L
            w{l-1} = w{l-1} - eta*delta{l}*z{l-1}';
        end
        se(n) = sum((z{L}-[1;t(:,n)]).^2);
    end
    mseTr(r) = sum(se)/NTr;
    %% test
    yPre = zeros(NTe,1);
    for n = 1:NTe
        zTe = [1;xTe(n,:)'];
        for l = 2:1:L
            aTe = w{l-1}*zTe;       % input to layer l
            zTe = 1./(1+exp(-aTe));	% output of layer l
            zTe(1) = 1;	% the output of bias node is always 1
        end
        se(n) = sum((zTe-[1;tTe(:,n)]).^2);
        [~,yP] = max(zTe(2:end));
        yPre(n) = yP-1;
        if r == ITER
            fprintf('object ID:%d; predicted:%d; true:%d\n',n,yPre(n),yTe(n));
        end
    end
    mseTe(r) = sum(se)/NTe;
    plot(r,mseTr(r),'r.','MarkerSize',10);drawnow;
    plot(r,mseTe(r),'b.','MarkerSize',10);drawnow;
    acc = sum((yPre-yTe)==0)/NTe;
end
legend('train','test');
fprintf('The classification accuracy is %f\n',acc);
% close(hwait);
