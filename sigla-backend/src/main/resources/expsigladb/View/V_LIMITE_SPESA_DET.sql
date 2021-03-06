--------------------------------------------------------
--  DDL for View V_LIMITE_SPESA_DET
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_LIMITE_SPESA_DET" ("ESERCIZIO", "CD_CDS", "TI_APPARTENENZA", "TI_GESTIONE", "CD_ELEMENTO_VOCE", "DS_ELEMENTO_VOCE", "FONTE", "IMPORTO_LIMITE", "IMPEGNI_ASSUNTI", "IMPORTO_DISPONIBILE") AS 
  SELECT
D.ESERCIZIO,
D.CD_CDS          ,
D.TI_APPARTENENZA ,
D.TI_GESTIONE     ,
D.CD_ELEMENTO_VOCE,
E.DS_ELEMENTO_VOCE,
D.FONTE           ,
D.IMPORTO_LIMITE  ,
D.IMPEGNI_ASSUNTI ,
NVL(D.IMPORTO_LIMITE,0) -NVL(D.IMPEGNI_ASSUNTI,0)
FROM LIMITE_SPESA_DET D,ELEMENTO_VOCE E
WHERE
E.ESERCIZIO         = D.ESERCIZIO_VOCE   AND
E.TI_APPARTENENZA   = D.TI_APPARTENENZA  AND
E.TI_GESTIONE       = D.TI_GESTIONE      AND
E.CD_ELEMENTO_VOCE  = D.CD_ELEMENTO_VOCE
order by d.esercizio,d.cd_cds,d.cd_elemento_voce,fonte;
