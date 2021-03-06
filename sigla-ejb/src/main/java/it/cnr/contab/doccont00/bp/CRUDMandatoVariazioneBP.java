/*
 * Copyright (C) 2019  Consiglio Nazionale delle Ricerche
 *
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU Affero General Public License as
 *     published by the Free Software Foundation, either version 3 of the
 *     License, or (at your option) any later version.
 *
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU Affero General Public License for more details.
 *
 *     You should have received a copy of the GNU Affero General Public License
 *     along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

package it.cnr.contab.doccont00.bp;

import it.cnr.contab.doccont00.core.bulk.MandatoBulk;
import it.cnr.contab.util.enumeration.StatoVariazioneSostituzione;
import it.cnr.jada.action.ActionContext;
import it.cnr.jada.action.BusinessProcessException;
import it.cnr.jada.bulk.OggettoBulk;
import it.cnr.jada.comp.ComponentException;

import java.rmi.RemoteException;
import java.util.Optional;

public class CRUDMandatoVariazioneBP extends CRUDMandatoBP {
    public CRUDMandatoVariazioneBP() {
        super("Tr");
    }

    public CRUDMandatoVariazioneBP(String function) {
        super(function + "Tr");
    }

    public void setDaVariare(ActionContext actionContext) throws it.cnr.jada.action.BusinessProcessException {
        final MandatoBulk mandatoBulk = Optional.ofNullable(getModel())
                .filter(MandatoBulk.class::isInstance)
                .map(MandatoBulk.class::cast)
                .orElseThrow(() -> new BusinessProcessException("Mandato non trovato!"));

        mandatoBulk.setStatoVarSos(StatoVariazioneSostituzione.DA_VARIARE.value());
        mandatoBulk.setToBeUpdated();
        try {
            final OggettoBulk oggettoBulk = createComponentSession().modificaConBulk(actionContext.getUserContext(), mandatoBulk);
            commitUserTransaction();
            basicEdit(actionContext, oggettoBulk, true);
        } catch (ComponentException | RemoteException e) {
            throw handleException(e);
        }
    }

    @Override
    public boolean isInputReadonly() {
        return false;
    }
}
