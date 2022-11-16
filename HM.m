function hM(n)
clc
format long
h = hilb(n); b=zeros(n,1);
for i=1:n
    s=0;
    for j=i:i+n-1
        s=s+(1/j);
    end
    b(i)=s;
end

x = h\b;
fprintf('Displaying x:'); disp(x)
fprintf('The largest error is =');disp(max(abs(x-1))), c = cond(h); 
fprintf('Digits of accuracy is = '); disp(log10(c))
end