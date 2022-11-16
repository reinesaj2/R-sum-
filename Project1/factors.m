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
