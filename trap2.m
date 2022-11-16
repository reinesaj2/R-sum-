function TN = trap2(f,bound,n)

h = (bound(2) - bound(1))/n;
x = bound(1):h:bound(2);
fx = feval(f,x);
TN = h/2*(2*sum(fx) - fx(1)- fx(end));
end