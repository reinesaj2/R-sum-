function MN = mid(f,bound,n)

h = (bound(2) - bound(1))/n;
x = bound(1):h:bound(2)-h;
x = x+h/2;
fx = feval(f,x);
MN = h*sum(fx);
end