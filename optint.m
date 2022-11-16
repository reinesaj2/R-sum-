function BN = optint(f,bound,n)

BN = (1/3)*(2*mid(f,bound,n)+trap2(f,bound,n));
end