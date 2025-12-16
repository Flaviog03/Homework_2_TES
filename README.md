# Homework_2_TES

### Suddivisione compiti:

### 1) Roberto:
 Il "Filter Designer" (Matematica e $h[n]$)Obiettivo: Scrivere le funzioni che restituiscono i vettori h pronti per la convoluzione.Compiti:Implementare la formula del Coseno Rialzato nel dominio del tempo (slide 10)9.Gestire il problema del troncamento (scegliere quanti lobi laterali tenere) e della causalità (shiftare il vettore in modo che parta da $t=0$)10.Creare il vettore per il Filtro 1 (Porta) e derivare il Filtro 3 (Passa-alto).Assicurarsi che il taglio sia circa a 1 kHz come suggerito11.

### 2) Bianca:
Il "Signal Processor" (Core e Audio)
Obiettivo: Gestire i file audio, la convoluzione e la generazione del rumore.
Compiti:
- Caricare i file WAV e normalizzarli.
- Implementare il loop principale che applica conv(x, h) per ogni filtro e ogni file audio.
- Generare il segnale di Rumore Gaussiano Bianco con randn() da passare al team di analisi.
- Salvare i file audio di uscita (per l'ascolto) in una cartella ordinata

### 3) Flavio:
Obiettivo: Visualizzare i risultati e stimare la funzione di trasferimento.
Compiti:
- Adattare il codice dell'Esercitazione 1 per plottare gli spettri di ampiezza14.
- Implementare il calcolo della Funzione di Trasferimento $H(f)$. 
  Attenzione: Questo va fatto calcolando la FFT dell'uscita 
  e dell'ingresso del segnale di Rumore Bianco generato dalla Persona 2, 
  per evitare divisioni per zero.
- Creare i grafici comparativi (Spettro Ingresso vs Spettro Uscita).

-----
### 📄 Documentazione Funzioni Analisi (per functions/)
Ecco le specifiche per le due nuove funzioni di analisi implementate per il testing dei filtri.
1. stimaH.m
Scopo:Calcola e visualizza la stima della Risposta in Frequenza $H(f)$ del filtro.Come richiesto dalle specifiche, non usa la semplice FFT dell'impulso, ma simula il passaggio di Rumore Bianco attraverso il filtro e calcola il rapporto tra le densità spettrali ($H(f) = Y(f)/X(f)$).
Sintassi:MatlabstimaH(h_filtro, Fs, titolo)
Parametri:
  - h_filtro: Il vettore della risposta all'impulso (output della funzione filtri).
  - Fs: Frequenza di campionamento (es. 44100).
  - titolo: Stringa per personalizzare il titolo del grafico.
Cosa visualizza:
  - Un grafico del modulo $|H(f)|$.
  - Linea tratteggiata rossa a 1 kHz (frequenza di taglio target).
Nota: Essendo un metodo stocastico (basato su rumore random), la curva potrebbe presentare lievi "frastagliamenti".
Esempio d'uso: Matlab[~, h_impulse] = filtri(2, x, T, beta, Fs); 
% Ottengo h
stimaH(h_impulse, Fs, 'Analisi Coseno Rialzato');

2. plotConfronto.m
Scopo:Confronta visivamente lo spettro del segnale originale con quello del segnale filtrato per verificare l'efficacia del taglio delle frequenze.Sintassi:MatlabplotConfronto(x_in, x_out, Fs, titolo)
Parametri:
  - x_in: Segnale audio originale (ingresso).
  - x_out: Segnale audio filtrato (uscita).
  - Fs: Frequenza di campionamento.
  - titolo: Stringa descrittiva per il grafico.
Cosa visualizza:
  - Spettro di ampiezza in dB.
  - Grigio: Segnale originale (Input).
  - Rosso: Segnale filtrato (Output).
Gestisce automaticamente lunghezze diverse dei vettori tagliandoli alla dimensione minima comune.Esempio d'uso:Matlab[y_out, ~] = filtri(2, x_in, T, beta, Fs);
plotConfronto(x_in, y_out, Fs, 'Verifica Taglio Alti');

### 🔧 Istruzioni per l'integrazione in `main.m` (per Bianca)

Nel ciclo `for` principale, dopo aver salvato il file audio, aggiungi queste due righe:

```matlab
for i = 1:3
    % ... (codice esistente: filtri, audiowrite, etc.) ...
    
    % [NUOVO] 1. Confronto Spettrale Musica (Input vs Output)
    plot_confronto(x, y_out, Fs, sprintf('Filtro %d - Analisi Musica', i));
    
    % [NUOVO] 2. Stima Risposta in Frequenza (Test Rumore Bianco)
    % Passagli la 'h' che hai ottenuto dalla funzione filtri()
    stima_h_auto(h, Fs, sprintf('Filtro %d - Risposta in Frequenza', i));
end
```