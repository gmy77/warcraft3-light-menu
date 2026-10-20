# Warcraft III Reforged — Light Menu workaround

Workaround sperimentale per ridurre il carico del menu di Warcraft III Reforged sostituendo alcuni video WebM animati del menu con video VP9 validi, neri e molto brevi.

> Questo progetto non è ufficiale Blizzard, non modifica gli archivi CASC e non pretende di risolvere il difetto nel gioco. È una soluzione locale e reversibile, pensata come workaround fino a una correzione ufficiale.

## Il problema osservato

Durante l’uso del menu principale di Warcraft III Reforged il client mostrava rallentamenti evidenti, mentre il gioco vero e proprio risultava giocabile. L’analisi locale ha evidenziato un carico importante dei componenti `BlizzardBrowser.exe`/CEF associati all’interfaccia WebUI.

Il menu contiene diversi video WebM sotto:

```text
war3.w3mod\webui\webms\
```

Tra quelli individuati ci sono `mainmenu.webm`, le varianti `mainmenu_*` e `random-bg.webm`. Questi contenuti sono parte dell’interfaccia e non delle mappe o dei salvataggi.

## Perché abbiamo proceduto con una revisione

Il primo tentativo usava file WebM vuoti per impedire la decodifica dei video. Il menu appariva più leggero, ma il client ha poi mostrato una schermata bianca durante il caricamento del livello.

Il caricamento falliva dopo il click su “Avanti”. Dopo il ripristino dei file originali il gioco è tornato a caricare normalmente lo stesso livello. Questo test ha dimostrato che i file a lunghezza zero non sono una sostituzione valida per il motore WebUI.

La revisione usa quindi video WebM realmente decodificabili:

- codec VP9;
- 1920×810, coerente con il formato del video originale;
- 30 FPS;
- circa 2 secondi;
- nessuna traccia audio;
- colore nero;
- dimensione di circa 3,8 KB ciascuno.

In questo modo il client riceve un contenitore video valido, ma il menu non deve elaborare gli sfondi animati originali.

## Cosa modifica

La patch usa il meccanismo dei file locali di Warcraft III:

```text
C:\Warcraft III\_retail_\webui\webms\
```

e abilita il valore utente:

```text
HKCU\Software\Blizzard Entertainment\Warcraft III
Allow Local Files = 1 (DWORD)
```

Non vengono modificati:

- gli archivi CASC;
- gli eseguibili del gioco;
- mappe, mod, replay o salvataggi;
- configurazioni di rete o firewall;
- Battle.net o il sistema antivirus.

## Installazione

1. Chiudere completamente Warcraft III.
2. Eseguire `Apply-LightMenu.ps1` dalla cartella della patch.
3. Avviare il gioco normalmente da Battle.net.
4. Verificare prima il menu e poi il caricamento di una partita.

La patch è sperimentale: il menu può risultare nero o statico. Se il caricamento del livello fallisce, usare immediatamente `Restore-Original.ps1`.

## Ripristino

Eseguire:

```powershell
.\Restore-Original.ps1
```

Lo script rimuove l’override locale e disabilita `Allow Local Files`, riportando il client ai file CASC originali.

## Aggiornamenti Blizzard

Un aggiornamento può cambiare i nomi dei file, la struttura WebUI o il comportamento dei file locali. Per questo la patch non sostituisce gli archivi CASC e non è dichiarata permanente.

Dopo ogni aggiornamento:

1. verificare che il gioco parta senza override;
2. controllare il nuovo build;
3. riapplicare la patch solo se i test del menu e del caricamento hanno esito positivo;
4. usare il ripristino se compaiono schermate bianche, errori o problemi online.

## Stato della verifica

Verificato localmente:

- il menu originale presenta rallentamenti;
- la rimozione temporanea dei video riduce il carico percepito del menu;
- i file WebM vuoti causano un errore durante il caricamento del livello;
- il ripristino elimina l’errore;
- i nuovi file VP9 sono validi e decodificabili con FFmpeg.

Ancora da verificare in modo completo:

- stabilità prolungata del menu leggero;
- caricamento di campagne, partite personalizzate e multiplayer;
- comportamento dopo il prossimo aggiornamento Blizzard;
- eventuali altri video o animazioni WebUI non inclusi nella prima revisione.

## Nota legale e tecnica

Warcraft III e i suoi contenuti appartengono ai rispettivi titolari. Questa repository contiene solo script, documentazione e piccoli video generati per il workaround; non distribuisce il gioco né archivi CASC originali.

