function [train_e,test_e] = log_reg(dataTr,dataTe,d,train_ratio)
    iTerMax = 1e3;
    
    [train_e,test_e] = deal(zeros(length(train_ratio),1));
    for r = 1:length(train_ratio)
        trainNum = floor(train_ratio(r)*length(dataTr));
        % Randomly choose training data
        choose = randperm(length(dataTr));
        dataUsed = dataTr(choose(1:trainNum),:);
        % Choose the first r data
%         data_used = dataTr(1:train_num,:);

        [N,K] = size(dataUsed);
        [X,y] = deal(dataUsed(:,1:(K-1)),dataUsed(:,K));

        % Pre-processing
        X_t = [];
        for i = 1:d
            X_t = [X_t;X.^i];
        end
        X = [ones(N,1),reshape(X_t,[N d*(K-1)])];   % 1,x1,x1^2,...,xp,xp^2.
        y(y~=1) = 0;    % Set classes other than 1 to 0
%         y(y~=3) = 0;
%         y(y==3) = 1;
        % Newton-Raphson
        b_old = zeros(d*(K-1)+1,1);
        i = 0;

        while i<iTerMax

            p = (exp(b_old'*X')./(1+exp(b_old'*X')))';
            W = diag(p.*(1-p));
            z = X * b_old + W\(y-p);
            t = X'*W*X;
            b_new = t\(X'*W*z);
            if norm(b_new-b_old)<1e-3
                break
            end
            b_old = b_new;
            i = i+1;
        end
        
        % Training error
        p1 = (exp(b_new'*X')./(1+exp(b_new'*X')))';
        yPre = p1./(1-p1);
        yPre(yPre>1) = 1;
        yPre(yPre<1) = 0;

        train_e(r) = sum(abs(y-yPre))/length(y);

        % Testing
        [N_te,K_te] = size(dataTe);
        X = dataTe(:,1:(K_te-1));
        yTe = dataTe(:,K_te);
        
        X_t = [];
        for i = 1:d
            X_t = [X_t;X.^i];
        end
        X = [ones(N_te,1),reshape(X_t,[N_te d*(K_te-1)])];   % 1,x1,x1^2,...,xp,xp^2.
        yTe(yTe~=1) = 0;    % Set classes other than 1 to 0=

        p1Te = (exp(b_new'*X')./(1+exp(b_new'*X')))';
        yTePre = p1Te./(1-p1Te);
        yTePre(yTePre>1) = 1;
        yTePre(yTePre<1) = 0;

        test_e(r) = sum(abs(yTe-yTePre))/length(yTe);

    end
end

