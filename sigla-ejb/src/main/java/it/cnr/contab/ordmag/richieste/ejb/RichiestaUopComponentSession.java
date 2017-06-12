package it.cnr.contab.ordmag.richieste.ejb;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.Remote;

import it.cnr.contab.ordmag.richieste.bulk.RichiestaUopBulk;
import it.cnr.jada.UserContext;
import it.cnr.jada.comp.ComponentException;
import it.cnr.jada.persistency.PersistencyException;
@Remote
public interface RichiestaUopComponentSession extends it.cnr.jada.ejb.CRUDComponentSession{
	public void gestioneStampaRichiesta(UserContext userContext, RichiestaUopBulk richiesta) throws RemoteException,ComponentException;
	public Boolean isUtenteAbilitatoRichiesta(UserContext usercontext, RichiestaUopBulk richiesta) throws RemoteException,ComponentException, PersistencyException, EJBException;
	public Boolean isUtenteAbilitatoValidazioneRichiesta(UserContext usercontext, RichiestaUopBulk richiesta) throws RemoteException,ComponentException, PersistencyException, EJBException;
	public void completaRichiesta(UserContext userContext, RichiestaUopBulk richiesta) throws RemoteException,ComponentException, PersistencyException;

//it.cnr.jada.bulk.OggettoBulk aggiornaModalita(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk param1,it.cnr.contab.docamm00.docs.bulk.Documento_generico_rigaBulk param2,it.cnr.contab.anagraf00.core.bulk.TerzoBulk param3) throws it.cnr.jada.comp.ComponentException,it.cnr.jada.persistency.PersistencyException,it.cnr.jada.persistency.IntrospectionException,java.rmi.RemoteException;
//void aggiornaStatoDocumentiAmministrativi(it.cnr.jada.UserContext param0,java.lang.String param1,java.lang.String param2,java.lang.String param3,java.lang.Integer param4,java.lang.Long param5,java.lang.String param6) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.contab.docamm00.docs.bulk.IDocumentoAmministrativoBulk calcoloConsuntivi(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.IDocumentoAmministrativoBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.jada.util.RemoteIterator cercaAccertamenti(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Filtro_ricerca_accertamentiVBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk cercaCambio(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.jada.util.RemoteIterator cercaObbligazioni(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Filtro_ricerca_obbligazioniVBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.jada.bulk.OggettoBulk completaTerzo(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk param1,it.cnr.contab.docamm00.docs.bulk.Documento_generico_rigaBulk param2,it.cnr.contab.anagraf00.core.bulk.TerzoBulk param3) throws it.cnr.jada.comp.ComponentException,it.cnr.jada.persistency.PersistencyException,it.cnr.jada.persistency.IntrospectionException,java.rmi.RemoteException;
//it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk contabilizzaDettagliSelezionati(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk param1,java.util.Collection param2,it.cnr.contab.doccont00.core.bulk.Accertamento_scadenzarioBulk param3) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk contabilizzaDettagliSelezionati(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk param1,java.util.Collection param2,it.cnr.contab.doccont00.core.bulk.Obbligazione_scadenzarioBulk param3) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//void controllaQuadraturaAccertamenti(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//void controllaQuadraturaObbligazioni(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.jada.bulk.OggettoBulk creaConBulk(it.cnr.jada.UserContext param0,it.cnr.jada.bulk.OggettoBulk param1,it.cnr.contab.doccont00.core.bulk.OptionRequestParameter param2) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk eliminaLetteraPagamentoEstero(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//void eliminaRiga(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_generico_rigaBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.contab.anagraf00.core.bulk.TerzoBulk findCessionario(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_generico_rigaBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//java.util.Collection findListabanche(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_generico_rigaBulk param1) throws it.cnr.jada.comp.ComponentException,it.cnr.jada.persistency.PersistencyException,it.cnr.jada.persistency.IntrospectionException,java.rmi.RemoteException;
//java.util.Collection findTipi_doc_for_search(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk param1) throws it.cnr.jada.comp.ComponentException,it.cnr.jada.persistency.PersistencyException,it.cnr.jada.persistency.IntrospectionException,java.rmi.RemoteException;
//it.cnr.contab.anagraf00.core.bulk.TerzoBulk getTerzoDefault(it.cnr.jada.UserContext param0) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//void inserisciRiga(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_generico_rigaBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.jada.bulk.OggettoBulk modificaConBulk(it.cnr.jada.UserContext param0,it.cnr.jada.bulk.OggettoBulk param1,it.cnr.contab.doccont00.core.bulk.OptionRequestParameter param2) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//void protocolla(it.cnr.jada.UserContext param0,java.sql.Timestamp param1,java.lang.Long param2) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.contab.docamm00.docs.bulk.IDocumentoAmministrativoBulk riportaAvanti(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.IDocumentoAmministrativoBulk param1,it.cnr.contab.doccont00.core.bulk.OptionRequestParameter param2) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.contab.docamm00.docs.bulk.IDocumentoAmministrativoBulk riportaIndietro(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.IDocumentoAmministrativoBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//void rollbackToSavePoint(it.cnr.jada.UserContext param0,java.lang.String param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.contab.anagraf00.core.bulk.BancaBulk setContoEnteIn(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_generico_rigaBulk param1,java.util.List param2) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk setEnte(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//void setSavePoint(it.cnr.jada.UserContext param0,java.lang.String param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.contab.docamm00.docs.bulk.IDocumentoAmministrativoRigaBulk update(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.IDocumentoAmministrativoRigaBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.contab.doccont00.core.bulk.IScadenzaDocumentoContabileBulk updateImportoAssociatoDocAmm(it.cnr.jada.UserContext param0,it.cnr.contab.doccont00.core.bulk.IScadenzaDocumentoContabileBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//void validaDocumento(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//void validaRiga(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_generico_rigaBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//boolean verificaStatoEsercizio(it.cnr.jada.UserContext param0,it.cnr.contab.config00.esercizio.bulk.EsercizioBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk rebuildDocumento(it.cnr.jada.UserContext param0, it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//boolean isEsercizioChiusoPerDataCompetenza(it.cnr.jada.UserContext param0,java.lang.Integer param1,java.lang.String param2) throws ComponentException, PersistencyException,java.rmi.RemoteException;
//it.cnr.jada.util.RemoteIterator selectBeniFor(it.cnr.jada.UserContext param0,Documento_genericoBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//Boolean ha_beniColl(it.cnr.jada.UserContext param0,it.cnr.jada.bulk.OggettoBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//void rimuoviDaAssociazioniInventario(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_generico_rigaBulk param1,it.cnr.contab.inventario00.docs.bulk.Ass_inv_bene_fatturaBulk param2) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//void rimuoviDaAssociazioniInventario(it.cnr.jada.UserContext param0,it.cnr.contab.inventario00.docs.bulk.Ass_inv_bene_fatturaBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//java.util.List findMandatoRigaCollegati(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_generico_rigaBulk param1) throws it.cnr.jada.comp.ComponentException,it.cnr.jada.persistency.PersistencyException,it.cnr.jada.persistency.IntrospectionException,java.rmi.RemoteException;
//java.util.List findReversaleRigaCollegate(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_generico_rigaBulk param1) throws it.cnr.jada.comp.ComponentException,it.cnr.jada.persistency.PersistencyException,it.cnr.jada.persistency.IntrospectionException,java.rmi.RemoteException;
//it.cnr.contab.anagraf00.core.bulk.TerzoBulk getTerzoUnivoco(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk param1) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
//it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk eliminaLetteraPagamentoEstero(it.cnr.jada.UserContext param0,it.cnr.contab.docamm00.docs.bulk.Documento_genericoBulk param1,boolean param2) throws it.cnr.jada.comp.ComponentException,java.rmi.RemoteException;
}
