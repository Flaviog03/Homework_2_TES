# Homework_2_TES

Suddivisione compiti:

1) Roberto:
 Il "Filter Designer" (Matematica e $h[n]$)Obiettivo: Scrivere le funzioni che restituiscono i vettori h pronti per la convoluzione.Compiti:Implementare la formula del Coseno Rialzato nel dominio del tempo (slide 10)9.Gestire il problema del troncamento (scegliere quanti lobi laterali tenere) e della causalità (shiftare il vettore in modo che parta da $t=0$)10.Creare il vettore per il Filtro 1 (Porta) e derivare il Filtro 3 (Passa-alto).Assicurarsi che il taglio sia circa a 1 kHz come suggerito11.

2) Bianca:
Il "Signal Processor" (Core e Audio)
Obiettivo: Gestire i file audio, la convoluzione e la generazione del rumore.
Compiti:
- Caricare i file WAV e normalizzarli.
- Implementare il loop principale che applica conv(x, h) per ogni filtro e ogni file audio.
- Generare il segnale di Rumore Gaussiano Bianco con randn() da passare al team di analisi.
- Salvare i file audio di uscita (per l'ascolto) in una cartella ordinata

3) Flavio: L'"Analyst" (Spettri e Plot)
Obiettivo: Visualizzare i risultati e stimare la funzione di trasferimento.
Compiti:
- Adattare il codice dell'Esercitazione 1 per plottare gli spettri di ampiezza14.
- Implementare il calcolo della Funzione di Trasferimento $H(f)$. 
  Attenzione: Questo va fatto calcolando la FFT dell'uscita 
  e dell'ingresso del segnale di Rumore Bianco generato dalla Persona 2, 
  per evitare divisioni per zero.
- Creare i grafici comparativi (Spettro Ingresso vs Spettro Uscita).