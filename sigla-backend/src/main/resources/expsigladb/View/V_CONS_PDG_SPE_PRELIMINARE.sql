--------------------------------------------------------
--  DDL for View V_CONS_PDG_SPE_PRELIMINARE
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_CONS_PDG_SPE_PRELIMINARE" ("ESERCIZIO", "PESO_DIP", "CD_DIPARTIMENTO", "CD_CENTRO_SPESA", "CD_UNITA_ORGANIZZATIVA", "CD_CENTRO_RESPONSABILITA", "CD_CDR_ORIGINE_FONDI", "CD_CLASSIFICAZIONE", "NR_LIVELLO", "CD_LIVELLO1", "CD_LIVELLO2", "CD_LIVELLO3", "CD_LIVELLO4", "CD_LIVELLO5", "CD_LIVELLO6", "CD_LIVELLO7", "PG_MODULO", "CD_MODULO", "CD_TIPO_MODULO", "PG_COMMESSA", "CD_COMMESSA", "PG_PROGETTO", "CD_PROGETTO", "IM_DEC_IST_INT", "IM_DEC_IST_EST", "IM_DEC_AREA_INT", "IM_DEC_AREA_EST", "TRATT_ECON_INT", "TRATT_ECON_EST", "IM_ACC_ALTRE_SP_INT", "IM_PREV_A2", "IM_PREV_A3") AS 
  Select
--
-- Date: 09/11/2006
-- Version: 1.1
--
-- Vista CONSULTAZIONE Piano di Gestione Preliminare Spese
--
-- History:
--
-- Date: 01/01/2006
-- Version: 1.0
-- Creazione
--
-- Date: 09/11/2006
-- Version: 1.1
-- Aggiunta la selezione del progetto/commessa/modulo per anno
--
-- Body:
--
ESERCIZIO, PESO_DIP, CD_DIPARTIMENTO, CD_CENTRO_SPESA, CD_UNITA_ORGANIZZATIVA,
       CD_CENTRO_RESPONSABILITA, CD_CDR_ORIGINE_FONDI, CD_CLASSIFICAZIONE, NR_LIVELLO,
       CD_LIVELLO1, CD_LIVELLO2, CD_LIVELLO3, CD_LIVELLO4, CD_LIVELLO5, CD_LIVELLO6, CD_LIVELLO7,
       PG_MODULO, CD_MODULO, CD_TIPO_MODULO, PG_COMMESSA, CD_COMMESSA, PG_PROGETTO, CD_PROGETTO,
       Nvl(Sum(IM_DEC_IST_INT), 0) IM_DEC_IST_INT,
       Nvl(Sum(IM_DEC_IST_EST), 0) IM_DEC_IST_EST,
       Nvl(Sum(IM_DEC_AREA_INT), 0) IM_DEC_AREA_INT,
       Nvl(Sum(IM_DEC_AREA_EST), 0) IM_DEC_AREA_EST,
       Nvl(Sum(TRATT_ECON_INT), 0) TRATT_ECON_INT,
       Nvl(Sum(TRATT_ECON_EST), 0) TRATT_ECON_EST,
       Nvl(Sum(IM_ACC_ALTRE_SP_INT), 0) IM_ACC_ALTRE_SP_INT,
       Nvl(Sum(IM_PREV_A2), 0) IM_PREV_A2,
       Nvl(Sum(IM_PREV_A3), 0) IM_PREV_A3
From
(Select PDG_SPE.ESERCIZIO,
       Decode(unita_organizzativa.CD_TIPO_UNITA, 'SAC', '13',to_char(nvl(p.peso,1000))) PESO_DIP,
       Decode(unita_organizzativa.CD_TIPO_UNITA, 'SAC', 'SAC',Nvl(prog.cd_dipartimento, Null)) CD_DIPARTIMENTO,
       UNITA_ORGANIZZATIVA.CD_UNITA_PADRE CD_CENTRO_SPESA,
       UNITA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA,
       PDG_SPE.CD_CENTRO_RESPONSABILITA,
       PDG_SPE.CD_CENTRO_RESPONSABILITA CD_CDR_ORIGINE_FONDI,
       CD_CLASSIFICAZIONE,
       NR_LIVELLO,
       CD_LIVELLO1, CD_LIVELLO2, CD_LIVELLO3, CD_LIVELLO4, CD_LIVELLO5,  CD_LIVELLO6, CD_LIVELLO7,
       MODU.PG_PROGETTO PG_MODULO, MODU.CD_PROGETTO CD_MODULO, MODU.CD_TIPO_PROGETTO CD_TIPO_MODULO,
       COMM.PG_PROGETTO PG_COMMESSA, COMM.CD_PROGETTO CD_COMMESSA,
       PROG.PG_PROGETTO, PROG.CD_PROGETTO,
       Nvl(PDG_SPE.IM_SPESE_GEST_DECENTRATA_INT, 0)  IM_DEC_IST_INT,
       Nvl(PDG_SPE.IM_SPESE_GEST_DECENTRATA_EST, 0)  IM_DEC_IST_EST,
       0  IM_DEC_AREA_INT,
       0  IM_DEC_AREA_EST,
       0  TRATT_ECON_INT,
       0  TRATT_ECON_EST,
       0  IM_ACC_ALTRE_SP_INT,
       0  IM_PREV_A2,
       0  IM_PREV_A3
From   PDG_MODULO_SPESE PDG_SPE,
       V_CLASSIFICAZIONE_VOCI CLA,
       UNITA_ORGANIZZATIVA,
       UNITA_ORGANIZZATIVA AREA,
       CDR,
       PROGETTO_PREV MODU,
       PROGETTO_PREV COMM,
       PROGETTO_PREV PROG,
	dipartimento_peso p
Where
 PROG.esercizio= p.esercizio(+) AND
 PROG.cd_dipartimento= p.cd_dipartimento (+) and
 --Join tra PDG_MODULO_SPESE e V_CLASSIFICAZIONE_VOCI
       PDG_SPE.ID_CLASSIFICAZIONE = CLA.ID_CLASSIFICAZIONE And
--Join tra PDG_MODULO_SPESE e AREA (UNITA_ORGANIZZATIVA)
       PDG_SPE.CD_CDS_AREA = AREA.CD_UNITA_ORGANIZZATIVA And
--Join tra PDG_MODULO_SPESE e CDR
       PDG_SPE.CD_CENTRO_RESPONSABILITA = CDR.CD_CENTRO_RESPONSABILITA And
--Join tra CDR e UNITA_ORGANIZZATIVA
       CDR.CD_UNITA_ORGANIZZATIVA = UNITA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA And
--Join tra PDG_MODULO_SPESE e MODULO (PROGETTO)
       PDG_SPE.PG_PROGETTO = MODU.PG_PROGETTO And
       MODU.ESERCIZIO = PDG_SPE.ESERCIZIO And
--Join tra MODULO e COMMESSA (PROGETTO)
       MODU.ESERCIZIO_PROGETTO_PADRE = COMM.ESERCIZIO And
       MODU.PG_PROGETTO_PADRE = COMM.PG_PROGETTO And
--Join tra COMMESSA e PROGETTO
       COMM.ESERCIZIO_PROGETTO_PADRE = PROG.ESERCIZIO And
       COMM.PG_PROGETTO_PADRE = PROG.PG_PROGETTO And
       Nvl(CLA.CDR_ACCENTRATORE, 'xxx') != CNRCTB020.getCdCDRPersonale(PDG_SPE.ESERCIZIO) And
       AREA.CD_TIPO_UNITA != 'AREA'
Union All  -- AREE
Select PDG_SPE.ESERCIZIO,
      Decode(unita_organizzativa.CD_TIPO_UNITA, 'SAC', '13',to_char(nvl(p.peso,1000))) PESO_DIP,
       Decode(unita_organizzativa.CD_TIPO_UNITA, 'SAC', 'SAC',Nvl(prog.cd_dipartimento, Null)) CD_DIPARTIMENTO,
       PDG_SPE.CD_CDS_AREA CD_CENTRO_SPESA,
       UNITA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA,
       CDR.CD_CENTRO_RESPONSABILITA,
       PDG_SPE.CD_CENTRO_RESPONSABILITA CD_CDR_ORIGINE_FONDI,
       CD_CLASSIFICAZIONE,
       NR_LIVELLO,
       CD_LIVELLO1, CD_LIVELLO2, CD_LIVELLO3, CD_LIVELLO4, CD_LIVELLO5,  CD_LIVELLO6, CD_LIVELLO7,
       MODU.PG_PROGETTO PG_MODULO, MODU.CD_PROGETTO CD_MODULO, MODU.CD_TIPO_PROGETTO CD_TIPO_MODULO,
       COMM.PG_PROGETTO PG_COMMESSA, COMM.CD_PROGETTO CD_COMMESSA,
       PROG.PG_PROGETTO, PROG.CD_PROGETTO,
       0 IM_DEC_IST_INT,
       0 IM_DEC_IST_EST,
       Nvl(PDG_SPE.IM_SPESE_GEST_DECENTRATA_INT, 0)  IM_DEC_AREA_INT,
       Nvl(PDG_SPE.IM_SPESE_GEST_DECENTRATA_EST, 0)  IM_DEC_AREA_EST,
       0  TRATT_ECON_INT,
       0  TRATT_ECON_EST,
       0  IM_ACC_ALTRE_SP_INT,
       0  IM_PREV_A2,
       0  IM_PREV_A3
From   PDG_MODULO_SPESE PDG_SPE,
       V_CLASSIFICAZIONE_VOCI CLA,
       UNITA_ORGANIZZATIVA AREA,
       UNITA_ORGANIZZATIVA,
       CDR,
       PROGETTO_PREV MODU,
       PROGETTO_PREV COMM,
       PROGETTO_PREV PROG,
	dipartimento_peso p
Where
 PROG.esercizio= p.esercizio(+) AND
 PROG.cd_dipartimento= p.cd_dipartimento (+) and
 --Join tra PDG_MODULO_SPESE e V_CLASSIFICAZIONE_VOCI
       PDG_SPE.ID_CLASSIFICAZIONE = CLA.ID_CLASSIFICAZIONE And
--Join tra PDG_MODULO_SPESE e AREA (UNITA_ORGANIZZATIVA)
       PDG_SPE.CD_CDS_AREA = AREA.CD_UNITA_ORGANIZZATIVA And
--Join tra AREA e UNITA_ORGANIZZATIVA
       AREA.CD_UNITA_ORGANIZZATIVA = UNITA_ORGANIZZATIVA.CD_UNITA_PADRE And
       UNITA_ORGANIZZATIVA.FL_UO_CDS = 'Y' And
--Join tra UNITA_ORGANIZZATIVA e CDR
       UNITA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA = CDR.CD_UNITA_ORGANIZZATIVA And
       CDR.CD_CDR_AFFERENZA Is Null And
--Join tra PDG_MODULO_SPESE e MODULO (PROGETTO)
       PDG_SPE.PG_PROGETTO = MODU.PG_PROGETTO And
       MODU.ESERCIZIO = PDG_SPE.ESERCIZIO And
--Join tra MODULO e COMMESSA (PROGETTO)
       MODU.ESERCIZIO_PROGETTO_PADRE = COMM.ESERCIZIO And
       MODU.PG_PROGETTO_PADRE = COMM.PG_PROGETTO And
--Join tra COMMESSA e PROGETTO
       COMM.ESERCIZIO_PROGETTO_PADRE = PROG.ESERCIZIO And
       COMM.PG_PROGETTO_PADRE = PROG.PG_PROGETTO And
       Nvl(CLA.CDR_ACCENTRATORE, 'xxx') != CNRCTB020.getCdCDRPersonale(PDG_SPE.ESERCIZIO) And
       AREA.CD_TIPO_UNITA = 'AREA'
Union All -- SPESE ACCENTRATE NON PERSONALE
Select PDG_SPE.ESERCIZIO,
      Decode(unita_organizzativa.CD_TIPO_UNITA, 'SAC', '13',to_char(nvl(p.peso,1000))) PESO_DIP,
       Decode(unita_organizzativa.CD_TIPO_UNITA, 'SAC', 'SAC',Nvl(prog.cd_dipartimento, Null)) CD_DIPARTIMENTO,
       UNITA_ORGANIZZATIVA.CD_UNITA_PADRE CD_CENTRO_SPESA,
       UNITA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA,
       CLA.CDR_ACCENTRATORE CD_CENTRO_RESPONSABILITA,
       PDG_SPE.CD_CENTRO_RESPONSABILITA CD_CDR_ORIGINE_FONDI,
       CD_CLASSIFICAZIONE,
       NR_LIVELLO,
       CD_LIVELLO1, CD_LIVELLO2, CD_LIVELLO3, CD_LIVELLO4, CD_LIVELLO5,  CD_LIVELLO6, CD_LIVELLO7,
       MODU.PG_PROGETTO PG_MODULO, MODU.CD_PROGETTO CD_MODULO, MODU.CD_TIPO_PROGETTO CD_TIPO_MODULO,
       COMM.PG_PROGETTO PG_COMMESSA, COMM.CD_PROGETTO CD_COMMESSA,
       PROG.PG_PROGETTO, PROG.CD_PROGETTO,
       0  IM_DEC_IST_INT,
       0  IM_DEC_IST_EST,
       0  IM_DEC_AREA_INT,
       0  IM_DEC_AREA_EST,
       0  TRATT_ECON_INT,
       0  TRATT_ECON_EST,
       Nvl(PDG_SPE.IM_SPESE_GEST_ACCENTRATA_INT, 0) +
       Nvl(PDG_SPE.IM_SPESE_GEST_ACCENTRATA_EST, 0) IM_ACC_ALTRE_SP_INT,
       0  IM_PREV_A2,
       0  IM_PREV_A3
From   PDG_MODULO_SPESE PDG_SPE,
       V_CLASSIFICAZIONE_VOCI CLA,
       UNITA_ORGANIZZATIVA,
       CDR,
       PROGETTO_PREV MODU,
       PROGETTO_PREV COMM,
       PROGETTO_PREV PROG,
	dipartimento_peso p
Where
 PROG.esercizio= p.esercizio(+) AND
 PROG.cd_dipartimento= p.cd_dipartimento (+) and
 --Join tra PDG_MODULO_SPESE e V_CLASSIFICAZIONE_VOCI
       PDG_SPE.ID_CLASSIFICAZIONE = CLA.ID_CLASSIFICAZIONE And
--Join tra PDG_MODULO_SPESE e AREA (UNITA_ORGANIZZATIVA)
       CLA.CDR_ACCENTRATORE Is Not Null And
       CLA.CDR_ACCENTRATORE = CDR.CD_CENTRO_RESPONSABILITA And
--Join tra CDR e UNITA_ORGANIZZATIVA
       CDR.CD_UNITA_ORGANIZZATIVA = UNITA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA And
--Join tra PDG_MODULO_SPESE e MODULO (PROGETTO)
       PDG_SPE.PG_PROGETTO = MODU.PG_PROGETTO And
       MODU.ESERCIZIO = PDG_SPE.ESERCIZIO And
--Join tra MODULO e COMMESSA (PROGETTO)
       MODU.ESERCIZIO_PROGETTO_PADRE = COMM.ESERCIZIO And
       MODU.PG_PROGETTO_PADRE = COMM.PG_PROGETTO And
--Join tra COMMESSA e PROGETTO
       COMM.ESERCIZIO_PROGETTO_PADRE = PROG.ESERCIZIO And
       COMM.PG_PROGETTO_PADRE = PROG.PG_PROGETTO And
       Nvl(CLA.CDR_ACCENTRATORE, 'xxx') != CNRCTB020.getCdCDRPersonale(PDG_SPE.ESERCIZIO)
Union All -- TRATTAMENTO ECONOMICO DEL PERSONALE
Select PDG_SPE.ESERCIZIO,
      Decode(unita_organizzativa.CD_TIPO_UNITA, 'SAC', '13',to_char(nvl(p.peso,1000))) PESO_DIP,
       Decode(unita_organizzativa.CD_TIPO_UNITA, 'SAC', 'SAC',Nvl(prog.cd_dipartimento, Null)) CD_DIPARTIMENTO,
       UNITA_ORGANIZZATIVA.CD_UNITA_PADRE CD_CENTRO_SPESA,
       UNITA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA,
       CLA.CDR_ACCENTRATORE CD_CENTRO_RESPONSABILITA,
       PDG_SPE.CD_CENTRO_RESPONSABILITA CD_CDR_ORIGINE_FONDI,
       CD_CLASSIFICAZIONE,
       NR_LIVELLO,
       CD_LIVELLO1, CD_LIVELLO2, CD_LIVELLO3, CD_LIVELLO4, CD_LIVELLO5,  CD_LIVELLO6, CD_LIVELLO7,
       MODU.PG_PROGETTO PG_MODULO, MODU.CD_PROGETTO CD_MODULO, MODU.CD_TIPO_PROGETTO CD_TIPO_MODULO,
       COMM.PG_PROGETTO PG_COMMESSA, COMM.CD_PROGETTO CD_COMMESSA,
       PROG.PG_PROGETTO, PROG.CD_PROGETTO,
       0  IM_DEC_IST_INT,
       0  IM_DEC_IST_EST,
       0  IM_DEC_AREA_INT,
       0  IM_DEC_AREA_EST,
       Nvl(PDG_SPE.IM_SPESE_GEST_ACCENTRATA_INT, 0) +
       Decode(unita_organizzativa.CD_TIPO_UNITA, 'SAC',
                 Nvl(PDG_SPE.IM_SPESE_GEST_DECENTRATA_INT, 0), 0) TRATT_ECON_INT,
       Nvl(PDG_SPE.IM_SPESE_GEST_ACCENTRATA_EST, 0) +
       Decode(unita_organizzativa.CD_TIPO_UNITA, 'SAC',
                 Nvl(PDG_SPE.IM_SPESE_GEST_DECENTRATA_EST, 0), 0) TRATT_ECON_EST,
       0  IM_ACC_ALTRE_SP_INT,
       0  IM_PREV_A2,
       0  IM_PREV_A3
From   PDG_MODULO_SPESE PDG_SPE,
       V_CLASSIFICAZIONE_VOCI CLA,
       UNITA_ORGANIZZATIVA,
       CDR,
       PROGETTO_PREV MODU,
       PROGETTO_PREV COMM,
       PROGETTO_PREV PROG,
	dipartimento_peso p
Where
 PROG.esercizio= p.esercizio(+) AND
 PROG.cd_dipartimento= p.cd_dipartimento (+) and
  --Join tra PDG_MODULO_SPESE e V_CLASSIFICAZIONE_VOCI
       PDG_SPE.ID_CLASSIFICAZIONE = CLA.ID_CLASSIFICAZIONE And
--Join tra PDG_MODULO_SPESE e AREA (UNITA_ORGANIZZATIVA)
       CLA.CDR_ACCENTRATORE Is Not Null And
       CLA.CDR_ACCENTRATORE = CDR.CD_CENTRO_RESPONSABILITA And
--Join tra CDR e UNITA_ORGANIZZATIVA
       CDR.CD_UNITA_ORGANIZZATIVA = UNITA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA And
--Join tra PDG_MODULO_SPESE e MODULO (PROGETTO)
       PDG_SPE.PG_PROGETTO = MODU.PG_PROGETTO And
       MODU.ESERCIZIO = PDG_SPE.ESERCIZIO And
--Join tra MODULO e COMMESSA (PROGETTO)
       MODU.ESERCIZIO_PROGETTO_PADRE = COMM.ESERCIZIO And
       MODU.PG_PROGETTO_PADRE = COMM.PG_PROGETTO And
--Join tra COMMESSA e PROGETTO
       COMM.ESERCIZIO_PROGETTO_PADRE = PROG.ESERCIZIO And
       COMM.PG_PROGETTO_PADRE = PROG.PG_PROGETTO And
       Nvl(CLA.CDR_ACCENTRATORE, 'xxx') = CNRCTB020.getCdCDRPersonale(PDG_SPE.ESERCIZIO)
Union All -- ANNO 2 E 3
Select PDG_SPE.ESERCIZIO,
      Decode(unita_organizzativa.CD_TIPO_UNITA, 'SAC', '13',to_char(nvl(p.peso,1000))) PESO_DIP,
       Decode(unita_organizzativa.CD_TIPO_UNITA, 'SAC', 'SAC',Nvl(prog.cd_dipartimento, Null)) CD_DIPARTIMENTO,
       UNITA_ORGANIZZATIVA.CD_UNITA_PADRE CD_CENTRO_SPESA,
       UNITA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA CD_UNITA_ORGANIZZATIVA,
       PDG_SPE.CD_CENTRO_RESPONSABILITA,
       PDG_SPE.CD_CENTRO_RESPONSABILITA CD_CDR_ORIGINE_FONDI,
       CD_CLASSIFICAZIONE,
       NR_LIVELLO,
       CD_LIVELLO1, CD_LIVELLO2, CD_LIVELLO3, CD_LIVELLO4, CD_LIVELLO5,  CD_LIVELLO6, CD_LIVELLO7,
       MODU.PG_PROGETTO PG_MODULO, MODU.CD_PROGETTO CD_MODULO, MODU.CD_TIPO_PROGETTO CD_TIPO_MODULO,
       COMM.PG_PROGETTO PG_COMMESSA, COMM.CD_PROGETTO CD_COMMESSA,
       PROG.PG_PROGETTO, PROG.CD_PROGETTO,
       0  IM_DEC_IST_INT,
       0  IM_DEC_IST_EST,
       0  IM_DEC_AREA_INT,
       0  IM_DEC_AREA_EST,
       0  TRATT_ECON_INT,
       0  TRATT_ECON_EST,
       0  IM_ACC_ALTRE_SP_INT,
       Nvl(PDG_SPE.IM_SPESE_A2, 0) IM_PREV_A2,
       Nvl(PDG_SPE.IM_SPESE_A3, 0) IM_PREV_A3
From   PDG_MODULO_SPESE PDG_SPE,
       V_CLASSIFICAZIONE_VOCI CLA,
       UNITA_ORGANIZZATIVA,
       CDR,
       PROGETTO_PREV MODU,
       PROGETTO_PREV COMM,
       PROGETTO_PREV PROG,
	dipartimento_peso p
Where
 PROG.esercizio= p.esercizio(+) AND
 PROG.cd_dipartimento= p.cd_dipartimento (+) and
 --Join tra PDG_MODULO_SPESE e V_CLASSIFICAZIONE_VOCI
       PDG_SPE.ID_CLASSIFICAZIONE = CLA.ID_CLASSIFICAZIONE And
--Join tra PDG_MODULO_SPESE e CDR
       PDG_SPE.CD_CENTRO_RESPONSABILITA = CDR.CD_CENTRO_RESPONSABILITA And
--Join tra CDR e UNITA_ORGANIZZATIVA
       CDR.CD_UNITA_ORGANIZZATIVA = UNITA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA And
--Join tra PDG_MODULO_SPESE e MODULO (PROGETTO)
       PDG_SPE.PG_PROGETTO = MODU.PG_PROGETTO And
       MODU.ESERCIZIO = PDG_SPE.ESERCIZIO And
--Join tra MODULO e COMMESSA (PROGETTO)
       MODU.ESERCIZIO_PROGETTO_PADRE = COMM.ESERCIZIO And
       MODU.PG_PROGETTO_PADRE = COMM.PG_PROGETTO And
--Join tra COMMESSA e PROGETTO
       COMM.ESERCIZIO_PROGETTO_PADRE = PROG.ESERCIZIO And
       COMM.PG_PROGETTO_PADRE = PROG.PG_PROGETTO)
Group By ESERCIZIO, PESO_DIP, CD_DIPARTIMENTO, CD_CENTRO_SPESA, CD_UNITA_ORGANIZZATIVA,
         CD_CENTRO_RESPONSABILITA, CD_CDR_ORIGINE_FONDI, CD_CLASSIFICAZIONE, NR_LIVELLO,
         CD_LIVELLO1, CD_LIVELLO2, CD_LIVELLO3, CD_LIVELLO4, CD_LIVELLO5, CD_LIVELLO6, CD_LIVELLO7,
         PG_MODULO, CD_MODULO, CD_TIPO_MODULO, PG_COMMESSA, CD_COMMESSA, PG_PROGETTO, CD_PROGETTO;
