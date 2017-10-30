package it.cnr.contab.docamm00.bp;

import it.cnr.contab.docamm00.docs.bulk.Fattura_passiva_rigaBulk;
import it.cnr.contab.ordmag.ordini.bulk.EvasioneOrdineRigaBulk;
import it.cnr.jada.action.ActionContext;
import it.cnr.jada.action.BusinessProcessException;
import it.cnr.jada.bulk.BulkInfo;
import it.cnr.jada.bulk.OggettoBulk;
import it.cnr.jada.ejb.RicercaComponentSession;
import it.cnr.jada.persistency.sql.CompoundFindClause;
import it.cnr.jada.util.Config;
import it.cnr.jada.util.RemoteIterator;
import it.cnr.jada.util.action.*;
import it.cnr.jada.util.ejb.EJBCommonServices;
import it.cnr.jada.util.jsp.Button;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.BitSet;
import java.util.List;

public class ContabilizzaOrdineBP extends SelezionatoreListaBP implements SearchProvider {

    private Fattura_passiva_rigaBulk fattura_passiva_rigaBulk;

    public ContabilizzaOrdineBP(String s) {
        super(s);
        setBulkInfo(BulkInfo.getBulkInfo(EvasioneOrdineRigaBulk.class));
        setColumns(getBulkInfo().getColumnFieldPropertyDictionary("fattura_passiva"));
    }

    public void setFattura_passiva_rigaBulk(Fattura_passiva_rigaBulk fattura_passiva_rigaBulk) {
        this.fattura_passiva_rigaBulk = fattura_passiva_rigaBulk;
    }

    @Override
    public RemoteIterator search(ActionContext actioncontext, CompoundFindClause compoundfindclause, OggettoBulk oggettobulk) throws BusinessProcessException {
        try {
            return EJBCommonServices.openRemoteIterator(
                    actioncontext,
                    ((RicercaComponentSession)createComponentSession("CNRDOCAMM00_EJB_FatturaPassivaComponentSession"))
                            .cerca(
                                actioncontext.getUserContext(), compoundfindclause,
                                oggettobulk, fattura_passiva_rigaBulk, "contabilizzaRiga"
                            )
            );
        } catch (Exception exception) {
            throw new BusinessProcessException(exception);
        }
    }
}
