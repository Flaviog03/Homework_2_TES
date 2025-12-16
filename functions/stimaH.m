function stimaH(h_filtro, Fs, titolo)
% STIMA_H_AUTO Stima la risposta in frequenza H(f) generando internamente rumore bianco.
% Input:
%   h_filtro: Il vettore della risposta all'impulso (che esce dalla tua funzione 'filtri')
%   Fs:       Frequenza di campionamento
%   titolo:   Stringa per il grafico

    %% 1. Generazione Interna del Rumore Bianco
    % Generiamo una quantità sufficiente di campioni (es. 5 secondi)
    % per avere una buona risoluzione statistica nello spettro.
    durata_sec = 5; 
    L = durata_sec * Fs;
    
    noise_in = randn(L, 1);
    
    %% 2. Applicazione del Filtro (Convoluzione)
    % Usiamo 'same' per mantenere la stessa lunghezza
    noise_out = conv(noise_in, h_filtro, 'same');
    
    %% 3. Calcolo Spettri e H(f)
    % Asse frequenze
    f = linspace(-Fs/2, Fs/2, L);
    
    % FFT (su tutto il segnale di rumore)
    X_NOISE = fftshift(fft(noise_in));
    Y_NOISE = fftshift(fft(noise_out));
    
    % Stima H(f) = Y(f) / X(f)
    H_est = Y_NOISE ./ X_NOISE;
    
    %% 4. Plot
    figure('Name', ['Stima H(f) - ' titolo]);
    
    % Plottiamo il modulo |H(f)|
    % Usiamo abs() perché H_est è complessa
    plot(f, abs(H_est), 'b', 'LineWidth', 1.5);
    
    title(['Risposta in Frequenza Stimata: ' titolo]);
    xlabel('Frequenza (Hz)');
    ylabel('|H(f)| (Guadagno Lineare)');
    grid on;
    
    % Zoom sulla parte positiva (0 - Fs/2)
    xlim([0, Fs/2]);
    
    % Aggiungiamo la linea di riferimento a 1 kHz (richiesta di progetto)
    xline(1000, '--r', 'Taglio 1kHz');
    
    % Opzionale: Aggiungiamo una legenda con info sul filtro
    legend('H(f) calcolata via Rumore Bianco');

end