% Implement the perceptron algorithm
% These files consist of three columns of numbers separated by comma.
% The first two columns give the point coordinates in a 2-D space.
% The third column indicates the class label which here can either be +1, or -1.
clc;clear;close all;

ITER = 1000;
path1 = '../DataSets/Tr1.txt';
path2 = '../DataSets/Tr2.txt';
[data1,data2] = deal(load(path1),load(path2));
x1 = [data1(:,1:end-1),ones(length(data1),1)];
x2 = [data2(:,1:end-1),ones(length(data2),1)];
[y1,y2] = deal(data1(:,end),data2(:,end));
[w1,w2] = deal(zeros(3,1));

for iter = 1:ITER
    for i = 1:length(data1)
        if y1(i)*dot(w1,x1(i,:)) <= 0
            w1 = w1 + y1(i)*x1(i,:)';
        end
    end
    for i = 1:length(data2)
        if y2(i)*dot(w2,x2(i,:)) <= 0
            w2 = w2 + y2(i)*x2(i,:)';
        end
    end
end

[y_pre1,y_pre2] = deal(sign(w1'*x1'),sign(w2'*x2'));    % classification result

figure
plot(x1(y1<0,1),x1(y1<0,2),'r*');hold on;
plot(x1(y1>0,1),x1(y1>0,2),'b*');hold on;
plot(x1(y_pre1<0,1),x1(y_pre1<0,2),'ro');hold on;
plot(x1(y_pre1>0,1),x1(y_pre1>0,2),'bo');hold on;
refline(-w1(1)/w1(2),-w1(3)/w1(2)); % decision boundary
legend('Label -1','Label +1','Classified -1','Classified +1','Boundary');
title('Dataset 1');

figure
plot(x2(y2<0,1),x2(y2<0,2),'r*');hold on;
plot(x2(y2>0,1),x2(y2>0,2),'b*');hold on;
plot(x2(y_pre2<0,1),x2(y_pre2<0,2),'ro');hold on;
plot(x2(y_pre2>0,1),x2(y_pre2>0,2),'bo');hold on;
refline(-w2(1)/w2(2),-w2(3)/w2(2));
legend('Label -1','Label +1','Classified -1','Classified +1','Boundary');
title('Dataset 2');