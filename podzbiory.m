function podzbiory(Z, A, p)
%Z - zbiór główny
%A - kolejne generowane podzbiory
%p - ilość generowanych podzbiorów
n = 0;
while (1)
    disp(sort(A(A~=0)))
    differenceSet = setdiff(Z, A);
    greatestElement = max(differenceSet);
    n = n + 1;
    if isempty(greatestElement) || n == p
        break
    end
    c = find(A == 0, 1, "first");
    A(c) = greatestElement;
    A(A>greatestElement) = 0;
end
end