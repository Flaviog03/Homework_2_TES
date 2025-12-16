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

### 📝 Aggiornamento Moduli di Analisi (Flavio)

Sono stati aggiunti due nuovi moduli nella cartella `functions/` per completare i requisiti del progetto (slide 8 e 12).

#### 1\. Nuovo file: `functions/plot_confronto.m`

  * **A cosa serve:** Sovrappone lo spettro del segnale originale e quello filtrato in un unico grafico (dB) per visualizzare l'effetto del taglio di frequenza.
  * **Come usarlo nel main:**
    ```matlab
    % Esempio di chiamata
    plot_confronto(x, y_out, Fs, 'Titolo del Grafico');
    ```

#### 2\. Nuovo file: `functions/stima_h_auto.m`

  * **A cosa serve:** Calcola e plotta la Risposta in Frequenza $H(f)$ del filtro.
      * *Nota:* Genera internamente il **Rumore Bianco** necessario per la stima corretta, quindi non serve sporcare il main con vettori di rumore.
  * **Come usarlo nel main:**
    Basta passargli il vettore `h` (che esce dalla funzione `filtri`):
    ```matlab
    % Esempio di chiamata
    stima_h_auto(h, Fs, 'Titolo del Grafico');
    ```

-----

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