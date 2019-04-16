function [train_e,test_e] = lin_reg(dataTr,dataTe,p,lambd)
    
    [N, dim] = size(dataTr);
    
%     beta = zeros((dim-1)*p+1,1);
    X = dataTr(:,1:(dim-1));
    y = dataTr(:,dim);
    
    X_p = [];
    for i = 1:p
        X_p = [X_p,X.^i];
    end
    X_p = [ones(N,1),X_p];
    
    t = X_p'*X_p + lambd*eye((dim-1)*p+1);
    beta = t\(X_p'*y);
%     beta = inv(t)*X_p'*y;
    
    train_e = (y - X_p*beta)' * (y - X_p*beta)/N;
    
    % Test
    X_te = dataTe(:,1:(dim-1));
    y_te = dataTe(:,dim);
    
    X_te_p = [];
    for i = 1:p
        X_te_p = [X_te_p,X_te.^i];
    end
    X_te_p = [ones(length(dataTe),1),X_te_p];
    
    test_e = (y_te - X_te_p*beta)' * (y_te - X_te_p*beta)/length(dataTe);

end

