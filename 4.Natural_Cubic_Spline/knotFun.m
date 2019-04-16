% find the index of k knots
function kIndex = knotFun(data,K)
    kIndex = zeros(1,K);
    data = sortrows(data,1);
    [dataMax,dataMin] = deal(max(data(:,1)),min(data(:,1)));
    interval = (dataMax-dataMin)/(K+1);
    for i = 1:K
        [~,kIndex(i)] = min(abs(data(:,1)-(dataMin+i*interval)));
    end
    kIndex = data(kIndex);
end

