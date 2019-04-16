function cID = createBT(nID,data,numSplit)
global node;	% [nodeID,featureID,splitvalue,#ofdata,leafclass,lchild,rchild]
global n;
[x,y] = deal(data(:,1:end-1),data(:,end));
[dLen,attr] = size(x);

% if not a leaf node
if(dLen>5)
    [dMax,dMin] = deal(max(x),min(x));
    inc = bsxfun(@times,(dMax-dMin)/(numSplit+1),(1:numSplit)');
    spl =  bsxfun(@plus,inc,dMin);      % split/attr matrix
    misclsErr = zeros(numSplit,attr);   % misclassification error matrix
    for j = 1:attr
        for s = 1:numSplit
            [yj1,yj2] = deal(y(x(:,j)<=spl(s,j)),y(x(:,j)>spl(s,j)));   
            [p_mk1,~] = max(hist(yj1,(0:9))/length(yj1));	%#ok
            [p_mk2,~] = max(hist(yj2,(0:9))/length(yj2));	%#ok
%             p_mk1 = mode(yj1)/length(yj1);
%             p_mk2 = mode(yj2)/length(yj2);
            misclsErr(s,j) = (1-p_mk1)+(1-p_mk2);
%             misclsErr(s,j) = length(yj1)/dLen*(1-p_mk1)+length(yj2)/dLen*(1-p_mk2);
        end
    end
    % find minimum
    [spMin,attrMin] = find(misclsErr==min(min(misclsErr)));	% might has multiple minimum
    % split data
    dataL = data(x(:,attrMin(1))<=spl(spMin(1),attrMin(1)),:);
    dataR = data(x(:,attrMin(1))>spl(spMin(1),attrMin(1)),:);
    lchild = createBT(2*nID,dataL,numSplit);  % left child index
    rchild = createBT(2*nID+1,dataR,numSplit);	% right child index
    n = n+1;
    cID = n;
    nodeNew = [nID,attrMin(1),spl(spMin(1),attrMin(1)),dLen,-1,lchild,rchild];
    node = [node;nodeNew];
    fprintf('node ID:%d; feature ID: %d; splitting value: %2f\n',node(n,1),node(n,2),node(n,3));
% if it's a leaf node
else
    % find dominant class
    [~,domCls] = max(hist(y,(0:9)));    %#ok
    nodeNew = [nID,-1,-1,dLen,domCls-1,-1,-1];    % class starts from 0
    n = n+1;
    cID = n;
    node = [node;nodeNew];
    fprintf('node ID:%d; feature ID: %d; splitting value: %d\n',node(n,1),node(n,2),node(n,3));
end
end

