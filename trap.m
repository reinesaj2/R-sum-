function out = trap(f,a,b,n)
% Approximate integral a to b using trap rule with n intervals

out = (f(a)+f(b))/2; h = (b-a)/n;
for i = 1:n-1
    out = out+f(a+i*h);
end
out = out*h;
end