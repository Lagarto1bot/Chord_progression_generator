%% Projekt 1
%% Algorytmy
% Generowanie podzbiorów:

%UWAGA, proszę nie zmieniać tego wektora (ilość dźwięków w skali to 7)
Z = [1, 2, 3, 4, 5, 6, 7];

przyklad = [1, 2, 3, 5];

o = zeros(size(Z)) + [przyklad zeros(1, length(Z)-length(przyklad))]; %dopełnienie zerami
podzbiory(Z, o, 10); 
%Z - zbiór główny
%A - kolejne generowane podzbiory
%p - ilość generowanych podzbiorów
%% 
% Podzbiory k-elementowe (parametr pierwszy odpowiada w późniejszym zagadnieniu 
% za liczbę akordów):

kelementowy = k_elementowy(4, Z, 21)
%k - ilość elementów w podzbiorze
%p - ilość generowanych podzbiorów
%Z - zbiór główny
niezerowe = any(kelementowy, 2);
kelementowy = kelementowy(niezerowe, :)
%% 
% Wygenerowanie losowego podzbior k-elementowego  zbioru Z:

losowy_wiersz_kel = kelementowy(randi(size(kelementowy,1)), :)
%% 
% Permutacje:

X = [4, 5, 6, 3, 2, 1];
%max(x) = n - najwiekszy element zbioru
%p = 10 - ilość generowanych permutacji ze zbioru X
%X - zbiór główny
permutacje(max(X),10,X)
mutacje = permutacje(size(losowy_wiersz_kel, 2), factorial(size(losowy_wiersz_kel,2)), losowy_wiersz_kel);
niezerowe = any(mutacje, 2);
mutacje = mutacje(niezerowe, :);
%% 
% Wygenerowanie losowej permutacji podzbioru k-elementowego ze zbioru Z:

losowy_wiersz_mutant = mutacje(randi(size(mutacje,1)), :)
%% Generowanie akordów i ich progresji
% Tonacja i majmin są zmiennymi edytowanymi przez użytkownika, pozwalają na 
% wybranie dowolnej tonacji:

tonacja = "F";
majmin = "min";
A = 110;
notes = struct("C", -9, "CSharp", -8, ...
    "D", -7, "DSharp", -6, ...
    "E", -5, "F", -4, ... 
    "FSharp", -3, "G", -2, ...
    "GSharp", -1, "A", 0, ...
    "ASharp", 1, "B", 2);
notes.(tonacja);
majorScaleNotesRelations = [0, 2, 4, 5, 7, 9, 11];
minorScaleNotesRelations = [0, 2, 3, 5, 7, 8, 10];

%tworzenie macierzy triad akordów w skali i ich nazw
majorChordCreate = [[0 4 7]; [0 3 7]; [0 3 7]; [0 4 7]; [0 4 7]; [0 3 7]; [0 3 6]];
minorChordCreate = [[0 3 7]; [0 3 6]; [0 4 7]; [0 3 7]; [0 3 7]; [0 4 7]; [0 4 7]];
majorChordCreateNames = ["maj"; "min"; "min"; "maj"; "maj"; "min"; "dim"];
minorChordCreateNames = ["min"; "dim"; "maj"; "min"; "min"; "maj"; "maj"];

akordy = losowy_wiersz_mutant;

progresja = zeros(size(akordy,2), 3);
l = 1:size(akordy,1);
%nazwy akordów: inicjalizacja
chords_in_progression = string(zeros(size(progresja, 1), 1)');
%% 
% Generowanie częstotliwości triad dla j-tego akord zadanej tonacji:

for j = akordy
    j
    for i = 1:size(minorChordCreate, 2)
            if majmin == "maj"
                SNR = majorScaleNotesRelations(j);
                CC = majorChordCreate(j, i);
            elseif majmin == "min"
                SNR = minorScaleNotesRelations(j);
                CC = minorChordCreate(j, i);
            end
        frequency = A*2^((SNR + notes.(tonacja) + CC)/12)
        progresja(l, i) = frequency;
        
    end
    %nazwy akordów przypisanie dla skal major, minor
    if majmin == "maj"
        chords_in_progression(l) = chords_in_progression(l) + majorChordCreateNames(j);
    else
        chords_in_progression(l) = chords_in_progression(l) + minorChordCreateNames(j);
    end
    l = l + 1;
end
%usuwam zera z chords_in_progression (zainicjalizowane jako zeros)
chords_in_progression = erase(chords_in_progression, '0');

%pobranie kluczy ze struktury notes i zamienienie ich na stringi
all_notes = string(fieldnames(notes)');

%znalezienie pozycji nuty we wszystkich nutach
gdzie_nuta = find(all_notes==tonacja);

%zapętlenie wychodzących poza zakres nut za pomocą modulo 12 
% (nuty powtarzają się okresowo)
akordy = akordy + gdzie_nuta - 1;
akordy(akordy>12) = mod(akordy(akordy>12), 12);

%połączenie nut z rodzajami akordów i zamiana słowa Sharp na oznaczenie #
chords_in_progression = all_notes(akordy) + chords_in_progression;
chords_in_progression = replace(chords_in_progression, "Sharp", "#");

%wykres pokazujący progresję
figure('Position', [100, 100, 1600, 100]);
text(0.5, 0.5, sprintf('%s ', chords_in_progression{:}), 'FontSize', 14, 'HorizontalAlignment', 'center');
title("Wykres pokazujący progresję akordów", FontSize=14)
axis off;
GeneratorDzwieku(progresja)
%% 
% Kody m-plików użytych w tym projekcie:
% 
% Funkcja generująca k-elementowy pozdbiór zbioru n-elementowego Z:
%%
% 
%   function [kelem] = k_elementowy(k, Z, p) 
%   
%   %k - ilość elementów w podzbiorze
%   %p - ilość generowanych podzbiorów
%   %Z - zbiór główny
%   kelem = zeros(p, k);
%   n = 0;
%   a = 1:k;
%   j = 1;
%   while(1) %funkcja postępuje zgodnie z podanym w poleceniu algorytmem
%       kelem(j,:) = a;
%       j = j + 1;
%       for i = 1:length(a)
%           if ~ismember(a(i)+1, a)
%               tetmajer = i;
%               break
%           end
%       end
%       n = n + 1;
%       if a(tetmajer) == max(Z) || n == p %warunek stopu
%           break
%       end
%       a(1:tetmajer-1) = 1:tetmajer-1;
%       a(tetmajer) = a(tetmajer) + 1;
%   end
%   end
%
%% 
% Funkcja generujące permutacje:
%%
% 
%   function [perm] = permutacje(n, p, X)
%       perm = zeros(p,n); %zdefiniowanie macierzy do wypisania 
%                          %wszystkich zadanych permutacji
%       uzupelnienie = X; %wektor pomocniczy
%       for ilosc = 1:p
%           perm(ilosc,:) = uzupelnienie; %algorytm działa na bierzącm wektorze
%           j = n;
%           for i = 1:n-1 %znalezeinie indeksu liczby spełniającej warunek max j, aj+1>aj
%               if(perm(ilosc,i+1) > perm(ilosc,i))
%                   j = i;
%               end
%           end
%           if(j == n) %warunek stopu
%                   ilosc
%                   disp("koniec");
%                   break;
%           end
%           %przygotowanie wektora pomocniczego do uzupelnienia permutacji
%           for i = 1:j
%               uzupelnienie(i) = 0;
%           end
%           %znalezenie liczby i jej indeksu dla warunku ak>aj
%           k = find(perm(ilosc,:) > perm(ilosc,j));
%           %sprawdzenie warunku k>j
%           k(k<j) = j+1;
%           %przestawienie liczby zamienianej w wektorze aby jej nie "zgubic"
%           uzupelnienie(k(end)) = perm(ilosc,j);
%           uzupelnienie = sort(uzupelnienie);
%           %wstawienie odpowiedniej liczby w znalezione miejsce o indeksie j
%           perm(ilosc,j) = min(perm(ilosc,k));
%           %uzupełnienie reszty wektora o liczby które się permutuje 
%           for i = j+1:n
%               perm(ilosc,i) = uzupelnienie(i);
%           end
%           %przygotowanie do działania następnej pętli algorytmu na nowym
%           %zbiorze
%           uzupelnienie = perm(ilosc,:); 
%       end 
%   end
%
%% 
% Funkcja generująca dźwięk akordu i wykres logarytmiczny częstotliowości od 
% natężenia dźwięku:
%%
% 
%   function GeneratorDzwieku(progresja)
%   
%       Fs = 44100; % Częstotliwość próbkowania
%       czas_trwania = 1; % Czas trwania dźwięku w sekundach
%       % Składowe harmoniczne
%       harmoniczne = [1, 0.7, 0.4, 0.2, 0.1, 0.07]; % Współczynniki dla kolejnych harmonicznych
%       t = 0:1/Fs:czas_trwania-1/Fs; 
%   
%       il_akordow = size(progresja, 1);
%   
%       % Inicjalizacja wykresu
%       figure('Position', [100, 100, 1600, 1200]);
%       xlabel('Częstotliwość [Hz]');
%       ylabel('Amplituda [dB]');
%       title('Wykres logarytmiczny częstotliwości');
%       xlim([0, 4.5 * 10^3]); % Ograniczenie zakresu osi x
%       hold on; % Pozwala na dodawanie kolejnych danych do istniejącego wykresu
%   
%       for i = 1:il_akordow
%           sound_1 = zeros(size(t));
%           sound_2 = zeros(size(t));
%           sound_3 = zeros(size(t));
%   
%           for j = 1:length(harmoniczne)
%               sound_1 = sound_1 + harmoniczne(j) * sin(2*pi*j*progresja(i,1)*t);
%               sound_2 = sound_2 + harmoniczne(j) * sin(2*pi*j*progresja(i,2)*t);
%               sound_3 = sound_3 + harmoniczne(j) * sin(2*pi*j*progresja(i,3)*t);
%           end
%   
%           % Normalizacja amplitudy poszczególnych dzwięków
%           amplituda = max([max(sound_1), max(sound_2), max(sound_3)]);
%           sound_1 = sound_1 / amplituda;
%           sound_2 = sound_2 / amplituda;
%           sound_3 = sound_3 / amplituda;
%   
%           % Łączenie dźwięków w akord
%           akord = sound_1 + sound_2 + sound_3;
%           akord = akord/max(abs(akord)); %normalizacja akordu
%   
%           % Wykres logarytmiczny
%           f = linspace(0, Fs/2, length(akord)/2);
%           spectrum = abs(fft(akord))/length(akord);
%   
%           % Dodawanie danych do istniejącego wykresu
%           semilogx(f, 20*log10(spectrum(1:length(f))), 'LineWidth', 0.5);
%           grid on;
%           drawnow; % Aktualizuje wyświetlanie wykresu
%   
%           %Odtwarzanie
%           sound(akord, Fs)
%           pause(1.1);
%       end
%       
%       hold off; % Zakończ dodawanie danych do wykresu
%   end
%
%% 
% Funkcja nie wykorzystana w naszym projekcie to generowanie wszystkich podzbiorów 
% zbioru Z:
%%
% 
%   function podzbiory(Z, A, p)
%   %Z - zbiór główny
%   %A - kolejne generowane podzbiory
%   %p - ilość generowanych podzbiorów
%   n = 0;
%   while (1)
%       disp(sort(A(A~=0)))
%       differenceSet = setdiff(Z, A);
%       greatestElement = max(differenceSet);
%       n = n + 1;
%       if isempty(greatestElement) || n == p
%           break
%       end
%       c = find(A == 0, 1, "first");
%       A(c) = greatestElement;
%       A(A>greatestElement) = 0;
%   end
%   end
%
%% 
% 
% 
%