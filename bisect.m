clear all
clc

b=3; a=3;
e = (b-a)/2;
fa=f(a); fb=f(b);
if (fa>0 && fb>0) || (fa<0 && fb<0)
    error('Invalid interval');
end
while abs(e/a) > 5e-11 % relative error
    m=(a+b)/2; fm=f(m)
    if (fa<0 && fm>0 || (fa>0 && fm<0)) %fa*fm < 0
        b=m;
    else
        a=m; fa=fm;
    end 
    e = e/2
end
out = (a+b)/2