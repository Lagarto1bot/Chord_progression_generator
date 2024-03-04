function GeneratorDzwieku(progresja)

    Fs = 44100; % Częstotliwość próbkowania
    czas_trwania = 1; % Czas trwania dźwięku w sekundach
    % Składowe harmoniczne
    harmoniczne = [1, 0.7, 0.4, 0.2, 0.1, 0.07]; % Współczynniki dla kolejnych harmonicznych
    t = 0:1/Fs:czas_trwania-1/Fs; 

    il_akordow = size(progresja, 1);

    % Inicjalizacja wykresu
    figure('Position', [100, 100, 1600, 1200]);
    xlabel('Częstotliwość [Hz]');
    ylabel('Amplituda [dB]');
    title('Wykres logarytmiczny częstotliwości');
    xlim([0, 4.5 * 10^3]); % Ograniczenie zakresu osi x
    hold on; % Pozwala na dodawanie kolejnych danych do istniejącego wykresu

    for i = 1:il_akordow
        sound_1 = zeros(size(t));
        sound_2 = zeros(size(t));
        sound_3 = zeros(size(t));

        for j = 1:length(harmoniczne)
            sound_1 = sound_1 + harmoniczne(j) * sin(2*pi*j*progresja(i,1)*t);
            sound_2 = sound_2 + harmoniczne(j) * sin(2*pi*j*progresja(i,2)*t);
            sound_3 = sound_3 + harmoniczne(j) * sin(2*pi*j*progresja(i,3)*t);
        end

        % Normalizacja amplitudy poszczególnych dzwięków
        amplituda = max([max(sound_1), max(sound_2), max(sound_3)]);
        sound_1 = sound_1 / amplituda;
        sound_2 = sound_2 / amplituda;
        sound_3 = sound_3 / amplituda;

        % Łączenie dźwięków w akord
        akord = sound_1 + sound_2 + sound_3;
        akord = akord/max(abs(akord)); %normalizacja akordu

        % Wykres logarytmiczny
        f = linspace(0, Fs/2, length(akord)/2);
        spectrum = abs(fft(akord))/length(akord);

        % Dodawanie danych do istniejącego wykresu
        semilogx(f, 20*log10(spectrum(1:length(f))), 'LineWidth', 0.5);
        grid on;
        drawnow; % Aktualizuje wyświetlanie wykresu

        %Odtwarzanie
        sound(akord, Fs)
        pause(1.1);
    end
    
    hold off; % Zakończ dodawanie danych do wykresu
end