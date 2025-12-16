function plotConfronto(x_in, x_out, Fs, titolo)
% PLOT_CONFRONTO Confronta lo spettro del segnale originale e filtrato
% Input:
%   x_in: Segnale originale
%   x_out: Segnale filtrato
%   Fs: Frequenza di campionamento
%   titolo: Stringa per il titolo del grafico

    % --- SAFEGUARD PER LUNGHEZZE DIVERSE ---
    min_len = min(length(x_in), length(x_out));
    x_in = x_in(1:min_len);
    x_out = x_out(1:min_len);
    % ---------------------------------------

    N = length(x_in); % Ora N è coerente per entrambi
    f = linspace(-Fs/2, Fs/2, N);

    % Calcolo Spettri (Magnitude)
    X_IN = fftshift(abs(fft(x_in)));
    X_OUT = fftshift(abs(fft(x_out)));

    % Conversione in scala logaritmica (dB) per vedere meglio i dettagli
    X_IN_dB = 20*log10(X_IN + eps);
    X_OUT_dB = 20*log10(X_OUT + eps);

    figure('Name', ['Confronto Spettrale - ' titolo]);
    
    % Plot sovrapposto
    plot(f, X_IN_dB, 'Color', [0.7 0.7 0.7], 'DisplayName', 'Input (Originale)'); hold on;
    plot(f, X_OUT_dB, 'r', 'LineWidth', 1.5, 'DisplayName', 'Output (Filtrato)');
    
    title(['Confronto Spettrale: ' titolo]);
    xlabel('Frequenza (Hz)');
    ylabel('Magnitudo (dB)');
    legend('Location', 'northeast');
    grid on;
    
    % Zoom sulla parte positiva fino a Fs/2
    xlim([0, Fs/2]);
end