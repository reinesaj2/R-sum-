clc
clear all
f1 = @(x) 1./(1+25.*x.^2);k=0;a=-1;b=1;

for n=10:10:20
    k=k+1;
    x1=linspace(a,b,n);
    y1=double(f1(x1));
    for i=1:n
        x2(i)=(1/2)*(a+b)+(1/2)*(b-a)*cos(((2*i-1)/2*n)); 
    end
end
y2=double(f1(x1));

syms x
p1=polyfit(x1,y1,n-1); p2=polyfit(x2,y2,n-1);
X1=linspace(a,b,200); 
Y1=polyval(p1,X1); Y2=polyval(p2,X1);
Y3=spline(x1,y1,X1); Y4=spline(x2,y2,X1);

figure(k),hold on
plot(X1,Y1,'Linewidth',2)
plot(X1,Y2,'Linewidth',2)
plot(X1,Y3,'Linewidth',2)
plot(X1,Y4,'Linewidth',2)
plot(X1,f1(X1),'Linewidth',2)

xlabel('x')
ylabel('f(x)')
saveas(gcf,'NewtPolys.jpg')