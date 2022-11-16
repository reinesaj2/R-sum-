n=13; x=linspace(0,pi,n); y=sin(x);
p=polyfit(x,y,5);
x1=linspace(0,pi);y1=polyval(p,x1);
figure, plot(x,y,'o'), hold on, plot(x1,y1), hold off
saveas(gcf,'polysine.jpg')
x = linspace(0,pi,6); y = erf(x);
p = polyfit(x,y,5);
y1 = erf(x); f1 = polyval(p,x);
figure, plot(x,y,'o'), hold on, plot(x,y1,'-'),plot(x,f1,'r--')
axis([0 5 0 2]), hold off
saveas(gcf,'abserr.jpg')