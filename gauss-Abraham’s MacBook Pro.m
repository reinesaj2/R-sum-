function x=Gauss(A,x)
array=[];
array=[10^-4 10^-8 10^-12 10^-16];
%{
b=[1 2]';
b_old=[1 2]';
syms y;
%}
%A=[y 1;1 1];
[m,n]=size(A);
disp('Backslash command gives the best answer ')
disp('Original Solution using Backslash command for n = 16,12,8,4 is: ')
%p=length(b);
%{
for h = 1:4
    z=subs(A,{y},{array(h)});
    disp(vpa(z.\b_old'))
end
%}
disp('Gauss Solution for n = 16,12,8,4 is: ')
for h = 1:4
    if m~=n || m~=p, error('Size Mismatch '), end
    for k=1:n-1
        for i=k+1:n
            t=z(i,k)/z(k,k);
            z(i,k)=0;
            for j=k+1:n
                z(i,j)=z(i,j)-t*z(k,j);
            end
            b(i)=b(i)-t*b(k);
        end
    end
    disp(b)
end

A=[1 1; y 1];
disp('Gauss Solution for n = 16,12,8,4 is: ')
for h = 1:4
    z=subs(A,{y},{array(h)});
    if m~=n || m~=p, error('Size Mismatch '), end
    for k=1:n-1
        for i=k+1:n
            t=z(i,k)/z(k,k);
            z(i,k)=0;
            for j=k+1:n
                z(i,j)=z(i,j)-t*z(k,j);
            end
            b(i)=b(i)-t*b(k);
        end
    end
    disp(b')
end
end