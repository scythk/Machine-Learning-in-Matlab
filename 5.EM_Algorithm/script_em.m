% EM algorithm & QDA algorithm
clc;clear;close all;

pathTr = '../DataSets/EM_train.txt';
pathTe = '../DataSets/EM_test.txt';
[dTr,dTe] = deal(load(pathTr),load(pathTe));
%% EM Algorithm
% data pre-processing, remove some atrributes with less data
colRem = [];
% clsRem = [];
% colRem = [5,6];
clsRem = [6,9,10];
[dataTr,dataTe] = dataproc(dTr,dTe,colRem,clsRem);
[dTrLength,dim] = size(dataTr);
[xTe,yTe] = deal(dataTe(:,1:end-1),dataTe(:,end));

ITER = 1000;
C = max(dataTr(:,end));
QMax = 10;
numClsTr = hist(dataTr(:,end),(1:C)); % # in each class
numClsTe = hist(dataTe(:,end),(1:C));
p_c = numClsTr/dTrLength;	% p(c)
p_xci = cell(C,dim-1);	% p(x|c)
P = cell(1,C); % confusion matrix
errEM = zeros(1,QMax);

for Q = 1:QMax
    % training
    for c = 1:C
        dataQC = dataTr(dataTr(:,dim)==c,:); % data belongs to class c
        cLength = length(dataQC);
        for i = 1:dim-1
            y = dataQC(:,i);
            [M,m] = deal(max(dataQC(:,i)),min(dataQC(:,i)));
            D = (M-m)/Q;
            % Initialization
            mu = (m+D/2)*ones(1,Q) + D*(0:(Q-1));	% mean
            sig = 1 * ones(1,Q);	% standard deviations
            w = 1/Q * ones(1,Q);	% weights
            Ni_yj = zeros(cLength,Q);
            p_yj = zeros(cLength,Q);
            for iter = 1:ITER
                % E
                t = (y - mu).^2;
                Ni_yj = 1./(sqrt(2*pi)*sig).*exp(-t./(2*sig.^2));	% N*Q
                p_yj = w*Ni_yj';        % 1*N
                pij = Ni_yj.*w./p_yj';	% N*Q
                
                % M
                mu = sum(pij.*y)./sum(pij);
                t2 = sqrt(sum(pij.*t)./sum(pij));
                sig = max(1e-4,sqrt(t2));    % make sure std>1e-4
                w = sum(pij)/sum(sum(pij));
            end
            for q = 1:Q
                fprintf('Class Number %d, Attribute Number %d, Gaussian Component %d, ',c,i,q);
                fprintf('Mean = %.2f, STDEV = %.2f\n',mu(q),sig(q));
            end
            p_xci{c,i} = [w;mu;sig];
        end
    end
    % testing
    M_y = zeros(dim-1,length(dataTe));
    p_xc = zeros(C,length(dataTe));
    for c = 1:C
        for i = 1:dim-1
            [w,mu,sig] = deal(p_xci{c,i}(1,:),p_xci{c,i}(2,:),p_xci{c,i}(3,:));
            t = (xTe(:,i) - mu).^2;
            N_y = 1./(sqrt(2*pi)*sig).*exp(-t./(2*sig.^2));	% N*Q
            M_y(i,:) = w*N_y';  % C*Q matrix, each column 
        end
        p_xc(c,:) = prod(M_y);  % p(x|c)=p(x1|c)p(x2|c)...p(x8|c)
    end
%     p_x = sum(p_xc'.*p_c,2);
%     p_cx = p_xc'.*p_c./p_x;
    p_cx = p_xc'.*p_c;
    [~,yPre] = max(p_cx,[],2);
    P{Q} = confusionmat(yTe,yPre)./numClsTe';
    errEM(Q) = sum((yPre-yTe)~=0)/length(yTe);
end
for Q = 1:QMax
    fprintf('The classification error of Q=%d is %f\n',Q,errEM(Q));
    fprintf('The confusion matrix of Q=%d is\n',Q);
    disp(P{Q});
end
%% QDA
errQDA = qda_func(dTr,dTe);
fprintf('The classification error of QDA is %f\n',errQDA);
%% Plot
figure
plot(1:10,errEM,'r-');hold on;
yline(errQDA,'b-');hold on;
xlabel('# of Gaussian components');ylabel('Classification Error');
title('EM Algorithm');legend('EM','QDA');ylim([0.35 0.85]);
grid on;
% 
% figure
% plot(dataTr(:,1),dataTr(:,2),'o');hold on;
% title('QDA Algorithm');
% grid on;
