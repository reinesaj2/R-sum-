itrue = exp(2) - 1; N = [100 200 400];
TR = zeros(1,length(N));
MR = zeros(1,length(N));
BR = zeros(1,length(N));
Terror = zeros(1,length(N));
Merror = zeros(1,length(N));
Berror = zeros(1,length(N));

for i = 1:length(N)
    TR(i) = trap2(@(x)exp(x), [0 2], N(i));
    MR(i) = mid(@(x)exp(x), [0 2], N(i));
    BR(i) = optint(@(x)exp(x), [0 2], N(i));
end

Terror = abs(itrue - TR);
Merror = abs(itrue - MR);
Berror = abs(itrue - BR);