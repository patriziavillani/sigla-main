--------------------------------------------------------
--  DDL for Package CNRCTB220
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "CNRCTB220" as
--
-- CNRCTB220 - Package controllo batch COEP
-- Date: 17/11/2004
-- Version: 3.18
--
-- Package per il controllo dei batch la gestione delle scritture COEP
--
-- Dependency: IBMUTL 200/210 CNRCTB 018/100/204/205/210
--
-- History:
--
-- Date: 08/05/2002
-- Version: 1.8
-- Creazione
--
-- Date: 16/05/2002
-- Version: 1.9
-- Riorganizzazione
--
-- Date: 29/05/2002
-- Version: 2.0
-- Aggiunta la contabilizzazione ultimi documenti
--
-- CNRCTB220 - Package controllo batch COEP
-- Date: 30/05/2002
-- Fix su recupero tipo di documento
--
-- Date: 31/05/2002
-- Version: 2.2
-- Portato lock e update doc amm e cont coge in package 205
--
-- Date: 06/07/2002
-- Version: 2.3
-- Aggiunta la parte relativa alla dismissione del bene durevole
--
-- Date: 18/07/2002
-- Version: 2.4
-- Aggiornamento documentazione
--
-- Date: 10/10/2002
-- Version: 2.5
-- Eliminato il commit per persistenza del log perchè implicito in log package con pragma autonomous transaction
--
-- Date: 18/10/2002
-- Version: 2.6
-- Sistemazione invocazioni e dump log
--
-- Date: 18/11/2002
-- Version: 2.7
-- Riorganizzazione package CNRCTB205
--
-- Date: 23/12/2002
-- Version: 2.8
-- Sistemata contabilizzazione ultimi documenti (solo per documenti esitati!)
--
-- Date: 28/01/2003
-- Version: 2.9
-- Introduzione del tipo di LOG in logStartExecutionUpdate
--
-- Date: 23/05/2003
-- Version: 3.0
-- Spaccato il loop per esercizio in loop per UO per doc amm e loop per cds per doc cont
--
-- Date: 11/06/2003
-- Version: 3.1
-- Aggiunto metodo che processa COEP per CDS (* = tutti)
--
-- Date: 18/06/2003
-- Version: 3.2
-- Fix logging
--
-- Date: 19/06/2003
-- Version: 3.3
-- Nuova versione dell'estrazione per CDS di origine del documento
-- Nuova gestione della dismissione del bene durevole
--
-- Date: 09/07/2003
-- Version: 3.4
-- Modificata interfaccia dei metodi di processo dei documenti per aggiunta timestamp operazione
--
-- Date: 05/08/2003
-- Version: 3.5
-- Aggiunto indicatore di terminazione del batch
--
-- Date: 05/08/2003
-- Version: 3.6
-- Loop UO spaccato per CDS
-- Introduzione RBSBIG
-- Sistemazione errore di locking errato su dismissione beni durevoli
--
-- Date: 06/08/2003
-- Version: 3.7
-- introduzione metodi commitRbsBig/rollbackRbsBig
--
-- Date: 11/11/2003
-- Version: 3.8
-- Controllo su chiusura definitiva esercizio economico precedente a quello in processo
--
-- Date: 05/03/2004
-- Version: 3.9
-- Sistemazione dell'interfaccia di chiamata della contabilità coan
--
-- Date: 20/05/2004
-- Version: 3.10
-- Aggiunto caricamento dei beni durevoli (richiesta 693)
--
-- Date: 08/06/2004
-- Version: 3.11
-- Test richiesta 693
--
-- Date: 24/09/2004
-- Version: 3.12
-- Richiets 843: I controlli sull'esercizio (finanziario ed economico) del documento in processo sono cambiati
-- La parte di controlli riguardante l'esercizio del documento (che è quello di registrazione economica) sono
-- stati spostati nel metodo: CNRCTB204.checkChiusuraEsercizio
--
-- Date: 25/09/2004
-- Version: 3.13
-- Sistemato problema di cursore causato da checkChiusuraEsercizio
--
-- Date: 05/11/2004
-- Version: 3.14
-- Aggiunto job annullamento documenti provenienti da esercizio precedenti chiusi economicamente
--
-- Date: 10/11/2004
-- Version: 3.15
-- Fix a job_registraAnnCogeEsChiuso per aggiunta rollback per non invalidare cursore
--
-- Date: 10/11/2004
-- Version: 3.16
-- Sistemato il logging del job di annullamento doc esercizio chiuso
--
-- Date: 12/11/2004
-- Version: 3.17
-- Inserimento, nel ciclo generali del job di registrazione COGE, dell'economica da migrazione inventario
--
-- Date: 17/11/2004
-- Version: 3.18
-- Workaround per fix errore di cursore non valido (fetch out of sequence di Oracle)
--
-- Constants:

 TIPO_LOG_JOB_COGE CONSTANT VARCHAR2(20) := 'REG_COGE00';

-- Functions e Procedures

-- Job di registrazione COGE/COAN
--
-- Controllo dei batch per la registrazione della contabilità economica ed analitica.
--
-- pre-post-name: Controlli su esercizio finanziario ed economico di registrazione del documento
-- pre: L'esercizio contabile in cui effettuare la liquidazione non risulta aperto o
--      chiuso finanziariamente o risulta in fase di chiusura economica o chiuso economicamente in modo definitivo
-- post: Viene sollevata un'eccezione
--
-- pre-post-name: Esercizio economico precedente a quello in processo non chiuso definitivamente
-- pre: L'esercizio economico precedente a quello in processo non è chiuso definitivamente per il CDS in processo
-- post: Viene sollevata un'eccezione
--
-- pre-post-name: Documento amministrativo non contabilizzato in COGE oppure documento da contabilizzare nuovamente in COGE (storno e nuova contabilizzazione) (contabilità economica)
-- pre: Documento amministrativo non contabilizzato in COGE oppure documento da contabilizzare nuovamente in COGE (storno e nuova contabilizzazione) (dal punto di vista della contabilità economica)
-- post: Scrittura in partita doppia in contabilità economica del documento amministrativo
--
-- pre-post-name: Dismissione di un bene durevole senza riferimenti esterni
-- pre: esiste almeno un inventario relativo all'esercizio
-- post: registra in COEP la dismissione di un bene durevole
--
-- pre-post-name: Caricamento di un bene durevole senza riferimenti esterni
-- pre: esiste almeno un inventario relativo all'esercizio
-- post: registra in COEP il caricamento di un bene durevole
--
-- pre-post-name: Documento amministrativo non contabilizzato in COGE oppure documento da contabilizzare nuovamente in COGE (storno e nuova contabilizzazione) (contabilità analitica)
-- pre: Documento amministrativo non contabilizzato in COGE oppure documento da contabilizzare nuovamente in COGE (storno e nuova contabilizzazione) (dal punto di vista della contabilità analitica)
-- post: aggiornamento dello stato del documento in contabilità analitica
--

-- Parametri:
-- job -> Numero identificativo del job
-- pg_exec -> Progressivo di esecuzione
-- next_date -> Periodo di esecuzione
-- aEs -> Esercizio
-- aCdCds -> Cds da processare * = tutti cds
-- aData Documenti presenti alla data
 procedure job_registraCogeCoan(job number, pg_exec number, next_date date, aEs number, aCdCds varchar2, aData VARCHAR2);

-- Job di registrazione COGE annullamento documenti di esercizi precedenti chiusi economiicamente
-- definitivamente
--
-- Controllo dei batch per la registrazione della contabilità economica ed analitica.
--
-- pre-post-name: Cds origine del documento non più valido nell'esercizio di registrazione economica dell'annullamento
-- pre: Il cds origine del documento non è più valido nell'esercizio di registrazione economica dell'annullamento
-- post: Viene sollevata un'eccezione
-- pre-post-name: Esercizio in cui si annulla il documento non ancora aperto o chiuso finanziariamente
-- pre: L'esercizio in cui si annulla il documento non ancora aperto per il cds specificato
-- post: Viene sollevata un'eccezione
--
-- pre-post-name: Controlli su esercizio finanziario ed economico di registrazione del documento
-- pre: L'esercizio contabile in cui effettuare la liquidazione non risulta aperto o
--      chiuso finanziariamente o risulta in fase di chiusura economica o chiuso economicamente in modo definitivo
-- post: Viene sollevata un'eccezione
--
-- pre-post-name: Esercizio economico precedente a quello in processo non chiuso definitivamente
-- pre: L'esercizio economico precedente a quello in processo non è chiuso definitivamente per il CDS in processo
-- post: Viene sollevata un'eccezione
--
-- pre-post-name: Documento amministrativo o bene migrato non contabilizzato in COGE oppure
--                documento da contabilizzare nuovamente in COGE (storno e nuova contabilizzazione) (contabilità economica)
-- pre: Documento amministrativo o bene migrato non contabilizzato in COGE oppure documento o bene da contabilizzare nuovamente in COGE (storno e nuova contabilizzazione) (dal punto di vista della contabilità economica)
-- post: Scrittura in partita doppia in contabilità economica del documento amministrativo o bene migrato
--
-- Parametri:
-- job -> Numero identificativo del job
-- pg_exec -> Progressivo di esecuzione
-- next_date -> Periodo di esecuzione
-- aEsAnn -> Esercizio di annullamento
-- aCdCds -> Cds da processare * = tutti cds

 procedure job_registraAnnCogeEsChiuso(job number, pg_exec number, next_date date, aEsAnn number, aCdCds varchar2);

end;
