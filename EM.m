X = [10 20 40 80]; a = 1; b = 2; p = zeros(1,length(X));

for i = 1:length(X)
    h = (b-a)/X(i);
    x = a:h:b;
    y = zeros(1,length(x));
    for j = 1:length(x)-1
        y(j+1) = y(j) + h*(2/x(j)*y(j)+x(j)^2*exp(x(j)));
    end
    p(i) = y(end);
end
% Error is as expected
error = abs(4*(exp(2)-exp(1))-p)