function out=lagrange(x,y,ptx)
% Evaluate polynomial through (x,y) at ptx.
n=length(x); m=length(y);
if n~=m, error('Mismatch'); end
out=0;
for k=1:n
    lag=1;
    for i=1:n
        if i~=k, lag=lag*(ptx-x(i))/(x(k)-x(i));
        end
    end
    out=out+y(k)*lag;
end