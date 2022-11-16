function Output=prime(n)
nf=0;
Output=0;
nf=factors(n);
if nf>1 && nf<3
    Output=1;
else
    Output=0;
end
end