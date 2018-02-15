CREATE OR REPLACE FUNCTION Somma_Doc_Att_Per_Scadenza
   (CD_CDS_ACC     IN VARCHAR2,
    ES_ACC         IN NUMBER,
    ES_ORI_ACC     IN NUMBER,
    PG_ACC         IN NUMBER,
    PG_SCAD        IN NUMBER
    ) RETURN NUMBER IS

RISULTATO NUMBER;

BEGIN
 SELECT NVL(SUM(NVL(IM_RIGA, 0)), 0)
 INTO   RISULTATO
 FROM   DOCUMENTO_GENERICO_RIGA
 WHERE  CD_CDS_ACCERTAMENTO          = CD_CDS_ACC  AND
        ESERCIZIO_ACCERTAMENTO       = ES_ACC      AND
        ESERCIZIO_ORI_ACCERTAMENTO   = ES_ORI_ACC  AND
        PG_ACCERTAMENTO              = PG_ACC      AND
        PG_ACCERTAMENTO_SCADENZARIO  = PG_SCAD AND
        STATO_COFI != 'A';

RETURN NVL(RISULTATO, 0);
END;
/

