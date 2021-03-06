--------------------------------------------------------
--  DDL for View V_COAN_MOVIMENTI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_COAN_MOVIMENTI" ("CD_TIPO_DOCUMENTO_AMM", "CD_TERZO", "CD_CDS", "CD_UNITA_ORGANIZZATIVA", "ESERCIZIO", "PG_NUMERO_DOCUMENTO", "ESERCIZIO_OBB_ACC", "TI_APPARTENENZA", "TI_GESTIONE", "CD_ELEMENTO_VOCE", "CD_CENTRO_RESPONSABILITA", "CD_LINEA_ATTIVITA", "CD_FUNZIONE", "CD_NATURA", "IM_MOVIMENTO_COAN") AS 
  SELECT
--
-- Date: 10/06/2002
-- Version: 1.1
--
-- Vista di estrazione dei movimenti coan
--
-- History:
--
-- Date: 03/04/2002
-- Version: 1.0
-- Creazione
--
-- Date: 10/06/2002
-- Version: 1.1
-- INTRODUZIONE DEGLI ACCERTAMENTI
--
-- Body:
--
	    V.CD_TIPO_DOCUMENTO_AMM
	   ,V.CD_TERZO
       ,V.CD_CDS
	   ,V.CD_UNITA_ORGANIZZATIVA
	   ,V.ESERCIZIO
	   ,V.PG_NUMERO_DOCUMENTO
	   ,V.ESERCIZIO_OBB_ACC
	   ,V.TI_APPARTENENZA
	   ,V.TI_GESTIONE
	   ,V.CD_ELEMENTO_VOCE
	   ,V.CD_CENTRO_RESPONSABILITA
	   ,V.CD_LINEA_ATTIVITA
	   ,V.CD_FUNZIONE
	   ,V.CD_NATURA
	   ,SUM(V.IM_PARZIALE) IM_MOVIMENTO_COAN
FROM V_COAN_MOVIMENTI_PLUS V
GROUP BY V.CD_TIPO_DOCUMENTO_AMM
	   ,V.CD_TERZO
       ,V.CD_CDS
	   ,V.CD_UNITA_ORGANIZZATIVA
	   ,V.ESERCIZIO
	   ,V.PG_NUMERO_DOCUMENTO
	   ,V.ESERCIZIO_OBB_ACC
	   ,V.TI_APPARTENENZA
	   ,V.TI_GESTIONE
	   ,V.CD_ELEMENTO_VOCE
	   ,V.CD_CENTRO_RESPONSABILITA
	   ,V.CD_LINEA_ATTIVITA
	   ,V.CD_FUNZIONE
	   ,V.CD_NATURA
;

   COMMENT ON TABLE "V_COAN_MOVIMENTI"  IS 'Vista di estrazione dei movimenti coan';
