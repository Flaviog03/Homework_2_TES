clc;
clear;
close all;

% Parametri di progetto dalla Slide 9
fc = 1000;          % Frequenza di taglio richiesta (1 kHz)
T = 1 / (2 * fc);   % Risulta 0.0005 secondi (0.5 ms)
% Poi bisogna mettere questa T nei parametri dei filtri!