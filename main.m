clc;
clear;
close all;
addpath('functions'); 
addpath('data');

% caricamento file
audioFile = 'rock.flac';  % 'rock.flac' o 'classic.flac' 
[x, Fs] = audioread(audioFile);
x = x(:,1); 
x = x / max(abs(x)); % normalizzazione

% scelta dei campioni a seconda del brano
% ho messo 5 secondi come durata ma se volete cambiate
if strcmp(audioFile, 'rock.flac')
    inizio = 225 * Fs;
    fine = 230 * Fs;
else
    inizio = 110 * Fs;
    fine = 115 * Fs;
end
x = x(inizio:fine);

% non ho capito se dovevo anche chiamare la funzione per i grafici
% quindi nel dubbio ho messo questa
% nel caso toglietela pure
plotSpecsBilateral(x,fft(x),Fs,'segnale originale');

% sound(x, Fs);

% Parametri di progetto dalla Slide 9
fc = 1000;          % Frequenza di taglio richiesta (1 kHz)
T = 1 / (2 * fc);   % Risulta 0.0005 secondi (0.5 ms)
% Poi bisogna mettere questa T nei parametri dei filtri!

beta = 0.5;

for i = 1:3
    [y_out, h] = filtri(i, x, T, beta, Fs);
    cartella = fullfile('data', 'risultati');
    nome_file = sprintf('segnale_filtrato_%d.flac', i);
    percorso_completo = fullfile(cartella, nome_file);
    audiowrite(percorso_completo, y_out, Fs);

    % per ascoltare il segnale filtrato
    % sound(y_out, Fs);
    % pause(5.5);

    titolo = sprintf('segnale_filtrato_%d', i);
    plotSpecsBilateral(y_out,fft(y_out),Fs,'segnale filtrato'); 
    % stessa cosa di sopra per i grafici dopo il filtraggio
end





