clear all, close all, clc, format long, format compact

total = 10^-10; n = 203947;
fA = @(x)x.*(x-1).*(x + 1/2);
dfA = @(x)3*x.^2-x-0.5;
A = -2; B = 2; x = linspace(A,B,n);

for j = 1:n
    num(j) = AChaoticNewton(fA,x(j),dfA,total);
end

plot(x,num,'.','color','r')
xlabel('Estimates'), ylabel('Number found')
NewMeth = sprintf('Newton''s method for our function:\nf(x) = x(x-1)(x+1/2)');
title(NewMeth), grid on
saveas(gcf,'fig0.pdf')
ylim([-1,1.5]), xticks(linspace(A,B,23))

A = -0.3; B = -0.2; x = linspace(A,B,n);

for j = 1:n
    num(j) = AChaoticNewton(fA,x(j),dfA,total);
end

figure
plot(x,num,'.','color','r'), xlabel('Estimates'), ylabel('num')
NewMeth = sprintf('Newton''s method for our function:\nf(x) = x(x-1)(x+1/2)');
title(NewMeth), grid on
saveas(gcf,'fig1.pdf')
ylim([-1,1.5]), xlim([A,B])
xticks(linspace(A,B,21))

fB = @(x)x.^3-1; dfB = @(x)3*x.^2; n = 50; total = 1E-5;
r1=1; r2=(-1-sqrt(-3))/2; r3=(-1+sqrt(-3))/2;
A = -2; B = 2; x = linspace(A,B,n); y = linspace(A,B,n)*sqrt(-1);
q = ones(1,n*n); e = 1;

for i=1:n
    for j=1:n
        num(e) = AChaoticNewton(fB,x(i)+y(j),dfB,total);
        re(e) = x(i);
        im(e) = imag(y(j));
        if abs(num(e)-r2)<0.001
            q(e)=2;
        elseif (abs(num(e)-r3)<0.001)
            q(e)=3;
        end
        e = e+1;
    end
end

figure, hold on
plot(re(q==1),im(q==1),'*','color','B')
plot(re(q==2),im(q==2),'*','color','G')
plot(re(q==3),im(q==3),'*','color','r')
xlabel('Real parts ')
ylabel('Imaginary parts ')
saveas(gcf,'fig2.pdf')
NewMeth = sprintf('Newton''s method applied to\nf(x)=x^3-1');
title(NewMeth)

A = -1; B = 1; x = linspace(A,B,n); y = linspace(A,B,n)*sqrt(-1);
q = ones(1, n*n); e = 1;

for i=1:n
    for j=1:n
        num(e) = AChaoticNewton(fB,x(i)+y(j),dfB,total);
        re(e) = x(i);
        im(e) = imag(y(j));
        if (abs(num(e)-r2)<0.001)
            q(e)=2;
        elseif (abs(num(e)-r3)<0.001)
            q(e)=3;
        end
        e = e+1;
    end
end

figure, xlim([A,B]), ylim([A,B])
hold on
plot(re(q==1),im(q==1),'*','color','B')
plot(re(q==2),im(q==2),'*','color','g')
plot(re(q==3),im(q==3),'*','color','r')
xlabel('Real part of the initial estimate')
ylabel('Imaginary part of the initial estimate')
saveas(gcf,'fig3.pdf')
NewMeth = sprintf('Newton''s method for: \nf(x)=x^3-1');
title(NewMeth)

A = -0.1; B = 0.1; x = linspace(A,B,n); y = linspace(A,B,n)*sqrt(-1);
q = ones(1,n*n); e = 1;

for i=1:n
    for j=1:n
        num(e) = AChaoticNewton(fB,x(i)+y(j),dfB,total);
        re(e) = x(i);
        im(e) = imag(y(j));
        if (abs(num(e)-r2)<0.001)
            q(e)=2;
        elseif (abs(num(e)-r3)<0.001)
            q(e)=3;
        end
        e = e+1;
    end
end

figure, xlim([A,B]), ylim([A,B])
hold on
plot(re(q==1),im(q==1),'*','color','B')
plot(re(q==2),im(q==2),'*','color','g')
plot(re(q==3),im(q==3),'*','color','r')
xlabel('Real parts of the  estimates')
ylabel('Imaginary parts ')
saveas(gcf,'fig4.pdf')
NewMeth=sprintf('Newton''s method for:\nf(x)=x^3-1');
title(NewMeth)
