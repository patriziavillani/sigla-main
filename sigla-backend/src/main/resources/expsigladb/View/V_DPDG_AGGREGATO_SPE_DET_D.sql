--------------------------------------------------------
--  DDL for View V_DPDG_AGGREGATO_SPE_DET_D
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_DPDG_AGGREGATO_SPE_DET_D" ("ESERCIZIO", "CD_CENTRO_RESPONSABILITA", "CD_CDS", "TI_APPARTENENZA", "TI_GESTIONE", "CD_ELEMENTO_VOCE", "TI_AGGREGATO", "CD_FUNZIONE", "CD_NATURA", "IM_RH_CCS_COSTI", "IM_RI_CCS_SPESE_ODC", "IM_RJ_CCS_SPESE_ODC_ALTRA_UO", "IM_RK_CCS_SPESE_OGC", "IM_RL_CCS_SPESE_OGC_ALTRA_UO", "IM_RM_CSS_AMMORTAMENTI", "IM_RN_CSS_RIMANENZE", "IM_RO_CSS_ALTRI_COSTI", "IM_RP_CSS_VERSO_ALTRO_CDR", "IM_RQ_SSC_COSTI_ODC", "IM_RR_SSC_COSTI_ODC_ALTRA_UO", "IM_RS_SSC_COSTI_OGC", "IM_RT_SSC_COSTI_OGC_ALTRA_UO", "IM_RU_SPESE_COSTI_ALTRUI", "IM_RV_PAGAMENTI", "IM_RAA_A2_COSTI_FINALI", "IM_RAB_A2_COSTI_ALTRO_CDR", "IM_RAC_A2_SPESE_ODC", "IM_RAD_A2_SPESE_ODC_ALTRA_UO", "IM_RAE_A2_SPESE_OGC", "IM_RAF_A2_SPESE_OGC_ALTRA_UO", "IM_RAG_A2_SPESE_COSTI_ALTRUI", "IM_RAH_A3_COSTI_FINALI", "IM_RAI_A3_COSTI_ALTRO_CDR", "IM_RAL_A3_SPESE_ODC", "IM_RAM_A3_SPESE_ODC_ALTRA_UO", "IM_RAN_A3_SPESE_OGC", "IM_RAO_A3_SPESE_OGC_ALTRA_UO", "IM_RAP_A3_SPESE_COSTI_ALTRUI", "DACR", "UTCR", "DUVA", "UTUV", "PG_VER_REC") AS 
  ( 
select 
-- 
-- Date: 20/01/2002 
-- Version: 1.4 
-- 
-- Ritorna le righe aggregato del PDG di un dato CDR che non soddisfano alla condizione di contrattazione con il centro 
-- 
-- History: 
-- 
-- Date: 15/09/2001 
-- Version: 1.0 
-- Creazione 
-- Date: 22/10/2001 
-- Version: 1.1 
-- Aggiunto ti_aggregato ='D' per compatibilita con PDG_AGGREGATO_SPE_DET 
-- 
-- Date: 24/12/2001 
-- Version: 1.2 
-- Nuova gestione iterativa delle aggregazioni con span sui parametri 
-- 
-- Date: 18/01/2002 
-- Version: 1.3 
-- Non si considerano le differenze sulle colonne dei pagamenti (V) e spese per costi altrui (U) 
-- 
-- Date: 20/01/2002 
-- Version: 1.4 
-- Non si considerano le differenze sulle colonne dei spese costi altrui pluriennali (AG AP) 
--
-- Body: 
-- 
R.ESERCIZIO 
,R.CD_CENTRO_RESPONSABILITA 
,R.CD_CDS 
,R.ti_appartenenza 
,R.ti_gestione 
,R.cd_elemento_voce 
,'D' 
,R.CD_FUNZIONE 
,R.CD_NATURA 
,R.IM_RH_CCS_COSTI-V.IM_RH_CCS_COSTI 
,R.IM_RI_CCS_SPESE_ODC-V.IM_RI_CCS_SPESE_ODC 
,R.IM_RJ_CCS_SPESE_ODC_ALTRA_UO-V.IM_RJ_CCS_SPESE_ODC_ALTRA_UO 
,R.IM_RK_CCS_SPESE_OGC-V.IM_RK_CCS_SPESE_OGC 
,R.IM_RL_CCS_SPESE_OGC_ALTRA_UO-V.IM_RL_CCS_SPESE_OGC_ALTRA_UO 
,R.IM_RM_CSS_AMMORTAMENTI-V.IM_RM_CSS_AMMORTAMENTI 
,R.IM_RN_CSS_RIMANENZE-V.IM_RN_CSS_RIMANENZE 
,R.IM_RO_CSS_ALTRI_COSTI-V.IM_RO_CSS_ALTRI_COSTI 
,R.IM_RP_CSS_VERSO_ALTRO_CDR-V.IM_RP_CSS_VERSO_ALTRO_CDR 
,R.IM_RQ_SSC_COSTI_ODC-V.IM_RQ_SSC_COSTI_ODC 
,R.IM_RR_SSC_COSTI_ODC_ALTRA_UO-V.IM_RR_SSC_COSTI_ODC_ALTRA_UO 
,R.IM_RS_SSC_COSTI_OGC-V.IM_RS_SSC_COSTI_OGC 
,R.IM_RT_SSC_COSTI_OGC_ALTRA_UO-V.IM_RT_SSC_COSTI_OGC_ALTRA_UO 
,0 -- su queste colonne non si effettua contrattazione 
,0 -- su queste colonne non si effettua contrattazione 
,R.IM_RAA_A2_COSTI_FINALI-V.IM_RAA_A2_COSTI_FINALI 
,R.IM_RAB_A2_COSTI_ALTRO_CDR-V.IM_RAB_A2_COSTI_ALTRO_CDR 
,R.IM_RAC_A2_SPESE_ODC-V.IM_RAC_A2_SPESE_ODC 
,R.IM_RAD_A2_SPESE_ODC_ALTRA_UO-V.IM_RAD_A2_SPESE_ODC_ALTRA_UO 
,R.IM_RAE_A2_SPESE_OGC-V.IM_RAE_A2_SPESE_OGC 
,R.IM_RAF_A2_SPESE_OGC_ALTRA_UO-V.IM_RAF_A2_SPESE_OGC_ALTRA_UO 
,0 -- su queste colonne non si effettua contrattazione 
,R.IM_RAH_A3_COSTI_FINALI-V.IM_RAH_A3_COSTI_FINALI 
,R.IM_RAI_A3_COSTI_ALTRO_CDR-V.IM_RAI_A3_COSTI_ALTRO_CDR 
,R.IM_RAL_A3_SPESE_ODC-V.IM_RAL_A3_SPESE_ODC 
,R.IM_RAM_A3_SPESE_ODC_ALTRA_UO-V.IM_RAM_A3_SPESE_ODC_ALTRA_UO 
,R.IM_RAN_A3_SPESE_OGC-V.IM_RAN_A3_SPESE_OGC 
,R.IM_RAO_A3_SPESE_OGC_ALTRA_UO-V.IM_RAO_A3_SPESE_OGC_ALTRA_UO 
,0 -- su queste colonne non si effettua contrattazione 
,NULL 
,NULL 
,NULL 
,NULL 
,0 
from 
 PDG_AGGREGATO_SPE_DET R -- Aggregato attuale 
,PDG_AGGREGATO_SPE_DET V -- Aggregato contrattato 
where 
    V.esercizio = R.esercizio 
and V.cd_centro_responsabilita = R.cd_centro_responsabilita 
and V.ti_appartenenza = R.ti_appartenenza 
and V.ti_gestione = R.ti_gestione 
and V.cd_elemento_voce = R.cd_elemento_voce 
and V.cd_funzione = R.cd_funzione 
and V.cd_natura = R.cd_natura 
and V.cd_cds = R.cd_cds 
and V.ti_aggregato = 'M' 
and R.ti_aggregato = 'I' 
and ( 
   R.IM_RH_CCS_COSTI!=V.IM_RH_CCS_COSTI 
or R.IM_RI_CCS_SPESE_ODC!=V.IM_RI_CCS_SPESE_ODC 
or R.IM_RJ_CCS_SPESE_ODC_ALTRA_UO!=V.IM_RJ_CCS_SPESE_ODC_ALTRA_UO 
or R.IM_RK_CCS_SPESE_OGC!=V.IM_RK_CCS_SPESE_OGC 
or R.IM_RL_CCS_SPESE_OGC_ALTRA_UO!=V.IM_RL_CCS_SPESE_OGC_ALTRA_UO 
or R.IM_RM_CSS_AMMORTAMENTI!=V.IM_RM_CSS_AMMORTAMENTI 
or R.IM_RN_CSS_RIMANENZE!=V.IM_RN_CSS_RIMANENZE 
or R.IM_RO_CSS_ALTRI_COSTI!=V.IM_RO_CSS_ALTRI_COSTI 
or R.IM_RP_CSS_VERSO_ALTRO_CDR!=V.IM_RP_CSS_VERSO_ALTRO_CDR 
or R.IM_RQ_SSC_COSTI_ODC!=V.IM_RQ_SSC_COSTI_ODC 
or R.IM_RR_SSC_COSTI_ODC_ALTRA_UO!=V.IM_RR_SSC_COSTI_ODC_ALTRA_UO 
or R.IM_RS_SSC_COSTI_OGC!=V.IM_RS_SSC_COSTI_OGC 
or R.IM_RT_SSC_COSTI_OGC_ALTRA_UO!=V.IM_RT_SSC_COSTI_OGC_ALTRA_UO 
or R.IM_RAA_A2_COSTI_FINALI!=V.IM_RAA_A2_COSTI_FINALI 
or R.IM_RAB_A2_COSTI_ALTRO_CDR!=V.IM_RAB_A2_COSTI_ALTRO_CDR 
or R.IM_RAC_A2_SPESE_ODC!=V.IM_RAC_A2_SPESE_ODC 
or R.IM_RAD_A2_SPESE_ODC_ALTRA_UO!=V.IM_RAD_A2_SPESE_ODC_ALTRA_UO 
or R.IM_RAE_A2_SPESE_OGC!=V.IM_RAE_A2_SPESE_OGC 
or R.IM_RAF_A2_SPESE_OGC_ALTRA_UO!=V.IM_RAF_A2_SPESE_OGC_ALTRA_UO 
or R.IM_RAH_A3_COSTI_FINALI!=V.IM_RAH_A3_COSTI_FINALI 
or R.IM_RAI_A3_COSTI_ALTRO_CDR!=V.IM_RAI_A3_COSTI_ALTRO_CDR 
or R.IM_RAL_A3_SPESE_ODC!=V.IM_RAL_A3_SPESE_ODC 
or R.IM_RAM_A3_SPESE_ODC_ALTRA_UO!=V.IM_RAM_A3_SPESE_ODC_ALTRA_UO 
or R.IM_RAN_A3_SPESE_OGC!=V.IM_RAN_A3_SPESE_OGC 
or R.IM_RAO_A3_SPESE_OGC_ALTRA_UO!=V.IM_RAO_A3_SPESE_OGC_ALTRA_UO 
) 
);

   COMMENT ON TABLE "V_DPDG_AGGREGATO_SPE_DET_D"  IS 'Ritorna le righe aggregato del PDG di un dato CDR che non soddisfano alla condizione di contrattazione con il centro';
