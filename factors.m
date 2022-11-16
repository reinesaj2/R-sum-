function count=factors(n)
count=0;
for i=1:floor(sqrt(n))
    if mod(n,i)==0
        count=count+1;
        if n/i~=i
            count=count+1;
        end
    end
end
%{
factors(10)
ans =
     4
factors(2)
ans =
     2
factors(9)
ans =
     3
factors(100)
ans =
     9
%}