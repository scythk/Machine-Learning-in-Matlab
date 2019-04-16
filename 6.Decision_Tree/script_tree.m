% Build a binary tree for classification
clc;clear;close all;

pathTr = '../DataSets/USPS_train.txt';
pathTe = '../DataSets/USPS_test.txt';

[dTr,dTe] = deal(load(pathTr),load(pathTe));
numCls = numel(unique(dTr(:,end)));
global node;
global n;
node = [];	% [nodeID,featureID,splitvalue,#ofdata,leafclass,lchild,rchild]
n = 0;      % # of nodes created
nID = 1;    % node ID; The nID of node n's lchild and rchild is 2n, 2n+1
% numSplit = 50;
numSplit = [2,5,10,20,50];
acc = zeros(1,length(numSplit));
for q = 1:length(numSplit)
    %% train
    root = createBT(nID,dTr,numSplit(q));	% root node
    leaf = node(node(:,5)~=-1,:);	% leaf node
    % save('node.mat');
    % load('node.mat');

    %% test
    [xTe,yTe] = deal(dTe(:,1:end-1),dTe(:,end));
    yPre = zeros(1,length(dTe))';
    for i = 1:length(dTe)
        nn = root;  % start from root node
        % find leaf
        while(node(nn,5)<0) % continue until reach leaf
            if(xTe(i,node(nn,2))<=node(nn,3))
                nn = node(nn,6);	% go left
            else
                nn = node(nn,7);	% go right
            end
        end
        yPre(i) = node(nn,5);
        fprintf('object ID:%d; predicted:%d; true:%d\n',i,yPre(i),yTe(i));
    end
    acc(q) = sum((yPre-yTe)==0)/length(yTe);
    fprintf('The classification accuracy is %f\n',acc(q));
end
figure
plot(numSplit,acc,'r-');hold on;
xlabel('number of split points');
ylabel('classification accuracy');
grid on;

% load splat;
% sound(y,Fs);