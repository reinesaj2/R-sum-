function [t,w] = euler(f,a,b,n,alpha)
% Approximate y'=f(t,y) on [a,b] with n intervals using Euler's method
h = (b-a)/n; t = linspace(a,b,n+1);
w = zeros(1,n+1); w(1) = alpha;
for i = 1:n
    w(i+1) = w(i) + h*f(t(i),w(i));
end