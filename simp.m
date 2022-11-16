function out = simp(f,a,b,n)
% Approximate int_a^b f(x) dx with n slices using Simpson's rule

if mod(n,2) ~= 0, error('Even number of intervals'); end
h = (b-a)/n; t2 = 0; t3=0;
t1 = f(a)+f(b);
for i=1:n/2-1, t2 = t2+f(a+2*i*h); end
for i=1:n/2, t3 = t3+f(a+(2*i-1)*h); end
out = (h/3)*(t1+2*t2+4*t3);