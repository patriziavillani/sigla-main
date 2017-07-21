package it.cnr.contab.ordmag.ordini.comp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Serializable;
import java.math.BigDecimal;
import java.rmi.RemoteException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.chemistry.opencmis.client.api.Document;
import org.apache.chemistry.opencmis.commons.exceptions.CmisContentAlreadyExistsException;

import it.cnr.contab.anagraf00.core.bulk.TerzoBulk;
import it.cnr.contab.anagraf00.core.bulk.TerzoHome;
import it.cnr.contab.cmis.MimeTypes;
import it.cnr.contab.cmis.bulk.CMISFile;
import it.cnr.contab.cmis.service.CMISPath;
import it.cnr.contab.config00.bulk.CigBulk;
import it.cnr.contab.config00.contratto.bulk.ContrattoBulk;
import it.cnr.contab.config00.contratto.bulk.Procedure_amministrativeBulk;
import it.cnr.contab.config00.contratto.bulk.Tipo_atto_amministrativoBulk;
import it.cnr.contab.config00.sto.bulk.Unita_organizzativa_enteBulk;
import it.cnr.contab.config00.sto.bulk.V_struttura_organizzativaBulk;
import it.cnr.contab.config00.sto.bulk.V_struttura_organizzativaHome;
import it.cnr.contab.docamm00.tabrif.bulk.Bene_servizioBulk;
import it.cnr.contab.docamm00.tabrif.bulk.Bene_servizioHome;
import it.cnr.contab.docamm00.tabrif.bulk.DivisaBulk;
import it.cnr.contab.docamm00.tabrif.bulk.Voce_ivaBulk;
import it.cnr.contab.docamm00.tabrif.bulk.Voce_ivaHome;
import it.cnr.contab.incarichi00.tabrif.bulk.Tipo_norma_perlaBulk;
import it.cnr.contab.ordmag.anag00.AbilUtenteUopOperBulk;
import it.cnr.contab.ordmag.anag00.AbilUtenteUopOperHome;
import it.cnr.contab.ordmag.anag00.LuogoConsegnaMagBulk;
import it.cnr.contab.ordmag.anag00.LuogoConsegnaMagHome;
import it.cnr.contab.ordmag.anag00.MagazzinoBulk;
import it.cnr.contab.ordmag.anag00.MagazzinoHome;
import it.cnr.contab.ordmag.anag00.NumerazioneOrdBulk;
import it.cnr.contab.ordmag.anag00.NumerazioneOrdHome;
import it.cnr.contab.ordmag.anag00.TipoOperazioneOrdBulk;
import it.cnr.contab.ordmag.anag00.UnitaMisuraBulk;
import it.cnr.contab.ordmag.anag00.UnitaMisuraHome;
import it.cnr.contab.ordmag.anag00.UnitaOperativaOrdBulk;
import it.cnr.contab.ordmag.anag00.UnitaOperativaOrdHome;
import it.cnr.contab.ordmag.ejb.NumeratoriOrdMagComponentSession;
import it.cnr.contab.ordmag.ordini.bulk.AllegatoOrdineBulk;
import it.cnr.contab.ordmag.ordini.bulk.OrdineAcqBulk;
import it.cnr.contab.ordmag.ordini.bulk.OrdineAcqConsegnaBulk;
import it.cnr.contab.ordmag.ordini.bulk.OrdineAcqHome;
import it.cnr.contab.ordmag.ordini.bulk.OrdineAcqRigaBulk;
import it.cnr.contab.ordmag.ordini.service.OrdineAcqCMISService;
import it.cnr.contab.reports.bulk.Print_spoolerBulk;
import it.cnr.contab.reports.bulk.Report;
import it.cnr.contab.reports.service.PrintService;
import it.cnr.contab.service.SpringUtil;
import it.cnr.contab.utenze00.bp.CNRUserContext;
import it.cnr.jada.UserContext;
import it.cnr.jada.bulk.OggettoBulk;
import it.cnr.jada.comp.ApplicationException;
import it.cnr.jada.comp.ComponentException;
import it.cnr.jada.comp.GenerazioneReportException;
import it.cnr.jada.comp.ICRUDMgr;
import it.cnr.jada.persistency.PersistencyException;
import it.cnr.jada.persistency.sql.CompoundFindClause;
import it.cnr.jada.persistency.sql.FindClause;
import it.cnr.jada.persistency.sql.Query;
import it.cnr.jada.persistency.sql.SQLBuilder;

public class OrdineAcqComponent
	extends it.cnr.jada.comp.CRUDComponent
	implements ICRUDMgr,Cloneable,Serializable {

	public final static String TIPO_TOTALE_COMPLETO = "C";
	public final static String TIPO_TOTALE_PARZIALE = "P";
	
    public  OrdineAcqComponent()
    {

        /*Default constructor*/


    }
    
	private void assegnaProgressivo(UserContext userContext,OrdineAcqBulk ordine) throws ComponentException {

	try {
		// Assegno un nuovo progressivo al documento
		NumeratoriOrdMagComponentSession progressiviSession = (NumeratoriOrdMagComponentSession) it.cnr.jada.util.ejb.EJBCommonServices.createEJB("CNRORDMAG_EJB_NumeratoriOrdMagComponentSession", NumeratoriOrdMagComponentSession.class);
		NumerazioneOrdBulk numerazione = new NumerazioneOrdBulk(ordine.getCdUnitaOperativa(), ordine.getEsercizio(), ordine.getCdNumeratore());
		ordine.setNumero(progressiviSession.getNextPG(userContext, numerazione));
	} catch (Throwable t) {
		throw handleException(ordine, t);
	}
}
public OggettoBulk creaConBulk(UserContext userContext,OggettoBulk bulk) throws ComponentException {

	return creaConBulk(userContext, bulk, null);
}
////^^@@
///** 
//  *  Creazione di un nuovo documento
//  *	 Validazioni superate
//  *    PreCondition:
//  *      Viene richiesto il salvataggio di un nuovo documento
//  *    PostCondition:
//  *      Salva.
//  *  Validazioni non superate
//  *    PreCondition:
//  *      Viene richiesto il salvataggio di un nuovo documento ma le validazioni
//  *      non vengono superate
//  *    PostCondition:
//  *      Informa l'utente della causa per la quale non � possibile salvare
// */
////^^@@
	public it.cnr.jada.bulk.OggettoBulk creaConBulk(it.cnr.jada.UserContext userContext, it.cnr.jada.bulk.OggettoBulk bulk, it.cnr.contab.doccont00.core.bulk.OptionRequestParameter status)
			throws it.cnr.jada.comp.ComponentException {

		OrdineAcqBulk ordine= (OrdineAcqBulk) bulk;
//			//assegna un progressivo al documento all'atto della creazione.
		validaOrdine(userContext, ordine);
		assegnaProgressivo(userContext, ordine);
		ordine = (OrdineAcqBulk)super.creaConBulk(userContext, ordine);
		return ordine;
	}

	private void validaOrdine(it.cnr.jada.UserContext userContext, OrdineAcqBulk ordine) throws it.cnr.jada.comp.ComponentException{
		if (ordine.getRigheOrdineColl() == null || ordine.getRigheOrdineColl().size() == 0){
			throw new ApplicationException ("Non � possibile salvare un ordine senza dettagli.");
		}
    	for (java.util.Iterator i= ordine.getRigheOrdineColl().iterator(); i.hasNext();) {
    		OrdineAcqRigaBulk riga = (OrdineAcqRigaBulk) i.next();
    		if (riga != null){
//    			if (riga.getCdElementoVoce() != null && riga.getCdCategoriaGruppo() != null){
//    				Elemento_voceHome home = (Elemento_voceHome)getHome(userContext, Elemento_voceBulk.class,"V_ELEMENTO_VOCE_ORDINI");
//    				SQLBuilder sql = home.createSQLBuilder();
//    				
//    				sql.addSQLClause("AND", "V_ELEMENTO_VOCE_ORDINI.ESERCIZIO", sql.EQUALS, it.cnr.contab.utenze00.bp.CNRUserContext.getEsercizio( userContext ) );
//    				sql.addSQLClause("AND", "V_ELEMENTO_VOCE_ORDINI.CD_CATEGORIA_GRUPPO_INVENT", sql.EQUALS, riga.getCdCategoriaGruppo());
//    				sql.addSQLClause("AND", "V_ELEMENTO_VOCE_ORDINI.CD_ELEMENTO_VOCE", sql.EQUALS, riga.getCdElementoVoce());
//    				
//    				List list;
//					try {
//						list = home.fetchAll(sql);
//					} catch (PersistencyException e) {
//						throw new ComponentException(e);
//					}
//    				if (list == null || list.size() == 0){
//        				throw new ApplicationException ("Sulla riga numero "+riga.getRiga()+" � stata indicata una voce di bilancio non utilizzabile per "+riga.getCdBeneServizio());
//    				}
//    			}
//    			String value = null;
//    			if (richiesta.isDefinitivaOInviata() && riga.getCdElementoVoce() == null){
//        			try {
//        				value = Utility.createConfigurazioneCnrComponentSession().getConfigurazione( userContext, richiesta.getEsercizio(), null, Configurazione_cnrBulk.PK_OBBLIGATORIETA_ORDINI, Configurazione_cnrBulk.SK_VOCE_RICHIESTA).getVal01();
//        			} catch (RemoteException e) {
//        				throw new ComponentException(e);
//        			} catch (EJBException e) {
//        				throw new ComponentException(e);
//        			}
//        			if (value!= null && value.equals("Y")){
//        				throw new ApplicationException ("Sulla riga numero "+riga.getRiga()+" � necessario indicare la voce di bilancio.");
//        			}
//    			} 
//    			if (richiesta.isDefinitivaOInviata() && riga.getProgetto() == null || riga.getProgetto().getPg_progetto() == null){
//    				value = null;
//    				try {
//        				value = Utility.createConfigurazioneCnrComponentSession().getConfigurazione( userContext, richiesta.getEsercizio(), null, Configurazione_cnrBulk.PK_OBBLIGATORIETA_ORDINI, Configurazione_cnrBulk.SK_PROGETTO_RICHIESTA).getVal01();
//        			} catch (RemoteException e) {
//        				throw new ComponentException(e);
//        			} catch (EJBException e) {
//        				throw new ComponentException(e);
//        			}
//        			if (value!= null && value.equals("Y")){
//        				throw new ApplicationException ("Sulla riga numero "+riga.getRiga()+" � necessario indicare il progetto.");
//        			}
//    			}
//    			if (richiesta.isDefinitivaOInviata() && riga.getCentroResponsabilita() == null || riga.getCentroResponsabilita().getCd_centro_responsabilita() == null || 
//    					riga.getLineaAttivita() == null || riga.getLineaAttivita().getCd_linea_attivita() == null){
//    				value = null;
//    				try {
//        				value = Utility.createConfigurazioneCnrComponentSession().getConfigurazione( userContext, richiesta.getEsercizio(), null, Configurazione_cnrBulk.PK_OBBLIGATORIETA_ORDINI, Configurazione_cnrBulk.SK_GAE_RICHIESTA).getVal01();
//        			} catch (RemoteException e) {
//        				throw new ComponentException(e);
//        			} catch (EJBException e) {
//        				throw new ComponentException(e);
//        			}
//        			if (value!= null && value.equals("Y")){
//            			if (riga.getCentroResponsabilita() == null || riga.getCentroResponsabilita().getCd_centro_responsabilita() == null){
//            				throw new ApplicationException ("Sulla riga numero "+riga.getRiga()+" � necessario indicare il CDR.");
//            			}
//            			if (riga.getLineaAttivita() == null || riga.getLineaAttivita().getCd_linea_attivita() == null){
//            				throw new ApplicationException ("Sulla riga numero "+riga.getRiga()+" � necessario indicare la GAE.");
//            			}
//        			}
//    			}
    		}
    	}
	}
	
public it.cnr.jada.bulk.OggettoBulk stampaConBulk(it.cnr.jada.UserContext aUC, it.cnr.jada.bulk.OggettoBulk bulk) throws it.cnr.jada.comp.ComponentException {

//	if (bulk instanceof Stampa_vpg_doc_genericoBulk)
//		validateBulkForPrint(aUC, (Stampa_vpg_doc_genericoBulk)bulk);
//	if (bulk instanceof Stampa_elenco_fattureVBulk)
//		validateBulkForPrint(aUC, (Stampa_elenco_fattureVBulk)bulk);
//	
//	/*if (bulk instanceof Stampa_docamm_per_voce_del_pianoVBulk) 
//		return  stampaConBulk(aUC, (Stampa_docamm_per_voce_del_pianoVBulk) bulk);*/
//	if (bulk instanceof Stampa_fat_pas_per_vpVBulk) 
//		return  stampaConBulk(aUC, (Stampa_fat_pas_per_vpVBulk) bulk);
	return bulk;

}

@Override
public OggettoBulk inizializzaBulkPerInserimento(UserContext usercontext, OggettoBulk oggettobulk)
		throws ComponentException {
	OggettoBulk oggetto = super.inizializzaBulkPerInserimento(usercontext, oggettobulk);
	return inizializzaBulk(usercontext, oggetto);
}

private OggettoBulk inizializzaBulk(UserContext usercontext, OggettoBulk oggetto) throws ComponentException {
	oggetto = inizializzaOrdine(usercontext, oggetto);
	return oggetto;
}

@Override
public OggettoBulk inizializzaBulkPerModifica(UserContext usercontext, OggettoBulk oggettobulk)
		throws ComponentException {
	OrdineAcqBulk ordine = (OrdineAcqBulk)super.inizializzaBulkPerModifica(usercontext, oggettobulk);

	ordine.setIsAbilitatoTuttiMagazzini(isAbilitatoTuttiMagazzini(usercontext, ordine));
	
	it.cnr.jada.bulk.BulkHome home= getHome(usercontext, OrdineAcqRigaBulk.class);
    it.cnr.jada.persistency.sql.SQLBuilder sql= home.createSQLBuilder();
    sql.addClause("AND", "numero", sql.EQUALS, ordine.getNumero());
    sql.addClause("AND", "cdCds", sql.EQUALS, ordine.getCdCds());
    sql.addClause("AND", "cdUnitaOperativa", sql.EQUALS, ordine.getCdUnitaOperativa());
    sql.addClause("AND", "esercizio", sql.EQUALS, ordine.getEsercizio());
    sql.addClause("AND", "cdNumeratore", sql.EQUALS, ordine.getCdNumeratore());
    try {
    	ordine.setRigheOrdineColl(new it.cnr.jada.bulk.BulkList(home.fetchAll(sql)));

    	for (java.util.Iterator i= ordine.getRigheOrdineColl().iterator(); i.hasNext();) {
    		OggettoBulk rigabulk= (OggettoBulk) i.next();
    		OrdineAcqRigaBulk riga= (OrdineAcqRigaBulk) rigabulk;
    		if (riga.getBeneServizio() != null){
    			Bene_servizioHome Home = (Bene_servizioHome)getHome(usercontext, Bene_servizioBulk.class);
    			Bene_servizioBulk bene = (Bene_servizioBulk)Home.findByPrimaryKey(new Bene_servizioBulk(riga.getCdBeneServizio()));
    			riga.setBeneServizio(bene);
    		}
    		if (riga.getUnitaMisura() != null){
    			UnitaMisuraHome Home = (UnitaMisuraHome)getHome(usercontext, UnitaMisuraBulk.class);
    			UnitaMisuraBulk um = (UnitaMisuraBulk)Home.findByPrimaryKey(new UnitaMisuraBulk(riga.getCdUnitaMisura()));
    			riga.setUnitaMisura(um);
    		}
//    		if (riga.getElementoVoce() != null){
//    			Elemento_voceHome Home = (Elemento_voceHome)getHome(usercontext, Elemento_voceBulk.class);
//    			Elemento_voceBulk elem_voce = (Elemento_voceBulk)Home.findByPrimaryKey(new Elemento_voceBulk(riga.getCdElementoVoce(), riga.getEsercizioVoce(), riga.getTiAppartenenza(), riga.getTiGestione()));
//    			riga.setElementoVoce(elem_voce);
//    		}
//    		if (riga.getCentroResponsabilita() != null){
//    			CdrHome Home = (CdrHome)getHome(usercontext, CdrBulk.class);
//    			CdrBulk cdr = (CdrBulk)Home.findByPrimaryKey(new CdrBulk(riga.getCdCentroResponsabilita()));
//    			riga.setCentroResponsabilita(cdr);
//    		}
//    		if (riga.getLineaAttivita() != null){
//    			WorkpackageHome Home = (WorkpackageHome)getHome(usercontext, WorkpackageBulk.class);
//    			WorkpackageBulk wp = (WorkpackageBulk)Home.findByPrimaryKey(new WorkpackageBulk(riga.getCdCentroResponsabilita(), riga.getCdLineaAttivita()));
//    			riga.setLineaAttivita(wp);
//    		}
//    		if (riga.getProgetto() != null){
//    			ProgettoHome Home = (ProgettoHome)getHome(usercontext, ProgettoBulk.class);
//    			ProgettoGestBulk prog = (ProgettoGestBulk)Home.findByPrimaryKey(new ProgettoGestBulk(riga.getPgProgetto()));
//    			riga.setpro(prog);
//    		}
//    		if (riga.getObbligazione() != null){
//    			ObbligazioneHome Home = (ObbligazioneHome)getHome(usercontext, ObbligazioneBulk.class);
//    			ObbligazioneBulk obbl = (ObbligazioneBulk)Home.findByPrimaryKey(new ObbligazioneBulk(riga.getCdCdsObbl(), riga.getEsercizioObbl(), riga.getEsercizioOrigObbl(), riga.getPgObbligazione()));
//    			riga.setObbligazione(obbl);
//    		}
//    		if (riga.getCategoriaGruppoInvent() != null){
//    			Categoria_gruppo_inventHome Home = (Categoria_gruppo_inventHome)getHome(usercontext, Categoria_gruppo_inventBulk.class);
//    			Categoria_gruppo_inventBulk cat = (Categoria_gruppo_inventBulk)Home.findByPrimaryKey(new Categoria_gruppo_inventBulk(riga.getCdCategoriaGruppo()));
//    			riga.setCategoriaGruppoInvent(cat);
//    		}
    	}

    } catch (PersistencyException e) {
    	throw handleException(e);
    }
        
	return inizializzaBulk(usercontext, (OggettoBulk)ordine);
}

@Override
public OggettoBulk inizializzaBulkPerRicerca(UserContext usercontext, OggettoBulk oggettobulk)
		throws ComponentException {
	oggettobulk = super.inizializzaBulkPerRicerca( usercontext, oggettobulk );
//	try
//		{
//			if ( oggettobulk instanceof ObbligazioneBulk)
//			{
//				ObbligazioneBulk obbligazione = (ObbligazioneBulk) bulk;
//				obbligazione.setCds( (CdsBulk) getHome( aUC, CdsBulk.class).findByPrimaryKey( new CdsBulk(((CNRUserContext) aUC).getCd_cds())));
//				obbligazione.setCd_cds_origine( ((CNRUserContext) aUC).getCd_cds() );
//			// if (!((ObbligazioneHome)getHome(aUC, obbligazione.getClass())).verificaStatoEsercizio(obbligazione))
//			//	throw handleException( new ApplicationException( "Non e' possibile creare obbligazioni: esercizio non ancora aperto!") );
//	   	
//				return super.inizializzaBulkPerRicerca( aUC, obbligazione );
//			}
//			else
//				return super.inizializzaBulkPerRicerca( aUC, bulk );		
//		}
//		catch ( it.cnr.jada.persistency.PersistencyException e )
//		{
//			throw handleException(bulk, e);
//		}
	return inizializzaBulk(usercontext, oggettobulk);
}

@Override
public OggettoBulk inizializzaBulkPerRicercaLibera(UserContext usercontext, OggettoBulk oggettobulk)
		throws ComponentException {
	OggettoBulk oggetto = super.inizializzaBulkPerRicercaLibera(usercontext, oggettobulk);
	return inizializzaOrdine(usercontext, oggetto);
}
//public SQLBuilder selectCentroResponsabilitaByClause(
//		UserContext userContext, RichiestaUopRigaBulk pdg, CdrBulk cdr,
//		CompoundFindClause clause) throws PersistencyException, ComponentException {
//
//	SQLBuilder sql = getHome(userContext, CdrBulk.class, "V_CDR_VALIDO").createSQLBuilder();
//	sql.addSQLClause("AND", "V_CDR_VALIDO.ESERCIZIO", SQLBuilder.EQUALS, CNRUserContext.getEsercizio(userContext));
//
//	if (!isCdrUo(userContext)){
//		sql.addSQLClause("AND","V_CDR_VALIDO.CD_CENTRO_RESPONSABILITA",SQLBuilder.EQUALS, CNRUserContext.getCd_cdr(userContext));
//	} else {
//		sql.addTableToHeader("V_STRUTTURA_ORGANIZZATIVA", "B");		
//		sql.addSQLJoin("V_CDR_VALIDO.ESERCIZIO", "B.ESERCIZIO");
//		sql.addSQLJoin("V_CDR_VALIDO.CD_UNITA_ORGANIZZATIVA", "B.CD_UNITA_ORGANIZZATIVA");
//		sql.addSQLJoin("V_CDR_VALIDO.CD_CENTRO_RESPONSABILITA", "B.CD_CENTRO_RESPONSABILITA");
//		sql.addSQLClause("AND", "B.CD_TIPO_LIVELLO", SQLBuilder.EQUALS, V_struttura_organizzativaHome.LIVELLO_CDR);
//		sql.addSQLClause("AND","B.CD_CDS",SQLBuilder.EQUALS, CNRUserContext.getCd_cds(userContext));
//		sql.addSQLClause("AND","B.CD_UNITA_ORGANIZZATIVA",SQLBuilder.EQUALS, CNRUserContext.getCd_unita_organizzativa(userContext));
//	}
//
//	if (clause != null)
//		sql.addClause(clause);
//	sql.addOrderBy("V_CDR_VALIDO.CD_CENTRO_RESPONSABILITA");
//	
//	return sql;
//}
//
protected Boolean isCdrUo(UserContext userContext) throws ComponentException, PersistencyException {
	V_struttura_organizzativaHome homeStr =(V_struttura_organizzativaHome)getHome(userContext, V_struttura_organizzativaBulk.class );
	SQLBuilder sqlStr =homeStr.createSQLBuilder();
	sqlStr.addSQLClause("AND","V_STRUTTURA_ORGANIZZATIVA.ESERCIZIO",SQLBuilder.EQUALS, CNRUserContext.getEsercizio(userContext));
	sqlStr.addSQLClause("AND","V_STRUTTURA_ORGANIZZATIVA.CD_CDS",SQLBuilder.EQUALS, CNRUserContext.getCd_cds(userContext));
	sqlStr.addSQLClause("AND","V_STRUTTURA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA",SQLBuilder.EQUALS, CNRUserContext.getCd_unita_organizzativa(userContext));
	sqlStr.addSQLClause("AND","V_STRUTTURA_ORGANIZZATIVA.CD_CENTRO_RESPONSABILITA",SQLBuilder.EQUALS, CNRUserContext.getCd_cdr(userContext));
	sqlStr.addSQLClause("AND", "V_STRUTTURA_ORGANIZZATIVA.CD_TIPO_LIVELLO", SQLBuilder.EQUALS, V_struttura_organizzativaHome.LIVELLO_CDR);
	sqlStr.addSQLClause("AND", "V_STRUTTURA_ORGANIZZATIVA.FL_CDR_UO", SQLBuilder.EQUALS, "Y");

	List listStr=homeStr.fetchAll(sqlStr);
	if (listStr != null && listStr.size() == 1){
		return true;
	} else {
		return false;
	}
}

//public SQLBuilder selectLinea_attivitaByClause (UserContext userContext, 
//		RichiestaUopRigaBulk dett,
//		WorkpackageBulk latt, 
//		CompoundFindClause clause) throws ComponentException, PersistencyException, RemoteException {	
//	SQLBuilder sql = getHome(userContext, latt, "V_LINEA_ATTIVITA_VALIDA").createSQLBuilder();
//
//	sql.addSQLClause(FindClause.AND,"V_LINEA_ATTIVITA_VALIDA.ESERCIZIO",SQLBuilder.EQUALS,CNRUserContext.getEsercizio(userContext));
//	if (dett.getCdCentroResponsabilita() != null){
//		sql.addClause(FindClause.AND,"cd_centro_responsabilita",SQLBuilder.EQUALS,dett.getCdCentroResponsabilita());
//	} else {
//		throw new ApplicationException ("GAE non selezionabile senza aver prima indicato il centro di responsabilit�!");
//	}
//
//	sql.openParenthesis(FindClause.AND);
//	sql.addClause(FindClause.OR,"ti_gestione",SQLBuilder.EQUALS,WorkpackageBulk.TI_GESTIONE_SPESE);
//	sql.addClause(FindClause.OR,"ti_gestione",SQLBuilder.EQUALS,WorkpackageBulk.TI_GESTIONE_ENTRAMBE);
//	sql.closeParenthesis();
//
//	if (dett.getProgetto()!=null && dett.getProgetto().getPg_progetto()!=null)
//		sql.addClause(FindClause.AND,"pg_progetto",SQLBuilder.EQUALS,dett.getProgetto().getPg_progetto());
//
//	// Obbligatorio cofog sulle GAE
//	if(((Parametri_cnrComponentSession) it.cnr.jada.util.ejb.EJBCommonServices.createEJB("CNRCONFIG00_EJB_Parametri_cnrComponentSession",Parametri_cnrComponentSession.class)).isCofogObbligatorio(userContext))
//		sql.addSQLClause(FindClause.AND,"CD_COFOG",SQLBuilder.ISNOTNULL,null);
//	sql.addTableToHeader("FUNZIONE");
//	sql.addSQLJoin("V_LINEA_ATTIVITA_VALIDA.CD_FUNZIONE","FUNZIONE.CD_FUNZIONE");
//	sql.addSQLClause(FindClause.AND, "FUNZIONE.FL_UTILIZZABILE",SQLBuilder.EQUALS,"Y");
//
//	sql.addTableToHeader("NATURA");
//	sql.addSQLJoin("V_LINEA_ATTIVITA_VALIDA.CD_NATURA","NATURA.CD_NATURA");
//	sql.addSQLClause(FindClause.AND, "NATURA.FL_SPESA",SQLBuilder.EQUALS,"Y");
//
//	sql.addTableToHeader("PROGETTO_GEST");
//	sql.addSQLJoin("V_LINEA_ATTIVITA_VALIDA.ESERCIZIO","PROGETTO_GEST.ESERCIZIO");
//	sql.addSQLJoin("V_LINEA_ATTIVITA_VALIDA.PG_PROGETTO","PROGETTO_GEST.PG_PROGETTO");
//	sql.addSQLClause(FindClause.AND,"PROGETTO_GEST.FL_UTILIZZABILE",SQLBuilder.EQUALS,"Y");
//
//	/**
//	 * Escludo la linea di attivit� dell'IVA C20
//	 */
//	it.cnr.contab.config00.bulk.Configurazione_cnrBulk config = null;
//	try {
//		config = Utility.createConfigurazioneCnrComponentSession().getConfigurazione( userContext, null, null, it.cnr.contab.config00.bulk.Configurazione_cnrBulk.PK_LINEA_ATTIVITA_SPECIALE, it.cnr.contab.config00.bulk.Configurazione_cnrBulk.SK_LINEA_COMUNE_VERSAMENTO_IVA);
//	} catch (RemoteException e) {
//		throw new ComponentException(e);
//	} catch (EJBException e) {
//		throw new ComponentException(e);
//	}
//	if (config != null){
//		sql.addSQLClause( FindClause.AND, "V_LINEA_ATTIVITA_VALIDA.CD_LINEA_ATTIVITA",  SQLBuilder.NOT_EQUALS, config.getVal01());
//	}
//
//	if (clause != null) sql.addClause(clause);
//
//	return sql; 
//}	
//
//public SQLBuilder selectElementoVoceByClause (UserContext userContext, 
//		RichiestaUopRigaBulk dett,
//		Elemento_voceBulk elementoVoce, 
//		CompoundFindClause clause) throws ComponentException, PersistencyException {
//	if (clause == null) clause = ((OggettoBulk)elementoVoce).buildFindClauses(null);
//
//	SQLBuilder sql = getHome(userContext, elementoVoce,"V_ELEMENTO_VOCE_ORDINI").createSQLBuilder();
//	
//	if(clause != null) sql.addClause(clause);
//
//	sql.addSQLClause("AND", "V_ELEMENTO_VOCE_ORDINI.ESERCIZIO", sql.EQUALS, it.cnr.contab.utenze00.bp.CNRUserContext.getEsercizio( userContext ) );
//	sql.addSQLClause("AND", "V_ELEMENTO_VOCE_ORDINI.CD_CATEGORIA_GRUPPO_INVENT", sql.EQUALS, dett.getCdCategoriaGruppo());
//
//	if (dett.getLineaAttivita() != null)
//		sql.addSQLClause("AND","V_ELEMENTO_VOCE_ORDINI.CD_FUNZIONE",sql.EQUALS,dett.getLineaAttivita().getCd_funzione());
//
//	if (clause != null) sql.addClause(clause);
//
//	sql.addOrderBy("fl_default desc, ordine asc");
//	return sql;
//}
//public SQLBuilder selectProgettoByClause (UserContext userContext, 
//		RichiestaUopRigaBulk dett,
//		ProgettoBulk prg, 
//		CompoundFindClause clause) throws ComponentException, PersistencyException {
//	ProgettoHome progettohome = (ProgettoHome)getHome(userContext, ProgettoBulk.class,"V_PROGETTO_PADRE");
//	SQLBuilder sql = progettohome.createSQLBuilder();
//	sql.addClause( clause );
//
//	sql.addSQLClause("AND", "V_PROGETTO_PADRE.ESERCIZIO", sql.EQUALS, CNRUserContext.getEsercizio(userContext));
//	
//    if (prg!=null)
//    	sql.addSQLClause("AND", "V_PROGETTO_PADRE.PG_PROGETTO", sql.EQUALS, prg.getPg_progetto());
//	sql.addSQLClause("AND", "V_PROGETTO_PADRE.TIPO_FASE", sql.EQUALS, ProgettoBulk.TIPO_FASE_NON_DEFINITA);
//	sql.addSQLClause("AND", "V_PROGETTO_PADRE.LIVELLO", sql.EQUALS, ProgettoBulk.LIVELLO_PROGETTO_SECONDO);
//	// Se uo 999.000 in scrivania: visualizza tutti i progetti
//	Unita_organizzativa_enteBulk ente = (Unita_organizzativa_enteBulk) getHome( userContext, Unita_organizzativa_enteBulk.class).findAll().get(0);
//	if (!((CNRUserContext) userContext).getCd_unita_organizzativa().equals( ente.getCd_unita_organizzativa()))
//		sql.addSQLExistsClause("AND",progettohome.abilitazioniCommesse(userContext));
//	if (clause != null) 
//		sql.addClause(clause);
//
//	return sql; 
//}	
public SQLBuilder selectBeneServizioByClause(UserContext userContext, OrdineAcqRigaBulk riga, 
		Bene_servizioHome beneHome, Bene_servizioBulk bene, 
		CompoundFindClause compoundfindclause) throws PersistencyException{
	SQLBuilder sql = beneHome.selectByClause(userContext, compoundfindclause);
	sql.addSQLClause("AND", "FL_VALIDO", SQLBuilder.EQUALS, Bene_servizioBulk.STATO_VALIDO);
	
	return sql;
}

public SQLBuilder selectDspMagazzinoByClause(UserContext userContext, OrdineAcqRigaBulk riga, 
		MagazzinoHome magHome, MagazzinoBulk mag, 
		CompoundFindClause compoundfindclause) throws PersistencyException, ComponentException{
	SQLBuilder sql = recuperoMagazziniAbilitati(userContext, riga.getOrdineAcq(), magHome, compoundfindclause);
	
	return sql;
}

public SQLBuilder selectMagazzinoByClause(UserContext userContext, OrdineAcqConsegnaBulk cons, 
		MagazzinoHome magHome, MagazzinoBulk mag, 
		CompoundFindClause compoundfindclause) throws PersistencyException, ComponentException{
	SQLBuilder sql = recuperoMagazziniAbilitati(userContext, cons.getOrdineAcqRiga().getOrdineAcq(), magHome, compoundfindclause);
	
	return sql;
}

private SQLBuilder recuperoMagazziniAbilitati(UserContext userContext, OrdineAcqBulk ord,
		MagazzinoHome magHome, CompoundFindClause compoundfindclause) throws PersistencyException, ComponentException {
	SQLBuilder sql = magHome.selectByClause(userContext, compoundfindclause);
	if (!isAbilitatoTuttiMagazzini(userContext, ord)){
		sql.addTableToHeader("ABIL_UTENTE_UOP_OPER_MAG", "B");		
		sql.addSQLJoin("MAGAZZINO.CD_CDS", "B.CD_CDS");
		sql.addSQLJoin("MAGAZZINO.CD_MAGAZZINO", "B.CD_MAGAZZINO");
		sql.addSQLClause("AND", "B.CD_TIPO_OPERAZIONE", SQLBuilder.EQUALS, TipoOperazioneOrdBulk.OPERAZIONE_ORDINE);
		sql.addSQLClause("AND", "B.CD_UNITA_OPERATIVA", SQLBuilder.EQUALS, ord.getCdUnitaOperativa());
		sql.addSQLClause("AND", "B.CD_UTENTE", SQLBuilder.EQUALS, userContext.getUser());
	}
	return sql;
}

public SQLBuilder selectVoceIvaByClause(UserContext userContext, OrdineAcqRigaBulk riga, 
		Voce_ivaHome voceIvaHome, Voce_ivaBulk voceIva, 
		CompoundFindClause compoundfindclause) throws PersistencyException, ComponentException{
	SQLBuilder sql = voceIvaHome.selectByClause(userContext, compoundfindclause);
	if (riga.getBeneServizio() == null){
		throw new it.cnr.jada.comp.ApplicationException("Impossibile caricare il Codice Iva! E' necessario prima selezionare il bene/servizio.");
	}
	Bene_servizioBulk bene = riga.getBeneServizio();
	if (bene.getVoce_iva() == null || bene.getVoce_iva().getCd_voce_iva() == null){
		Bene_servizioHome beneHome = (Bene_servizioHome)getHome(userContext, Bene_servizioBulk.class);
		try {
			bene = (Bene_servizioBulk)beneHome.findByPrimaryKey(userContext, bene);
		} catch (PersistencyException e) {
			throw new ComponentException(e);
		}
	}
	
	sql.addSQLClause("AND", "CD_VOCE_IVA", SQLBuilder.EQUALS, bene.getCd_voce_iva());
	
	return sql;
}

public SQLBuilder selectLuogoConsegnaMagByClause(UserContext userContext, OrdineAcqConsegnaBulk cons, 
		LuogoConsegnaMagHome luogoHome, LuogoConsegnaMagBulk luogo, 
		CompoundFindClause compoundfindclause) throws PersistencyException, ComponentException{
	SQLBuilder sql = luogoHome.selectByClause(userContext, compoundfindclause);
	if (cons.getMagazzino() == null){
		throw new it.cnr.jada.comp.ApplicationException("Impossibile caricare il Codice Iva! E' necessario prima selezionare il bene/servizio.");
	}
	MagazzinoBulk mag = cons.getMagazzino();
	if (mag.getLuogoConsegnaMag() == null || mag.getLuogoConsegnaMag().getCdLuogoConsegna() == null){
		MagazzinoHome magHome = (MagazzinoHome)getHome(userContext, MagazzinoBulk.class);
		try {
			mag = (MagazzinoBulk)magHome.findByPrimaryKey(userContext, mag);
		} catch (PersistencyException e) {
			throw new ComponentException(e);
		}
	}
	
	sql.addSQLClause("AND", "CD_LUOGO_CONSEGNA", SQLBuilder.EQUALS, mag.getCdLuogoConsegna());
	
	return sql;
}

public void gestioneStampaOrdine(UserContext userContext,
		OrdineAcqBulk ordine) throws RemoteException,ComponentException {
	OrdineAcqCMISService ordineCMISService = SpringUtil.getBean("ordineAcqCMISService",OrdineAcqCMISService.class);	
	File file = lanciaStampaOrdine(userContext, ordine);
	archiviaFileCMIS(userContext, ordineCMISService, ordine, file);
}

public File lanciaStampaOrdine(
		UserContext userContext,
		OrdineAcqBulk ordine) throws ComponentException {
	try {
		String nomeProgrammaStampa = "ordine_acq.jasper";
		String nomeFileStampaOrdine = getOutputFileNameOrdine(nomeProgrammaStampa, ordine);
	  	File output = new File(System.getProperty("tmp.dir.SIGLAWeb")+"/tmp/", File.separator + nomeFileStampaOrdine);
	  	Print_spoolerBulk print = new Print_spoolerBulk(); 
		print.setFlEmail(false);
		print.setReport("/ordmag/ordine/"+ nomeProgrammaStampa);
		print.setNomeFile(nomeFileStampaOrdine);
		print.setUtcr(userContext.getUser());
		print.setPgStampa(UUID.randomUUID().getLeastSignificantBits());
		print.addParam("esercizio",ordine.getEsercizio(), Integer.class);
		print.addParam("cds",ordine.getCdCds(), String.class);
		print.addParam("cd_unita_operativa",ordine.getCdUnitaOperativa(), String.class);
		print.addParam("cd_numeratore",ordine.getCdNumeratore(), String.class);
		print.addParam("numero",new Long(ordine.getNumero()), Long.class);
		Report report = SpringUtil.getBean("printService",PrintService.class).executeReport(userContext,print);
		
		FileOutputStream f = new FileOutputStream(output);   
		f.write(report.getBytes());    
		return output;
	} catch (IOException e) {
		throw new GenerazioneReportException("Generazione Stampa non riuscita",e);
	}
}

private String getOutputFileNameOrdine(String reportName, OrdineAcqBulk ordine)

{
	String fileName = preparaFileNamePerStampa(reportName);
	fileName = PDF_DATE_FORMAT.format(new java.util.Date()) + '_' + ordine.recuperoIdOrdineAsString() + '_' + fileName;
	return fileName;
}
private static final DateFormat PDF_DATE_FORMAT = new SimpleDateFormat("yyyyMMdd");

private String preparaFileNamePerStampa(String reportName) {
	String fileName = reportName;
	fileName = fileName.replace('/', '_');
	fileName = fileName.replace('\\', '_');
	if(fileName.startsWith("_"))
		fileName = fileName.substring(1);
	if(fileName.endsWith(".jasper"))
		fileName = fileName.substring(0, fileName.length() - 7);
	fileName = fileName + ".pdf";
	return fileName;
}

private Document archiviaFileCMIS(UserContext userContext, OrdineAcqCMISService cmisService, OrdineAcqBulk ordine, File file) throws ComponentException{
	List<CMISFile> cmisFileCreate = new ArrayList<CMISFile>();
	List<CMISFile> cmisFileAnnullati = new ArrayList<CMISFile>();
	try {
		CMISPath cmisPath = cmisService.getCMISPath(ordine, true);		
		AllegatoOrdineBulk allegato = new AllegatoOrdineBulk();
		allegato.setFile(file);
		allegato.setTitolo("Stampa Ordine");
		allegato.setNome("Stampa Ordine");
		allegato.setDescrizione("Stampa Ordine");
		allegato.setContentType(MimeTypes.PDF.mimetype());
		FileInputStream is = new FileInputStream(allegato.getFile());
		try {
			Document node = cmisService.restoreSimpleDocument(allegato, 
					new FileInputStream(allegato.getFile()),
					allegato.getContentType(),
					allegato.getNome(), cmisPath);
			allegato.setCrudStatus(OggettoBulk.NORMAL);
			cmisService.addAspect(node, OrdineAcqCMISService.ASPECT_STAMPA_ORDINI);
			return node;
		} catch(CmisContentAlreadyExistsException _ex) {
			return cmisService.restoreSimpleDocument(allegato, is, allegato.getContentType(), allegato.getNome(), cmisPath);
		}
	} catch (Exception e){
		//Codice per riallineare il documentale allo stato precedente rispetto alle modifiche
		for (CMISFile cmisFile : cmisFileCreate)
			cmisService.deleteNode(cmisFile.getDocument());
		for (CMISFile cmisFile : cmisFileAnnullati) {
			String cmisFileName = cmisFile.getFileName();
			String cmisFileEstensione = cmisFileName.substring(cmisFileName.lastIndexOf(".")+1);
			String stringToDelete = cmisFileName.substring(cmisFileName.indexOf("-ANNULLATO"));
			cmisFile.setFileName(cmisFileName.replace(stringToDelete, "."+cmisFileEstensione));
			cmisService.updateProperties(cmisFile, cmisFile.getDocument());
			cmisService.removeAspect(cmisFile.getDocument());
		}
		throw new ApplicationException(e.getMessage());
	}
}

protected Query select(UserContext userContext,CompoundFindClause clauses,OggettoBulk bulk) throws ComponentException, it.cnr.jada.persistency.PersistencyException 
{
	SQLBuilder sql = (SQLBuilder) super.select( userContext, clauses, bulk );
	AbilUtenteUopOperHome abilHome = (AbilUtenteUopOperHome) getHomeCache(userContext).getHome(AbilUtenteUopOperBulk.class);
	OrdineAcqBulk ordineAcqBulk = (OrdineAcqBulk)bulk;
	SQLBuilder sqlExists = null;
	sqlExists = abilHome.createSQLBuilder();
	sqlExists.addSQLJoin("ORDINE_ACQ.CD_UNITA_OPERATIVA", "ABIL_UTENTE_UOP_OPER.CD_UNITA_OPERATIVA");
	if (!ordineAcqBulk.getIsForApprovazione()){
		sqlExists.addSQLClause("AND", "ABIL_UTENTE_UOP_OPER.CD_TIPO_OPERAZIONE", SQLBuilder.EQUALS, TipoOperazioneOrdBulk.OPERAZIONE_ORDINE);
	} else {
		sqlExists.addSQLClause("AND", "ABIL_UTENTE_UOP_OPER.CD_TIPO_OPERAZIONE", SQLBuilder.EQUALS, TipoOperazioneOrdBulk.OPERAZIONE_VALIDAZIONE_ORDINE_1);
		sqlExists.openParenthesis("AND");
		sqlExists.addSQLClause("AND", "ORDINE_ACQ.STATO", SQLBuilder.EQUALS, OrdineAcqBulk.STATO_DEFINITIVO);
		sqlExists.addSQLClause("OR", "ORDINE_ACQ.STATO", SQLBuilder.EQUALS, OrdineAcqBulk.STATO_INVIATO_ORDINE);
		sqlExists.closeParenthesis();
	}
	sqlExists.addSQLClause("AND", "ABIL_UTENTE_UOP_OPER.CD_UTENTE", SQLBuilder.EQUALS, userContext.getUser());

	sql.addSQLExistsClause("AND", sqlExists);
	return sql;
}

private OggettoBulk inizializzaOrdine(UserContext usercontext, OggettoBulk oggettobulk)
		throws ComponentException {
	OrdineAcqBulk ordine = (OrdineAcqBulk)oggettobulk;
	try {
		ordine.setDivisa(getEuro(usercontext));
		ordine.setCambio(BigDecimal.ONE);
		OrdineAcqHome home = (OrdineAcqHome) getHomeCache(usercontext).getHome(OrdineAcqBulk.class);
		ordine.setCdCds( ((CNRUserContext) usercontext).getCd_cds());
		if (ordine.getCdUnitaOperativa() == null){
			UnitaOperativaOrdHome uopHome = (UnitaOperativaOrdHome)getHome(usercontext, UnitaOperativaOrdBulk.class);
			SQLBuilder sql = home.selectUnitaOperativaOrdByClause(usercontext, ordine, uopHome, new UnitaOperativaOrdBulk(), new CompoundFindClause());
			List listUop=uopHome.fetchAll(sql);
			if (listUop != null && listUop.size() == 1){
				ordine.setUnitaOperativaOrd((UnitaOperativaOrdBulk)listUop.get(0));
				
				ordine.setIsAbilitatoTuttiMagazzini(isAbilitatoTuttiMagazzini(usercontext, ordine));
//				assegnaUnitaOperativaDest(usercontext, ordine, home, uopHome);
			}
		}
		assegnaNumeratoreOrd(usercontext, ordine, home);
	} catch (PersistencyException e){
		throw new ComponentException(e);
	}
	return ordine;
}

//private void assegnaUnitaOperativaDest(UserContext usercontext, OrdineAcqBulk ordine, OrdineAcqHome home,
//		UnitaOperativaOrdHome uopHome) throws PersistencyException {
//	if (ordine.getCdUnitaOperativaDest() == null){
//		SQLBuilder sqlAss = home.selectUnitaOperativaOrdDestByClause(usercontext, ordine, uopHome, new UnitaOperativaOrdBulk(), new CompoundFindClause());
//		List listAssUop=uopHome.fetchAll(sqlAss);
//		if (listAssUop != null && listAssUop.size() == 1){
//			ordine.setUnitaOperativaOrdDest((UnitaOperativaOrdBulk)listAssUop.get(0));
//		}
//	}
//}
//
private Boolean isAbilitatoTuttiMagazzini(UserContext userContext, OrdineAcqBulk ordine) throws ComponentException {
	
	AbilUtenteUopOperBulk abil = recuperoAbilUtenteUo(userContext, ordine, TipoOperazioneOrdBulk.OPERAZIONE_ORDINE);
	if (abil != null && abil.getTuttiMagazzini().equals("S")){
		return true;
	}
	return false;
}
private void assegnaNumeratoreOrd(UserContext usercontext, OrdineAcqBulk ordine, OrdineAcqHome home)
		throws PersistencyException, ComponentException {
	if (ordine.getCdNumeratore() == null && ordine.getCdUnitaOperativa() != null){
//			AbilUtenteUopOperHome abilHome = (AbilUtenteUopOperHome)getHome(usercontext, AbilUtenteUopOperBulk.class);
//			AbilUtenteUopOperBulk abil = new AbilUtenteUopOperBulk(usercontext.getUser(), richiesta.getCdUnitaOperativa(), TipoOperazioneOrdBulk.OPERAZIONE_RICHIESTA);
//			abil = (AbilUtenteUopOperBulk)abilHome.findByPrimaryKey(usercontext, abil);
//			if (abil != null){
			NumerazioneOrdHome numerazioneHome = (NumerazioneOrdHome)getHome(usercontext, NumerazioneOrdBulk.class);
			SQLBuilder sql = home.selectNumerazioneOrdByClause(usercontext, ordine, numerazioneHome, new NumerazioneOrdBulk(), new CompoundFindClause());
			List listNum=numerazioneHome.fetchAll(sql);
			if (listNum != null && listNum.size() == 1){
				ordine.setNumerazioneOrd((NumerazioneOrdBulk)listNum.get(0));
			}
//			}
	}
}
public Boolean isUtenteAbilitatoOrdine(UserContext usercontext, OrdineAcqBulk ordine) throws ComponentException, PersistencyException{
	return isUtenteAbilitato(usercontext, ordine, TipoOperazioneOrdBulk.OPERAZIONE_ORDINE);
}

public Boolean isUtenteAbilitatoValidazioneOrdine(UserContext usercontext, OrdineAcqBulk ordine) throws ComponentException, PersistencyException{
	return isUtenteAbilitato(usercontext, ordine, TipoOperazioneOrdBulk.OPERAZIONE_VALIDAZIONE_ORDINE_1);
}

private Boolean isUtenteAbilitato(UserContext usercontext, OrdineAcqBulk ordine, String tipoOperazione) throws ComponentException {
	if (ordine.getCdUnitaOperativa() != null){
		AbilUtenteUopOperBulk abil = recuperoAbilUtenteUo(usercontext, ordine, tipoOperazione);
		if (abil != null){
			return true;
		}
		return false;
	}
	return true;
}

private AbilUtenteUopOperBulk recuperoAbilUtenteUo(UserContext userContext, OrdineAcqBulk ordine, String tipoOperazione) throws ComponentException {
	if (ordine.getCdUnitaOperativa() != null){
		AbilUtenteUopOperHome abilHome = (AbilUtenteUopOperHome)getHome(userContext, AbilUtenteUopOperBulk.class);
		AbilUtenteUopOperBulk abil = new AbilUtenteUopOperBulk(userContext.getUser(), ordine.getCdUnitaOperativa(), tipoOperazione);
		try {
			return (AbilUtenteUopOperBulk)abilHome.findByPrimaryKey(userContext, abil);
		} catch (PersistencyException e) {
			throw new ComponentException(e);
		}
	}
	return null;
}
public void completaOrdine(UserContext userContext, OrdineAcqBulk ordine) throws PersistencyException, ComponentException{
	OrdineAcqHome home = (OrdineAcqHome) getHomeCache(userContext).getHome(OrdineAcqBulk.class);
	assegnaNumeratoreOrd(userContext, ordine, home);
	UnitaOperativaOrdHome uopHome = (UnitaOperativaOrdHome)getHome(userContext, UnitaOperativaOrdBulk.class);
//	assegnaUnitaOperativaDest(userContext, ordine, home, uopHome);
}

@Override
public OggettoBulk modificaConBulk(UserContext usercontext, OggettoBulk oggettobulk) throws ComponentException {
	// TODO Auto-generated method stub
	OrdineAcqBulk ordine= (OrdineAcqBulk)super.modificaConBulk(usercontext, oggettobulk);
	validaOrdine(usercontext, ordine);
	return ordine;
}

private DivisaBulk getEuro(UserContext userContext) throws ComponentException {

	String cd_euro = null;
	try {
		cd_euro = ((it.cnr.contab.config00.ejb.Configurazione_cnrComponentSession)it.cnr.jada.util.ejb.EJBCommonServices.createEJB("CNRCONFIG00_EJB_Configurazione_cnrComponentSession", it.cnr.contab.config00.ejb.Configurazione_cnrComponentSession.class)).getVal01(userContext, new Integer(0), "*", "CD_DIVISA", "EURO");
		if (cd_euro == null)
			throw new it.cnr.jada.comp.ApplicationException("Impossibile caricare la valuta di default! Prima di poter inserire una fattura, immettere tale valore.");
	} catch (javax.ejb.EJBException e) {
		handleException(e);
	} catch (java.rmi.RemoteException e) {
		handleException(e);
	}

	DivisaBulk valuta = null;
	
	try {
		java.util.List divise = getHome(userContext, DivisaBulk.class).find(new it.cnr.contab.docamm00.tabrif.bulk.DivisaBulk(cd_euro));
		if (divise == null || divise.isEmpty())
			throw new it.cnr.jada.comp.ApplicationException("Impossibile caricare la valuta di default! Prima di poter inserire una fattura, immettere tale valore.");
		valuta = (DivisaBulk)divise.get(0);
		if (valuta == null)
			throw new it.cnr.jada.comp.ApplicationException("Impossibile caricare la valuta di default! Prima di poter inserire una fattura, immettere tale valore.");
	} catch (it.cnr.jada.persistency.PersistencyException e) {
		handleException(e);
	}
	return valuta;
}

/**
 * Pre:  Ricerca CIG
 * Post: Il CIG pu� essere collegato ad un contratto solo se vengono rispettate le seguenti regole:				
		CD_TERZO_RUP del CIG � il medesimo del contratto che si sta inserendo quindi : 
		CIG. CD_TERZO_RUP = CONTRATTO. CD_TERZO_RESP
		Il CIG non deve risultare associato ad altri contratti.
 */
public SQLBuilder selectCigByClause (UserContext userContext, OrdineAcqBulk ordine, CigBulk cig, CompoundFindClause clause)	throws ComponentException, PersistencyException
{
	if (clause == null) 
	  clause = cig.buildFindClauses(null);
	SQLBuilder sql = getHome(userContext, cig).createSQLBuilder();
	if(ordine.getResponsabileProcPers() == null || ordine.getResponsabileProcPers().getCd_terzo() == null)
	   throw new ApplicationException("Per effettuare la ricerca valorizzare il campo Responsabile!");  
	sql.addSQLClause(FindClause.AND, "CD_TERZO_RUP", SQLBuilder.EQUALS, ordine.getResponsabileProcPers().getCd_terzo());
	sql.addClause(FindClause.AND, "FL_VALIDO", SQLBuilder.EQUALS, Boolean.TRUE);
	if (clause != null) 
	  sql.addClause(clause);
	return sql;
}

/**
 * Pre:  Ricerca Figura giuridica interna
 * Post: Limitazione ai terzi di tipo Unit� Organizzativa
 */
public SQLBuilder selectTerzoCdrByClause (UserContext userContext, OggettoBulk bulk, TerzoBulk terzo,CompoundFindClause clause)	throws ComponentException, PersistencyException
{
	if (clause == null) 
	  clause = terzo.buildFindClauses(null);
	SQLBuilder sql = getHome(userContext, terzo).createSQLBuilder();
	sql.addSQLClause("AND", "CD_UNITA_ORGANIZZATIVA", sql.ISNOTNULL, null);
	// Se uo 999.000 in scrivania: visualizza tutti i progetti
	Unita_organizzativa_enteBulk ente = (Unita_organizzativa_enteBulk) getHome( userContext, Unita_organizzativa_enteBulk.class).findAll().get(0);
	if (!((CNRUserContext) userContext).getCd_unita_organizzativa().equals( ente.getCd_unita_organizzativa())){
	  sql.addSQLClause("AND", "CD_UNITA_ORGANIZZATIVA", sql.EQUALS, CNRUserContext.getCd_unita_organizzativa(userContext));
	}		
	if (clause != null) 
	  sql.addClause(clause);
	return sql;
}	
public SQLBuilder selectFornitoreByClause(UserContext userContext,  OggettoBulk bulk, TerzoBulk terzo, CompoundFindClause clauses) throws ComponentException {
	
	TerzoHome home = (TerzoHome)getHome(userContext, TerzoBulk.class, "V_TERZO_CF_PI");
	SQLBuilder sql = home.createSQLBuilder();
	sql.addSQLClause("AND","DT_FINE_RAPPORTO",SQLBuilder.ISNULL,null);
	sql.addSQLClause("AND","CD_UNITA_ORGANIZZATIVA", SQLBuilder.ISNULL, null);
	sql.addClause(clauses); 
	return sql;
}
/**
 * Pre:  Ricerca Tipo Provvedimento
 * Post: Limitazione ai tipi non annullati
 */
public SQLBuilder selectProcedureAmministrativeByClause (UserContext userContext, OggettoBulk bulk, Procedure_amministrativeBulk procedura_amministrativa,CompoundFindClause clause)	throws ComponentException, PersistencyException
{
	if (clause == null) 
	  clause = procedura_amministrativa.buildFindClauses(null);
	SQLBuilder sql = getHome(userContext, procedura_amministrativa).createSQLBuilder();
	sql.openParenthesis("AND");
	sql.addClause("OR", "ti_proc_amm", SQLBuilder.EQUALS, Procedure_amministrativeBulk.TIPO_FORNITURA_SERVIZI);
	sql.addClause("OR", "ti_proc_amm", SQLBuilder.EQUALS, Procedure_amministrativeBulk.TIPO_GENERICA);
	sql.closeParenthesis();
	sql.addClause("AND", "fl_cancellato", SQLBuilder.EQUALS, Boolean.FALSE);
	if (clause != null) 
	  sql.addClause(clause);
	return sql;
}	
}
