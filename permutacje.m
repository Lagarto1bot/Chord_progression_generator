function [perm] = permutacje(n, p, X)
    perm = zeros(p,n); %zdefiniowanie macierzy do wypisania 
                       %wszystkich zadanych permutacji
    uzupelnienie = X; %wektor pomocniczy
    for ilosc = 1:p
        perm(ilosc,:) = uzupelnienie; %algorytm działa na bierzącm wektorze
        j = n;
        for i = 1:n-1 %znalezeinie indeksu liczby spełniającej warunek max j, aj+1>aj
            if(perm(ilosc,i+1) > perm(ilosc,i))
                j = i;
            end
        end
        if(j == n)
                ilosc
                disp("koniec");
                break;
        end
        %przygotowanie wektora pomocniczego do uzupelnienia permutacji
        for i = 1:j
            uzupelnienie(i) = 0;
        end
        %znalezenie liczby i jej indeksu dla warunku ak>aj
        k = find(perm(ilosc,:) > perm(ilosc,j));
        %sprawdzenie warunku k>j
        k(k<j) = j+1;
        %przestawienie liczby zamienianej w wektorze aby jej nie "zgubic"
        uzupelnienie(k(end)) = perm(ilosc,j);
        uzupelnienie = sort(uzupelnienie);
        %wstawienie odpowiedniej liczby w znalezione miejsce o indeksie j
        perm(ilosc,j) = min(perm(ilosc,k));
        %uzupełnienie reszty wektora o liczby które się permutuje 
        for i = j+1:n
            perm(ilosc,i) = uzupelnienie(i);
        end
        %przygotowanie do działania następnej pętli algorytmu na nowym
        %zbiorze
        uzupelnienie = perm(ilosc,:); 
    end 
end