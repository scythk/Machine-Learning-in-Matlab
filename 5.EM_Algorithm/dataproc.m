function [dataTrPre,dataTePre] = dataproc(dataTr,dataTe,colRem,clsRem)

% dataTr(:,[5,6])=[];dataTe(:,[5,6])=[];    % remove column 5&6
% [labTr,labTe] = deal(dataTr(:,end),dataTe(:,end));
% id = labTr==6|labTr==9|labTr==10;   % remove class 6,9,10, rename 8 to 6
% dataTr(id,:) = [];
% dataTr(dataTr(:,end)==8,end) = 6;
% id = labTe==6|labTe==9|labTe==10;
% dataTe(id,:) = [];
% dataTe(dataTe(:,end)==8,end) = 6;

% column remove
dataTr(:,colRem)=[];
dataTe(:,colRem)=[];

% class remove
for i = length(clsRem):-1:1
    % remove class
    dataTr(dataTr(:,end)==clsRem(i),:) = [];
    dataTe(dataTe(:,end)==clsRem(i),:) = [];
    % rearrange label
    dataTr(dataTr(:,end)>=clsRem(i),end) = dataTr(dataTr(:,end)>=clsRem(i),end)-1;
    dataTe(dataTe(:,end)>=clsRem(i),end) = dataTe(dataTe(:,end)>=clsRem(i),end)-1;
end
dataTrPre = dataTr;
dataTePre = dataTe;
end
