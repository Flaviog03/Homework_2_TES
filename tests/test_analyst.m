%% SCRIPT DI TEST PER MODULI ANALISI (FLAVIO)
% Questo script verifica il funzionamento di:
% 1. functions/plot_confronto.m
% 2. functions/stima_h_auto.m
% 3. functions/filtri.m (per assicurarsi che l'integrazione funzioni)

clc; clear; close all;

%% Setup Percorsi
% Ottieni il percorso completo della cartella in cui si trova questo script
scriptPath = fileparts(mfilename('fullpath'));

% Costruisci il percorso per 'functions' salendo di un livello
% fullfile gestisce correttamente le barre / o \ a seconda del sistema operativo
functionsPath = fullfile(scriptPath, '..', 'functions');

% Aggiungi al path
addpath(functionsPath);

disp('--- INIZIO TEST ANALISI ---');

%% 1. CONFIGURAZIONE PARAMETRI DI TEST
disp('1. Configurazione parametri dummy...');
Fs = 44100;             % Frequenza campionamento standard
T = 1 / (2 * 1000);     % T per taglio a 1 kHz (come da specifiche progetto)
beta = 0.5;             % Roll-off factor

%% 2. TEST PROPEDEUTICO: GENERAZIONE SEGNALE SINTETICO
% Invece di caricare un file FLAC pesante, creiamo un segnale matematico
% composto da due frequenze:
% - 400 Hz (Dovrebbe PASSARE)
% - 5000 Hz (Dovrebbe essere ELIMINATA dal filtro a 1kHz)
disp('2. Generazione segnale sintetico (400Hz + 5kHz)...');
durata = 2; % secondi
t = 0:1/Fs:durata-1/Fs;
sig_basso = sin(2*pi*400*t);  % Dentro la banda passante
sig_alto = 0.5 * sin(2*pi*5000*t); % Fuori banda (attenuata)
x_test = (sig_basso + sig_alto)'; % Vettore colonna

%% 3. TEST INTEGRAZIONE CON ROBERTO (Filtri)
disp('3. Chiamata al filtro (Tipo 2 - Coseno Rialzato)...');
try
    % Chiamiamo la funzione filtri reale
    [y_test, h_impulse] = filtri(2, x_test, T, beta, Fs);
    disp('   -> Filtraggio avvenuto con successo.');
catch ME
    error('ERRORE nella chiamata a filtri.m: %s', ME.message);
end

%% 4. TEST FUNZIONE: plot_confronto
disp('4. Test funzione plotConfronto...');
disp('   -> Verifica visiva: dovresti vedere il picco a 5kHz (destra) drasticamente ridotto.');
try
    plotConfronto(x_test, y_test, Fs, 'TEST SINTETICO: 400Hz (Passa) vs 5kHz (Taglia)');
    disp('   -> Grafico generato.');
catch ME
    warning('ERRORE in plot_confronto: %s', ME.message);
end

%% 5. TEST FUNZIONE: stima_h_auto
disp('5. Test funzione stima_h_auto...');
disp('   -> Verifica visiva: il grafico deve essere piatto fino a 1kHz e poi scendere.');
try
    % Passiamo solo h_impulse, Fs e titolo. Il rumore viene generato dentro.
    stimaH(h_impulse, Fs, 'TEST RISPOSTA IN FREQUENZA');
    disp('   -> Grafico generato.');
catch ME
    warning('ERRORE in stima_h_auto: %s', ME.message);
end

disp('--- FINE TEST ---');
disp('Controlla le due figure aperte per validare i risultati.');