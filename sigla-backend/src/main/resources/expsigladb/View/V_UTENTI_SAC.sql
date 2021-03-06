--------------------------------------------------------
--  DDL for View V_UTENTI_SAC
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_UTENTI_SAC" ("CD_UTENTE", "CD_RUOLO", "CD_UNITA_ORGANIZZATIVA", "DT_INIZIO_VALIDITA", "DT_FINE_VALIDITA", "DS_UTENTE", "CD_GESTORE", "CD_CDR", "FL_PASSWORD_CHANGE", "DT_ULTIMA_VAR_PASSWORD", "TI_UTENTE", "NOME", "COGNOME", "INDIRIZZO", "CD_UTENTE_TEMPL", "FL_UTENTE_TEMPL") AS 
  SELECT  
--
--  
UTENTE.CD_UTENTE,
UTENTE_UNITA_RUOLO.CD_RUOLO,
UTENTE_UNITA_RUOLO.CD_UNITA_ORGANIZZATIVA,
UTENTE.DT_INIZIO_VALIDITA, 
UTENTE.DT_FINE_VALIDITA,   
UTENTE.DS_UTENTE,  
UTENTE.CD_GESTORE,  
UTENTE.CD_CDR,  
UTENTE.FL_PASSWORD_CHANGE, 
UTENTE.DT_ULTIMA_VAR_PASSWORD, 
UTENTE.TI_UTENTE,  
UTENTE.NOME,  
UTENTE.COGNOME,  
UTENTE.INDIRIZZO,  
UTENTE.CD_UTENTE_TEMPL,  
UTENTE.FL_UTENTE_TEMPL
FROM  
UTENTE,
UTENTE_UNITA_RUOLO  
WHERE
UTENTE.CD_UTENTE =  UTENTE_UNITA_RUOLO.CD_UTENTE 
AND TO_CHAR ( dt_fine_validita ,'yyyy/mm/dd' ) > '2006/01/01'
AND SUBSTR (UTENTE_UNITA_RUOLO.cd_unita_organizzativa, 1,3) =  '000'
--
UNION
SELECT  
--
--  
UTENTE.CD_UTENTE,
UTENTE_UNITA_RUOLO.CD_RUOLO,
UTENTE_UNITA_RUOLO.CD_UNITA_ORGANIZZATIVA,
UTENTE.DT_INIZIO_VALIDITA, 
UTENTE.DT_FINE_VALIDITA,   
UTENTE.DS_UTENTE,  
UTENTE.CD_GESTORE,  
UTENTE.CD_CDR,  
UTENTE.FL_PASSWORD_CHANGE, 
UTENTE.DT_ULTIMA_VAR_PASSWORD, 
UTENTE.TI_UTENTE,  
UTENTE.NOME,  
UTENTE.COGNOME,  
UTENTE.INDIRIZZO,  
UTENTE.CD_UTENTE_TEMPL,  
UTENTE.FL_UTENTE_TEMPL
FROM  
UTENTE,
UTENTE_UNITA_RUOLO  
WHERE
UTENTE.CD_UTENTE =  UTENTE_UNITA_RUOLO.CD_UTENTE 
AND TO_CHAR ( dt_fine_validita ,'yyyy/mm/dd' ) > '2006/01/01'
AND SUBSTR (UTENTE_UNITA_RUOLO.cd_unita_organizzativa, 1,3) =  '999'
--
UNION
SELECT  
--
--  
UTENTE.CD_UTENTE,
NULL,
NULL,
UTENTE.DT_INIZIO_VALIDITA, 
UTENTE.DT_FINE_VALIDITA,   
UTENTE.DS_UTENTE,  
UTENTE.CD_GESTORE,  
UTENTE.CD_CDR,  
UTENTE.FL_PASSWORD_CHANGE, 
UTENTE.DT_ULTIMA_VAR_PASSWORD, 
UTENTE.TI_UTENTE,  
UTENTE.NOME,  
UTENTE.COGNOME,  
UTENTE.INDIRIZZO,  
UTENTE.CD_UTENTE_TEMPL,  
UTENTE.FL_UTENTE_TEMPL
FROM  
UTENTE
WHERE
TO_CHAR ( dt_fine_validita ,'yyyy/mm/dd' ) > '2006/01/01'
AND UTENTE.CD_GESTORE = 'CDS000'
AND cd_utente NOT IN (SELECT cd_utente FROM UTENTE_UNITA_RUOLO)
UNION
SELECT  
--
--  
UTENTE.CD_UTENTE,
NULL,
NULL,
UTENTE.DT_INIZIO_VALIDITA, 
UTENTE.DT_FINE_VALIDITA,   
UTENTE.DS_UTENTE,  
UTENTE.CD_GESTORE,  
UTENTE.CD_CDR,  
UTENTE.FL_PASSWORD_CHANGE, 
UTENTE.DT_ULTIMA_VAR_PASSWORD, 
UTENTE.TI_UTENTE,  
UTENTE.NOME,  
UTENTE.COGNOME,  
UTENTE.INDIRIZZO,  
UTENTE.CD_UTENTE_TEMPL,  
UTENTE.FL_UTENTE_TEMPL
FROM  
UTENTE
WHERE
TO_CHAR ( dt_fine_validita ,'yyyy/mm/dd' ) > '2006/01/01'
AND UTENTE.CD_GESTORE = 'CNRTUTTO'
AND cd_utente NOT IN (SELECT cd_utente FROM UTENTE_UNITA_RUOLO)
ORDER BY 1
;
