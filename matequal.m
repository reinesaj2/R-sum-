function out=matequal(a,b) % True when matrices are equal

[ma,na] = size(a); [mb,nb] = size(b); % must be same size
if ma ~= mb || na ~= nb
    out = false;
else
    out = true;
    for i = 1:ma
        for j = 1:na
            if a(i,j) ~= b(i,j)
                out = false;
            end
        end
    end
end