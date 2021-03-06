--------------------------------------------------------
--  DDL for View PRT_PAGA_ESTERO_CNR
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "PRT_PAGA_ESTERO_CNR" ("ESERCIZIO", "COD_CDS", "LETTERA_NUM", "LETTERA_DATA", "UO_EMITTENTE", "DOC_TIPO", "UO_ORIGINE","DOC_NUM", "TERZO_COD", "TERZO_DES", "IMP_1210", "IMP_SOSP", "IMP_MAND") AS 
  select
--
-- Date: 03/04/2003
-- Version: 1.2
--
-- Vista di stampa lettere di pagamento estero
--
-- History:
--
-- Date: 19/02/2003
-- Version: 1.0
-- Creazione: questi commenti non erano stati forniti da CNR
--
-- Date: 20/03/2003
-- Version: 1.1
-- eliminate due condizioni non corrette
--
-- Date 03/04/2003
-- Version 1.2
-- Sostituito Im_Pagamento da tabella LETTEA_PAGAM_ESTERO con importo ricavato da Totale Fattura * Cambio della Tabella FATTURA_PASSIVA e
-- con Im_Totale della tabella DOCUMENTO_GENERICO
-- Body
--
LETTERA_PAGAM_ESTERO.ESERCIZIO,
LETTERA_PAGAM_ESTERO.CD_CDS,
LETTERA_PAGAM_ESTERO.PG_LETTERA,
LETTERA_PAGAM_ESTERO.DT_REGISTRAZIONE,
LETTERA_PAGAM_ESTERO.CD_UNITA_ORGANIZZATIVA,
'DG',
DOCUMENTO_GENERICO.cd_uo_origine,
DOCUMENTO_GENERICO.PG_DOCUMENTO_GENERICO,
TERZO.CD_TERZO,
TERZO.DENOMINAZIONE_SEDE,
DOCUMENTO_GENERICO.IM_TOTALE,
NVL(SUM(SOSPESO.IM_SOSPESO),0),
Sum((Select NVL(SUM(MANDATO_RIGA.IM_MANDATO_RIGA), 0) From MANDATO_RIGA
 Where MANDATO_RIGA.ESERCIZIO = DOCUMENTO_GENERICO.esercizio_lettera
   And MANDATO_RIGA.CD_CDS = DOCUMENTO_GENERICO.CD_CDS
   And MANDATO_RIGA.CD_CDS_DOC_AMM = DOCUMENTO_GENERICO.CD_CDS
   And MANDATO_RIGA.CD_UO_DOC_AMM = DOCUMENTO_GENERICO.CD_UNITA_ORGANIZZATIVA
   And MANDATO_RIGA.ESERCIZIO_DOC_AMM = DOCUMENTO_GENERICO.ESERCIZIO
   And MANDATO_RIGA.PG_DOC_AMM = DOCUMENTO_GENERICO.PG_DOCUMENTO_GENERICO
   And MANDATO_RIGA.CD_TIPO_DOCUMENTO_AMM = DOCUMENTO_GENERICO.CD_TIPO_DOCUMENTO_AMM
   And mandato_riga.stato!='A'))
from LETTERA_PAGAM_ESTERO, DOCUMENTO_GENERICO, TERZO, SOSPESO
where
		  DOCUMENTO_GENERICO.CD_CDS = LETTERA_PAGAM_ESTERO.CD_CDS
and   DOCUMENTO_GENERICO.CD_UNITA_ORGANIZZATIVA = LETTERA_PAGAM_ESTERO.CD_UNITA_ORGANIZZATIVA
and   DOCUMENTO_GENERICO.ESERCIZIO_LETTERA = LETTERA_PAGAM_ESTERO.ESERCIZIO
and   DOCUMENTO_GENERICO.PG_LETTERA = LETTERA_PAGAM_ESTERO.PG_LETTERA
and   TERZO.CD_TERZO = (Select DOCUMENTO_GENERICO_RIGA.CD_TERZO From DOCUMENTO_GENERICO_RIGA
                        Where DOCUMENTO_GENERICO_RIGA.ESERCIZIO = DOCUMENTO_GENERICO.ESERCIZIO
                        and   DOCUMENTO_GENERICO_RIGA.CD_CDS = DOCUMENTO_GENERICO.CD_CDS
                        and   DOCUMENTO_GENERICO_RIGA.CD_UNITA_ORGANIZZATIVA = DOCUMENTO_GENERICO.CD_UNITA_ORGANIZZATIVA
                        and   DOCUMENTO_GENERICO_RIGA.PG_DOCUMENTO_GENERICO = DOCUMENTO_GENERICO.PG_DOCUMENTO_GENERICO
                        and   DOCUMENTO_GENERICO_RIGA.CD_TIPO_DOCUMENTO_AMM = DOCUMENTO_GENERICO.CD_TIPO_DOCUMENTO_AMM
                        and   DOCUMENTO_GENERICO_RIGA.PROGRESSIVO_RIGA = 1)
and   SOSPESO.ESERCIZIO(+) = LETTERA_PAGAM_ESTERO.ESERCIZIO
and   SOSPESO.CD_CDS(+) = LETTERA_PAGAM_ESTERO.CD_CDS
and   SOSPESO.TI_ENTRATA_SPESA(+) = LETTERA_PAGAM_ESTERO.TI_ENTRATA_SPESA
and   SOSPESO.TI_SOSPESO_RISCONTRO(+) = LETTERA_PAGAM_ESTERO.TI_SOSPESO_RISCONTRO
and   SOSPESO.CD_SOSPESO(+) = LETTERA_PAGAM_ESTERO.CD_SOSPESO
Group by
LETTERA_PAGAM_ESTERO.ESERCIZIO,
LETTERA_PAGAM_ESTERO.CD_CDS,
LETTERA_PAGAM_ESTERO.PG_LETTERA,
LETTERA_PAGAM_ESTERO.DT_REGISTRAZIONE,
LETTERA_PAGAM_ESTERO.CD_UNITA_ORGANIZZATIVA,
'DG',
DOCUMENTO_GENERICO.cd_uo_origine,
DOCUMENTO_GENERICO.PG_DOCUMENTO_GENERICO,
TERZO.CD_TERZO,
TERZO.DENOMINAZIONE_SEDE,
DOCUMENTO_GENERICO.IM_TOTALE
UNION
select
LETTERA_PAGAM_ESTERO.ESERCIZIO,
LETTERA_PAGAM_ESTERO.CD_CDS,
LETTERA_PAGAM_ESTERO.PG_LETTERA,
LETTERA_PAGAM_ESTERO.DT_REGISTRAZIONE,
LETTERA_PAGAM_ESTERO.CD_UNITA_ORGANIZZATIVA,
'FP',
FATTURA_PASSIVA.cd_uo_origine,
FATTURA_PASSIVA.PG_FATTURA_PASSIVA,
FATTURA_PASSIVA.CD_TERZO,
TERZO.DENOMINAZIONE_SEDE,
FATTURA_PASSIVA.IM_TOTALE_FATTURA*FATTURA_PASSIVA.CAMBIO,
NVL(SUM(SOSPESO.IM_SOSPESO),0),
Sum((Select NVL(SUM(MANDATO_RIGA.IM_MANDATO_RIGA), 0) From MANDATO_RIGA
    Where MANDATO_RIGA.ESERCIZIO = FATTURA_PASSIVA.esercizio_lettera
      And MANDATO_RIGA.CD_CDS = FATTURA_PASSIVA.CD_CDS
      And MANDATO_RIGA.CD_CDS_DOC_AMM = FATTURA_PASSIVA.CD_CDS
      And MANDATO_RIGA.CD_UO_DOC_AMM = FATTURA_PASSIVA.CD_UNITA_ORGANIZZATIVA
      And MANDATO_RIGA.ESERCIZIO_DOC_AMM = FATTURA_PASSIVA.ESERCIZIO
      And MANDATO_RIGA.PG_DOC_AMM = FATTURA_PASSIVA.PG_FATTURA_PASSIVA
      And MANDATO_RIGA.CD_TIPO_DOCUMENTO_AMM = 'FATTURA_P'
      And mandato_riga.stato!='A'))
from LETTERA_PAGAM_ESTERO, FATTURA_PASSIVA, TERZO, SOSPESO
where
			FATTURA_PASSIVA.CD_CDS = LETTERA_PAGAM_ESTERO.CD_CDS
and   FATTURA_PASSIVA.CD_UNITA_ORGANIZZATIVA = LETTERA_PAGAM_ESTERO.CD_UNITA_ORGANIZZATIVA
and   FATTURA_PASSIVA.ESERCIZIO_LETTERA = LETTERA_PAGAM_ESTERO.ESERCIZIO
and   FATTURA_PASSIVA.PG_LETTERA = LETTERA_PAGAM_ESTERO.PG_LETTERA
and   TERZO.CD_TERZO = FATTURA_PASSIVA.CD_TERZO
and   SOSPESO.ESERCIZIO(+) = LETTERA_PAGAM_ESTERO.ESERCIZIO
and   SOSPESO.CD_CDS(+) = LETTERA_PAGAM_ESTERO.CD_CDS
and   SOSPESO.TI_ENTRATA_SPESA(+) = LETTERA_PAGAM_ESTERO.TI_ENTRATA_SPESA
and   SOSPESO.TI_SOSPESO_RISCONTRO(+) = LETTERA_PAGAM_ESTERO.TI_SOSPESO_RISCONTRO
and   SOSPESO.CD_SOSPESO(+) = LETTERA_PAGAM_ESTERO.CD_SOSPESO
Group by
LETTERA_PAGAM_ESTERO.ESERCIZIO,
LETTERA_PAGAM_ESTERO.CD_CDS,
LETTERA_PAGAM_ESTERO.PG_LETTERA,
LETTERA_PAGAM_ESTERO.DT_REGISTRAZIONE,
LETTERA_PAGAM_ESTERO.CD_UNITA_ORGANIZZATIVA,
'FP',
FATTURA_PASSIVA.cd_uo_origine,
FATTURA_PASSIVA.PG_FATTURA_PASSIVA,
FATTURA_PASSIVA.CD_TERZO,
TERZO.DENOMINAZIONE_SEDE,
FATTURA_PASSIVA.IM_TOTALE_FATTURA*FATTURA_PASSIVA.CAMBIO;
