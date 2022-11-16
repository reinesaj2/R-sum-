clear all
clc
n=60000;a=1:60000;
[prime,output]=listprime(n);
fprintf('n=%d\n',n)
z=find(output>0);
fprintf('6000th prime is %d\n',a(z(6000)))

function [prime,output]=listprime(n)

a=1:n;
i=2;

while i<=sqrt(n)
    b=i+i:i:n;
    for j=1:length(b)
        a(b(j))=0;
    end
    C=find(a ~=0);
    d=find(C>i);
    i=C(d(1));
end

a(1)=0;
prime=a;
prime(prime==0)=[];
output=a;
output(find(output>0))=1;
end