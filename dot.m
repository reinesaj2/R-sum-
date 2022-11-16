function out = dot(x,y) % dot product of vectors x,y
m = length(x); n = length(y);

if m ~= n 
    error('Length mismatch');
else
    out = 0;
    for i = 1:n
        out = out+x(i)*y(i);
    end
end