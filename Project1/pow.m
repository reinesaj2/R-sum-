function []=pow(x,y)
err = inf;
i = 1;
while err > 1*exp(-10)
    ny = x*y;
    ny = ny/norm(ny);
    err=max(abs(ny-y));
    y = ny;
    fprintf('After iterating, %d for vector called ny is \n ',i);
    disp(y);
    i = i+1;
end
fprintf('ny converges at ');
x = y'*x*y/(y'*y)
fprintf('eig(x) is: ')
eig(x)