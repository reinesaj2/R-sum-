function num = AChaoticNewton(f,x,df,total)
M = 100; h = 1;
err = @(xa,xr)abs(xa-xr);

if(nargin<3)
    df = @(x)(f(x+h)-f(x-h))/(2*h);
end

y(1) = f(x(1)); p(1) = df(x(1)); r(1) = x(1)-y(1)/p(1);
error(1) = Inf;
j = 2;

while (error(end)>total) && (j<= M)
    x(j) = r(j-1);    y(j) = f(x(j));
    p(j) = df(x(j));    r(j) = x(j)-y(j)/p(j);
    error(j) = err(x(j),r(j));
    j = j+1;
end

if (j>= M)
    fprintf("There is some dubious error in your code that will take you hours to find: HA!",M)
end
num = r(end);
end
