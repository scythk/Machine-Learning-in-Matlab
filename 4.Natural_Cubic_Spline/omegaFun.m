% Calculate integration
function Omega = omegaFun(xi,K)

a = 6./(xi(K)-xi(1:K-1));
Omega = zeros(K,K);

% N33 = (a(1)^2/3)*((xi(3)-xi(1))^3+(xi(4)-xi(3))^3)+(a(3)^2/3)*(xi(4)-xi(3))^3+(-2*a(1)*a(3)*(1/3*(xi(4)^3-xi(3)^3)-1/2*(xi(4)^2-xi(3)^2)*(xi(1)+xi(3))+xi(1)*xi(3)*(xi(4)-xi(3))));
% N44 = (a(2)^2/3)*((xi(3)-xi(2))^3+(xi(4)-xi(3))^3)+(a(3)^2/3)*(xi(4)-xi(3))^3+(-2*a(2)*a(3)*(1/3*(xi(4)^3-xi(3)^3)-1/2*(xi(4)^2-xi(3)^2)*(xi(2)+xi(3))+xi(2)*xi(3)*(xi(4)-xi(3))));
% N34 = (a(1)*a(2)*(1/3*(xi(4)^3-xi(2)^3)-1/2*(xi(4)^2-xi(2)^2)*(xi(1)+xi(2))+xi(1)*xi(2)*(xi(4)-xi(2))))-...
%         (a(1)*a(3)*(1/3*(xi(4)^3-xi(3)^3)-1/2*(xi(4)^2-xi(3)^2)*(xi(1)+xi(3))+xi(1)*xi(3)*(xi(4)-xi(3))))-...
%         (a(3)*a(2)*(1/3*(xi(4)^3-xi(3)^3)-1/2*(xi(4)^2-xi(3)^2)*(xi(2)+xi(3))+xi(2)*xi(3)*(xi(4)-xi(3)))) + 12*(xi(4)-xi(3));
% N43 = N34;
% 
% Omega = [0 0 0 0;0 0 0 0;0 0 N33 N34;0 0 N43 N44];
% Omega = [0 0 0 0;0 0 0 0;0 0 3.17268656 1.78469244;0 0 1.78469244 1.18979496];

% Assume j>=i
for j = 3:K
    for i = 3:j
        % Integral from j-2 to K-1
        intUpper1 = a(i-2)*a(j-2)*(1/3*xi(K-1)^3 - 1/2*(xi(i-2)+xi(j-2))*xi(K-1)^2 + xi(i-2)*xi(j-2)*xi(K-1));
        intLower1 = a(i-2)*a(j-2)*(1/3*xi(j-2)^3 - 1/2*(xi(i-2)+xi(j-2))*xi(j-2)^2 + xi(i-2)*xi(j-2)*xi(j-2));
        int1 = intUpper1 - intLower1;
        
        % Integral from K-1 to K
        t11 = a(i-2)*a(j-2)*(1/3*xi(K)^3 - 1/2*(xi(i-2)+xi(j-2))*xi(K)^2 + xi(i-2)*xi(j-2)*xi(K));
        t12 = a(i-2)*a(K-1)*(1/3*xi(K)^3 - 1/2*(xi(i-2)+xi(K-1))*xi(K)^2 + xi(i-2)*xi(K-1)*xi(K));
        t13 = a(j-2)*a(K-1)*(1/3*xi(K)^3 - 1/2*(xi(j-2)+xi(K-1))*xi(K)^2 + xi(j-2)*xi(K-1)*xi(K));
        t14 = a(K-1)^2* 1/3 * (xi(K)-xi(K-1))^3;
        intUpper2 = t11-t12-t13+t14;
        
        t21 = a(i-2)*a(j-2)*(1/3*xi(K-1)^3 - 1/2*(xi(i-2)+xi(j-2))*xi(K-1)^2 + xi(i-2)*xi(j-2)*xi(K-1));
        t22 = a(i-2)*a(K-1)*(1/3*xi(K-1)^3 - 1/2*(xi(i-2)+xi(K-1))*xi(K-1)^2 + xi(i-2)*xi(K-1)*xi(K-1));
        t23 = a(j-2)*a(K-1)*(1/3*xi(K-1)^3 - 1/2*(xi(j-2)+xi(K-1))*xi(K-1)^2 + xi(j-2)*xi(K-1)*xi(K-1));
        t24 = 0;
        intLower2 = t21-t22-t23+t24;
        
        int2 = intUpper2 - intLower2;
        Omega(i,j) = int1+int2;
        Omega(j,i) = Omega(i,j);
    end
end

end