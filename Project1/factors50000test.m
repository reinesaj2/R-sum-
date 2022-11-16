n=0;r=0;q=0;
for i=1:500000
    n=factors(i);
    if n>=r
        r=n;
        q=i;
    end
end
disp('Desired number is: '), disp(q)