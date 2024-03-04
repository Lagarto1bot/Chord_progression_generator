function [kelem] = k_elementowy(k, Z, p) 

%k - ilość elementów w podzbiorze
%p - ilość generowanych podzbiorów
%Z - zbiór główny
kelem = zeros(p, k);
n = 0;
a = 1:k;
j = 1;
while(1)
    kelem(j,:) = a;
    j = j + 1;
    for i = 1:length(a)
        if ~ismember(a(i)+1, a)
            tetmajer = i;
            break
        end
    end
    n = n + 1;
    if a(tetmajer) == max(Z) || n == p
        break
    end
    a(1:tetmajer-1) = 1:tetmajer-1;
    a(tetmajer) = a(tetmajer) + 1;
end
end