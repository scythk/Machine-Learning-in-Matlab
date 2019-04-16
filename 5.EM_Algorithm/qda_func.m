% QDA algorithm
function errTe = qda_func(dataTr,dataTe)

C = 7;
% data pre-processing
colRem = [5,6];
clsRem = [6,9,10];
% clsRem = [7];
[dataTr,dataTe] = dataproc(dataTr,dataTe,colRem,clsRem); 
[~,dim] = size(dataTr);

[pi_c,mu_c,Sig_c]= deal(zeros(C,1),zeros(C,dim-1),cell(1,C));
% train
for c = 1:C
    dataQC = dataTr(dataTr(:,dim)==c,:);    % data belongs to class c
    x = dataQC(:,1:end-1);
    pi_c(c) = length(x)/length(dataTr);
    mu_c(c,:) = sum(x)/length(x);
    Sig_c{c} = (x'-mu_c(c,:)')*(x'-mu_c(c,:)')'/(length(x)-C);
end
% test
[xTe,yTe] = deal(dataTe(:,1:end-1),dataTe(:,end));
delta = zeros(length(dataTe),C);
for k = 1:C
    t1 = -1/2*log(max(det(eye(dim-1)),det(Sig_c{k})))+log(pi_c(k));
%     t1 = -1/2*log(det(eye(6)))+log(pi_c(k));
    t2 = -1/2*(xTe-mu_c(k,:))/Sig_c{k}*(xTe-mu_c(k,:))';
%     t2 = -1/2*(xTe-mu_c(k,:))*pinv(Sig_c{k})*(xTe-mu_c(k,:))';
    delta(:,k) = diag(t1+t2);
end
[~,yPre] = max(delta,[],2);
% numC = hist(dataQTr(:,end),(1:10)) % # in different classes
% P = confusionmat(yTe,yPre)./numC;
% sum(P,2)
errTe = sum((yPre-yTe)~=0)/length(yTe);
end