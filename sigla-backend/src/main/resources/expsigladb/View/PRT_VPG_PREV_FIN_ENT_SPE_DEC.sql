--------------------------------------------------------
--  DDL for View PRT_VPG_PREV_FIN_ENT_SPE_DEC
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "PRT_VPG_PREV_FIN_ENT_SPE_DEC" ("ID", "CHIAVE", "TIPO", "SEQUENZA", "ESERCIZIO", "ST_DIP_YN", "SCIENT_YN", "PESO_DIP", "NUM_DIP", "DIP", "DS_DIPARTIMENTO", "CD_LIVELLO1", "CD_LIVELLO1_ROM", "DS_LIVELLO1", "CD_LIVELLO2", "DS_LIVELLO2", "RES_PRES_AC", "PREV_COMPETENZA_AC", "PREV_FULL_AC", "PREV_CASSA_AC", "RES_INIZ_REALI_AP", "PREV_ASS_COMP_AP", "PREV_ASS_FULL_AP", "PREV_ASS_CASSA_AP") AS 
  SELECT ID, CHIAVE, TIPO, SEQUENZA,
IMPORTO_1, -- ESERCIZIO,
ATTRIBUTO_1, -- ST_DIP_YN,
ATTRIBUTO_2, -- SCIENT_YN,
ATTRIBUTO_3, -- PESO_DIP,
ATTRIBUTO_4, -- NUM_DIP,
ATTRIBUTO_5, -- DIP,
ATTRIBUTO_6, -- DS_DIPARTIMENTO,
ATTRIBUTO_7, -- CD_LIVELLO1,
ATTRIBUTO_8, -- CD_LIVELLO1_ROM,
ATTRIBUTO_9, -- DS_LIVELLO1,
ATTRIBUTO_10, -- CD_LIVELLO2,
ATTRIBUTO_11, -- DS_LIVELLO2,
IMPORTO_2, -- RES_PRES_AC,
IMPORTO_3, -- PREV_COMPETENZA_AC
IMPORTO_4, -- PREV_FULL_AC
IMPORTO_5, -- PREV_CASSA_AC,
IMPORTO_6, -- RES_INIZ_REALI_AP,
IMPORTO_7, -- PREV_ASS_COMP_AP,
IMPORTO_8, -- PREV_ASS_FULL_AP
IMPORTO_9 -- PREV_ASS_CASSA_AP,
From TMP_REPORT_GENERICO
;
