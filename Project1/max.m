clear all
clc

n=500000;
z=factors(n);
[mx,index]=max(z);
fprintf('n=%d\n',n)
fprintf('Number of factors for %d ',mx)
fprintf('Number of is %d\n ',index)

function z=factors(n)
z=ones(n,1);
for i=2:n
    for j=i:i:n
        z(j)=z(j)+1;
    end
end
end

