% Calculate N matrix
function N = NFun(X,xi,K)
    % d1 = (max((X-xi(1).^3),0)-max((X-xi(4).^3),0))/(xi(4)-xi(1));
    % d2 = (max((X-xi(2).^3),0)-max((X-xi(4).^3),0))/(xi(4)-xi(2));
    % d3 = (max((X-xi(3).^3),0)-max((X-xi(4).^3),0))/(xi(4)-xi(3));
    % [N1,N2,N3,N4] = deal(ones(length(X),1),X,d1-d3,d2-d3);
    % N = [N1,N2,N3,N4];

    % Extended to K knot points
    d = zeros(length(X),K-1);
    N = [ones(length(X),1),X];
    for i = 1:K-1
        d(:,i) = (max((X-xi(i).^3),0)-max((X-xi(K).^3),0))/(xi(K)-xi(i));
    end
    for i = 3:K
        Ni = d(:,i-2) - d(:,K-1);
        N = [N,Ni];
    end

end