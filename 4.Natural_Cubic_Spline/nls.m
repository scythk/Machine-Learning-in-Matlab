function [EPE,theta] = nls(dataTr,lambd,xi,K,Omega)
    for i = 1:length(dataTr)
        xS1 = dataTr(:,1);xS1(i) = [];
        yS1 = dataTr(:,2);yS1(i) = [];
        xCv = dataTr(i,1);
        yCv = dataTr(i,2);
        % Calculate N
        N = NFun(xS1,xi,K);
        
        t = N'*N + lambd*Omega;
        theta = t\(N'*yS1);
        SLbd = N*(t\N');
        
        % Cross-validation
        NCv = NFun(xCv,xi,K);
        SCv = NCv*inv(NCv'*NCv+lambd*Omega)*NCv';
        EPE = ((NCv*theta-yCv)).^2;
    end

end

