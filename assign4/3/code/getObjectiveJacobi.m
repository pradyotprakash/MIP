function [ Jacobi ] = getObjectiveJacobi(g,S0,b0,L)
%GETOBJECTIVEJACOBI return jacobi of function
[dim_x,~] = size(g);
Jacobi = zeros(dim_x,3);
for i=1:dim_x
    Jacobi(i,1) = b0*S0*exp(-b0*g(i,:)*(L*L')*g(i,:)')*2*g(i,1)*(L(1,1)*g(i,1) + L(2,1)*g(i,2));
    Jacobi(i,2) = b0*S0*exp(-b0*g(i,:)*(L*L')*g(i,:)')*2*g(i,2)*(L(1,1)*g(i,1) + L(2,1)*g(i,2));
    Jacobi(i,3) = b0*S0*exp(-b0*g(i,:)*(L*L')*g(i,:)')*2*g(i,2)*g(i,2)*L(2,2);
end
end
