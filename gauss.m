function x=gauss(a,b) % Solve Ax=b using Gaussian elimination
clc
tic
[ma,na] = size(a); n = length(b);
if ma ~= na || ma ~= n
    error('Size mismatch');
end 

% Upper triangular
for k = 1:n-1 % k is column
    if a(k,k) == 0 % pivot is zero
        i = k+1;
        while i<n && a(i,k) == 0, i = i+1; end
        if a(i,k) == 0, error('No unique solution'); end
        for j = k:n
            t = a(i,j); a(i,j) = a(k,j); a(k,j) = t;
        end
        t = b(i); b(i); b(k); b(k) = t;
    end
    for i = k+1:n % i is row to change
        t = a(i,k)/a(k,k); a(i,k) = 0;
        for j = k+1:n % j moves along the row
            a(i,j) = a(i,j)-t*a(k,j);
        end
        b(i) = b(i)-t*b(k);
    end 
end 
toc
disp(a), disp(b)

% Back substitution
x = zeros(n,1); x(n) = b(n)/a(n,n);
for i = n-1:-1:1
    x(i) = b(i);
    for k = i+1:n, x(i) = x(i)-a(i,k)*x(k);
        x(i) = x(i)/a(i,i);
    end
end