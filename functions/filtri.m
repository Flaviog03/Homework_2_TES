function [y_out, filtro] = filtri(tipo_filtro, segnale_input, T, beta, Fs)
    % Beta lo dovete scrivere nel main quando si chiama il filtro 2 ed è
    % 0.5, se no scrivete 0 (forse sbaglio qualcosa qui in caso provate a
    % vedere se va)
    switch tipo_filtro
        case 1 
            filtro = filtro_porta(T, Fs);
        case 2
            filtro = filtro_coseno(T, beta, Fs);
        case 3
            filtro = filtro_passa_alto(T, beta, Fs);
        otherwise
            error('Tipo di filtro non riconosciuto! Solo 1, 2 o 3');
    end
    % Qui faccio la convoluzione
    y_out = conv(segnale_input, filtro);
end 

function y = filtro_porta(T, Fs)
    % Conversione da secondi a numero di campioni
    L = round(T * Fs);
    % Creazione del vettore (Versione discreta della porta)
    % Dividiamo per L per normalizzare l'energia (guadagno unitario in DC)
    y = ones(L, 1) / L; 
end

function y = filtro_coseno(T, beta, Fs)
    % Il filtro teorico di un coseno rialzato è infinito, si deve troncare
    % Prendiamo un numero finito di cicli = 7 per esempio
    num_cicli = 7;
    t = -num_cicli * T : 1/Fs : num_cicli * T;
    % Implementazione Formula:
    % h(t) = (1/T) * sinc(t/T) * cos(pi*beta*t/T) / (1 - (2*beta*t/T)^2)
    numeratore_1 = (1/T) * sinc(t/T);
    numeratore_2 = cos(pi * beta * t / T);
    denominatore = 1 - (2 * beta * t / T).^2;

    % Questa parte provate a toglierla della singolarità provate a
    % toglierla e vede se da davvero errore, se no è inutile!

    % --- GESTIONE SINGOLARITÀ ---
    % Quando il denominatore è 0 (o vicinissimo a 0), Matlab darebbe Inf o NaN.
    % Sostituiamo i valori vicini allo zero con un numero piccolissimo (epsilon).
    eps_val = 1e-10;
    denominatore(abs(denominatore) < eps_val) = eps_val;
    y = numeratore_1 .* (numeratore_2 ./ denominatore);
    % Normalizzazione energetica
    y = y / sum(y);
    y = y(:);
end

function y = filtro_passa_alto(T, beta, Fs)
    % Otteniamo la risposta all'impulso del Passa-Basso (Coseno Rialzato)
    y_cos = filtro_coseno(T, beta, Fs);
    % Creiamo l'Impulso Unitario (Delta)
    % Deve avere la stessa lunghezza del filtro passa-basso.
    L = length(y_cos);
    delta = zeros(L, 1);
    % Posizioniamo l'impulso al centro
    % Poiché h_lp è simmetrico, il picco è esattamente a metà.
    i_centro = ceil(L / 2);
    delta(i_centro) = 1;
    % Calcolo del Passa-Alto
    y = delta - y_cos;
end