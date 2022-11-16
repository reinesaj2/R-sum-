function a=dd(x,y)
% Find newton polynomial coefficients
n = length(x); d = zeros(n,n);
for i = 1:n, d(i,1) = y(i); end
for i = 2:n
    for j = 2:i
        d(i,j) = (d(i,j-1)-d(i-1,j-1))/(x(i)-x(i-j+1));
    end
end
a = zeros(1,n);
for i = 1:n, a(i) = d(i,i); end