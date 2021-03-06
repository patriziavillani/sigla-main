--------------------------------------------------------
--  DDL for View V_QUOTE_UTILIZZATORI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_QUOTE_UTILIZZATORI" ("ESERCIZIO", "QUOTE", "CATEGORIA", "DS_CATEGORIA", "CDR", "DS_CDR", "PERC_CDR", "GAE", "DS_GAE", "PERC_GAE", "CD_CDR_AFFERENZA") AS 
  SELECT
AMMORTAMENTO_BENE_INV.ESERCIZIO_COMPETENZA,
SUM(ROUND((NVL(AMMORTAMENTO_BENE_INV.IM_MOVIMENTO_AMMORT,0)*NVL(INVENTARIO_UTILIZZATORI_LA.PERCENTUALE_UTILIZZO_CDR,100)/100 * NVL(INVENTARIO_UTILIZZATORI_LA.PERCENTUALE_UTILIZZO_LA,100)/100),2))IM_MOVIMENTO_AMMORT,
AMMORTAMENTO_BENE_INV.CD_CATEGORIA_GRUPPO,
CATEGORIA_GRUPPO_INVENT.DS_CATEGORIA_GRUPPO,
INVENTARIO_UTILIZZATORI_LA.CD_UTILIZZATORE_CDR,
CDR.DS_CDR,
INVENTARIO_UTILIZZATORI_LA.PERCENTUALE_UTILIZZO_CDR,
INVENTARIO_UTILIZZATORI_LA.CD_LINEA_ATTIVITA,
LINEA_ATTIVITA.DENOMINAZIONE,
INVENTARIO_UTILIZZATORI_LA.PERCENTUALE_UTILIZZO_LA,
CDR.CD_CDR_AFFERENZA
FROM AMMORTAMENTO_BENE_INV,INVENTARIO_UTILIZZATORI_LA,CDR,LINEA_ATTIVITA,CATEGORIA_GRUPPO_INVENT
Where
((Exists(Select 1 From inventario_utilizzatori_la la
Where
AMMORTAMENTO_BENE_INV.PG_INVENTARIO = LA.PG_INVENTARIO AND
AMMORTAMENTO_BENE_INV.NR_INVENTARIO = LA.NR_INVENTARIO AND
AMMORTAMENTO_BENE_INV.PROGRESSIVO = LA.PROGRESSIVO ) And
AMMORTAMENTO_BENE_INV.PG_INVENTARIO = INVENTARIO_UTILIZZATORI_LA.PG_INVENTARIO AND
AMMORTAMENTO_BENE_INV.NR_INVENTARIO = INVENTARIO_UTILIZZATORI_LA.NR_INVENTARIO AND
AMMORTAMENTO_BENE_INV.PROGRESSIVO  = INVENTARIO_UTILIZZATORI_LA.PROGRESSIVO ) Or
(Not Exists (Select 1 From inventario_utilizzatori_la la
Where
AMMORTAMENTO_BENE_INV.PG_INVENTARIO = LA.PG_INVENTARIO AND
AMMORTAMENTO_BENE_INV.NR_INVENTARIO = LA.NR_INVENTARIO AND
AMMORTAMENTO_BENE_INV.PROGRESSIVO = LA.PROGRESSIVO ) And
AMMORTAMENTO_BENE_INV.PG_INVENTARIO = INVENTARIO_UTILIZZATORI_LA.PG_INVENTARIO AND
AMMORTAMENTO_BENE_INV.NR_INVENTARIO = INVENTARIO_UTILIZZATORI_LA.NR_INVENTARIO And
inventario_utilizzatori_la.progressivo=0 )) And
CATEGORIA_GRUPPO_INVENT.CD_CATEGORIA_GRUPPO = AMMORTAMENTO_BENE_INV.CD_CATEGORIA_GRUPPO AND
CDR.CD_CENTRO_RESPONSABILITA = INVENTARIO_UTILIZZATORI_LA.CD_UTILIZZATORE_CDR  AND
LINEA_ATTIVITA.CD_CENTRO_RESPONSABILITA = INVENTARIO_UTILIZZATORI_LA.CD_UTILIZZATORE_CDR  AND
LINEA_ATTIVITA.CD_LINEA_ATTIVITA = INVENTARIO_UTILIZZATORI_LA.CD_LINEA_ATTIVITA  AND
IM_MOVIMENTO_AMMORT>0
Group BY
AMMORTAMENTO_BENE_INV.ESERCIZIO_COMPETENZA,
AMMORTAMENTO_BENE_INV.CD_CATEGORIA_GRUPPO,
CATEGORIA_GRUPPO_INVENT.DS_CATEGORIA_GRUPPO,
INVENTARIO_UTILIZZATORI_LA.CD_UTILIZZATORE_CDR,
CDR.DS_CDR,
INVENTARIO_UTILIZZATORI_LA.PERCENTUALE_UTILIZZO_CDR,
INVENTARIO_UTILIZZATORI_LA.CD_LINEA_ATTIVITA,
LINEA_ATTIVITA.DENOMINAZIONE,
INVENTARIO_UTILIZZATORI_LA.PERCENTUALE_UTILIZZO_LA,
CDR.CD_CDR_AFFERENZA
Order By INVENTARIO_UTILIZZATORI_LA.CD_UTILIZZATORE_CDR,AMMORTAMENTO_BENE_INV.CD_CATEGORIA_GRUPPO,INVENTARIO_UTILIZZATORI_LA.CD_LINEA_ATTIVITA;
