package it.cnr.contab.docamm00.tabrif.bulk;
import it.cnr.contab.config00.pdcfin.bulk.*;

import it.cnr.jada.bulk.*;
import it.cnr.jada.persistency.*;
import it.cnr.jada.persistency.beans.*;
import it.cnr.jada.persistency.sql.*;

public class Categoria_gruppo_inventBulk extends Categoria_gruppo_inventBase {

    protected BulkList associazioneVoci = new BulkList();
    
	private Categoria_gruppo_inventBulk nodoPadre;

public Categoria_gruppo_inventBulk() {
	super();
}

public Categoria_gruppo_inventBulk(java.lang.String cd_categoria_gruppo) {
	super(cd_categoria_gruppo);
}

/**
 * Insert the method's description here.
 * Creation date: (07/05/2002 14.15.30)
 * @return it.cnr.contab.docamm00.tabrif.bulk.Categoria_gruppo_voceBulk
 */

public java.lang.String getCd_categoria_padre() {
	it.cnr.contab.docamm00.tabrif.bulk.Categoria_gruppo_inventBulk nodoPadre = this.getNodoPadre();
	if (nodoPadre == null)
		return null;
	return nodoPadre.getCd_categoria_gruppo();
}

public java.lang.String getCd_padre() {
	Categoria_gruppo_inventBulk nodoPadre = this.getNodoPadre();
	if (nodoPadre == null)
		return null;
	return nodoPadre.getCd_categoria_gruppo();
}

/**
 * Insert the method's description here.
 * Creation date: (29/03/2002 9.29.04)
 * @return it.cnr.contab.docamm00.tabrif.bulk.Categoria_gruppo_inventBulk
 */
public Categoria_gruppo_inventBulk getNodoPadre() {
	return nodoPadre;
}


public OggettoBulk initializeForEdit(it.cnr.jada.util.action.CRUDBP bp,it.cnr.jada.action.ActionContext context) {

	super.initializeForEdit(bp,context);

	if (getFl_ammortamento()==null)
		setFl_ammortamento(Boolean.FALSE);
	if (getFl_gestione_inventario()==null)
		setFl_gestione_inventario(Boolean.FALSE);
	if (getFl_gestione_magazzino()==null)
		setFl_gestione_magazzino(Boolean.FALSE);
	return this;
}

public OggettoBulk initializeForInsert(it.cnr.jada.util.action.CRUDBP bp,it.cnr.jada.action.ActionContext context) {

	super.initializeForInsert(bp,context);

	
	setLivello(new Integer(1));
	if(getFl_ammortamento()==null)
		setFl_ammortamento(Boolean.FALSE);
	if (getFl_gestione_inventario()==null)
		setFl_gestione_inventario(Boolean.FALSE);
	if (getFl_gestione_magazzino()==null)
		setFl_gestione_magazzino(Boolean.FALSE);

	setNodoPadre(new Categoria_gruppo_inventBulk());
	return this;
}

public boolean isRONodoPadre() {
	
	return getNodoPadre() == null ||
			getNodoPadre().getCrudStatus() == OggettoBulk.NORMAL;
}

public void setCd_categoria_padre(java.lang.String cd_categoria_padre) {
	this.getNodoPadre().setCd_categoria_gruppo(cd_categoria_padre);
}

public void setCd_padre(java.lang.String cd_padre) {
	this.getNodoPadre().setCd_categoria_gruppo(cd_padre);
}

/**
 * Insert the method's description here.
 * Creation date: (29/03/2002 9.29.04)
 * @param newNodoPadre it.cnr.contab.docamm00.tabrif.bulk.Categoria_gruppo_inventBulk
 */
public void setNodoPadre(Categoria_gruppo_inventBulk newNodoPadre) {
	nodoPadre = newNodoPadre;
}


public void validate() throws ValidationException {
	super.validate();
	if (getFl_gestione_magazzino()==null)
		setFl_gestione_magazzino(Boolean.FALSE);
	if (getFl_gestione_inventario()==null)
		setFl_gestione_inventario(Boolean.FALSE);
	if (getFl_gestione_inventario().booleanValue() && getFl_gestione_magazzino().booleanValue())
		throw new ValidationException("Attenzione: non � possibile che un bene servizio sia a magazzino e ad inventario");	
	if (!getFl_gestione_inventario().booleanValue() && !getFl_gestione_magazzino().booleanValue())
		throw new ValidationException("Attenzione: scegliere la gestione tra magazzino o inventario");	

}

public int addToAssociazioneVoci(Categoria_gruppo_voceBulk dett) {
	associazioneVoci.add(dett);
	dett.setCategoria_gruppo(this);
	return associazioneVoci.size()-1;
}	

public it.cnr.jada.bulk.BulkCollection[] getBulkLists() {
	return new it.cnr.jada.bulk.BulkCollection[] {associazioneVoci};
}

public Categoria_gruppo_voceBulk removeFromAssociazioneVoci(int index) {
	Categoria_gruppo_voceBulk dett = (Categoria_gruppo_voceBulk)associazioneVoci.remove(index);
	return dett;
}

public BulkList getAssociazioneVoci() {
	return associazioneVoci;
}

public void setAssociazioneVoci(BulkList associazioneVoci) {
	this.associazioneVoci = associazioneVoci;
}
}