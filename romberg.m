function r = romberg(f,a,b,n)
% Approximate int_a^b f(x) dx using n levels of Romberg integration
r = zeros(n,n);
h = b-a; r(1,1) = (h/2)*(f(a)+f(b));
for i = 2:n % row number
    s = 0; % hold sum of new function evaluations
    for j = 1:2^(i-2)
        s = s+f(a+(i-1/2)*h);
    end
    r(i,1) = (1/2)*(r(i-1,1)+h*s);
    for j = 2:i
        r(i,j) = r(i,j-1)+(r(i,j-1)-r(i-1,j-1))/(4^(j-1)-1);
    end
    h = h/2; % Prepare for next level
end