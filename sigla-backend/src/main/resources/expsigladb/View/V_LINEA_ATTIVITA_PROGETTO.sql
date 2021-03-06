--------------------------------------------------------
--  DDL for View V_LINEA_ATTIVITA_PROGETTO
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_LINEA_ATTIVITA_PROGETTO" ("ESERCIZIO", "CD_CENTRO_RESPONSABILITA", "CD_LINEA_ATTIVITA", "CD_TIPO_LINEA_ATTIVITA", "DENOMINAZIONE", "CD_GRUPPO_LINEA_ATTIVITA", "CD_FUNZIONE", "CD_NATURA", "DS_LINEA_ATTIVITA", "DACR", "UTCR", "DUVA", "UTUV", "PG_VER_REC", "CD_CDR_COLLEGATO", "CD_LA_COLLEGATO", "ESERCIZIO_FINE", "ESERCIZIO_INIZIO", "CD_INSIEME_LA", "TI_GESTIONE", "PG_PROGETTO", "CD_RESPONSABILE_TERZO", "FL_LIMITE_ASS_OBBLIG", "CD_PROGETTO", "CD_PROGETTO_PADRE", "CD_COFOG", "CD_PROGRAMMA", "CD_MISSIONE") AS 
  SELECT LINEA_ATTIVITA.ESERCIZIO,LINEA_ATTIVITA.CD_CENTRO_RESPONSABILITA,LINEA_ATTIVITA.CD_LINEA_ATTIVITA,LINEA_ATTIVITA.CD_TIPO_LINEA_ATTIVITA,LINEA_ATTIVITA.DENOMINAZIONE,LINEA_ATTIVITA.CD_GRUPPO_LINEA_ATTIVITA,LINEA_ATTIVITA.CD_FUNZIONE,LINEA_ATTIVITA.CD_NATURA,LINEA_ATTIVITA.DS_LINEA_ATTIVITA,LINEA_ATTIVITA.DACR,LINEA_ATTIVITA.UTCR,LINEA_ATTIVITA.DUVA,LINEA_ATTIVITA.UTUV,LINEA_ATTIVITA.PG_VER_REC,LINEA_ATTIVITA.CD_CDR_COLLEGATO,LINEA_ATTIVITA.CD_LA_COLLEGATO,LINEA_ATTIVITA.ESERCIZIO_FINE,LINEA_ATTIVITA.ESERCIZIO_INIZIO,LINEA_ATTIVITA.CD_INSIEME_LA,LINEA_ATTIVITA.TI_GESTIONE,LINEA_ATTIVITA.PG_PROGETTO,LINEA_ATTIVITA.CD_RESPONSABILE_TERZO,LINEA_ATTIVITA.FL_LIMITE_ASS_OBBLIG,
       PROGETTO.CD_PROGETTO CD_PROGETTO,
       (Select CD_PROGETTO From Progetto Progetto_padre
        Where ESERCIZIO = PROGETTO.ESERCIZIO
        and   PG_PROGETTO = PROGETTO.PG_PROGETTO_PADRE
        AND   TIPO_FASE = PROGETTO.TIPO_FASE) CD_PROGETTO_PADRE,
LINEA_ATTIVITA.CD_COFOG, LINEA_ATTIVITA.CD_PROGRAMMA, LINEA_ATTIVITA.CD_MISSIONE
FROM PROGETTO, V_LINEA_ATTIVITA_VALIDA LINEA_ATTIVITA
WHERE LINEA_ATTIVITA.ESERCIZIO = PROGETTO.ESERCIZIO (+)
AND   LINEA_ATTIVITA.PG_PROGETTO = PROGETTO.PG_PROGETTO(+)
AND   (PROGETTO.TIPO_FASE IS NULL OR PROGETTO.TIPO_FASE = 'X');
