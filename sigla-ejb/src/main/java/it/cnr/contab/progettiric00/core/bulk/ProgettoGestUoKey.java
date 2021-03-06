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

package it.cnr.contab.progettiric00.core.bulk;

import it.cnr.jada.bulk.OggettoBulk;
import it.cnr.jada.persistency.KeyedPersistent;

public class ProgettoGestUoKey extends OggettoBulk implements KeyedPersistent {
	// ESERCIZIO NUMBER(4) NOT NULL (PK)
	private java.lang.Integer esercizio;

	// PG_PROGETTO NUMBER(10) NOT NULL (PK)
	private java.lang.Integer pg_progetto;

	// TIPO_FASE VARCHAR(1) NOT NULL (PK)
	private java.lang.String tipo_fase;
	
	// CD_UNITA_ORGANIZZATIVA VARCHAR(30) NOT NULL (PK)
	private java.lang.String cd_unita_organizzativa;
	
public ProgettoGestUoKey() {
	super();
}
public ProgettoGestUoKey(java.lang.Integer esercizio,java.lang.Integer pg_progetto,java.lang.String tipo_fase,java.lang.String cd_unita_organizzativa) {
	super();
	this.esercizio = esercizio;
	this.pg_progetto = pg_progetto;
	this.tipo_fase = tipo_fase;
	this.cd_unita_organizzativa = cd_unita_organizzativa;
}
public boolean equalsByPrimaryKey(Object o) {
	if (this == o) return true;
	if (!(o instanceof ProgettoGestUoKey)) return false;
	ProgettoGestUoKey k = (ProgettoGestUoKey)o;
	if(!compareKey(getEsercizio(),k.getEsercizio())) return false;
	if(!compareKey(getPg_progetto(),k.getPg_progetto())) return false;
	if(!compareKey(getTipo_fase(),k.getTipo_fase())) return false;
	if(!compareKey(getCd_unita_organizzativa(),k.getCd_unita_organizzativa())) return false;
	return true;
}
/* 
 * Getter dell'attributo pg_progetto
 */
public java.lang.Integer getPg_progetto() {
	return pg_progetto;
}
public int primaryKeyHashCode() {
	return	calculateKeyHashCode(getEsercizio())+
			calculateKeyHashCode(getPg_progetto())+
			calculateKeyHashCode(getTipo_fase())+
			calculateKeyHashCode(getCd_unita_organizzativa());
}
/* 
 * Setter dell'attributo pg_progetto
 */
public void setPg_progetto(java.lang.Integer pg_progetto) {
	this.pg_progetto = pg_progetto;
}
public void setPg_progetto(java.math.BigDecimal pg_progetto) {
	this.pg_progetto = new java.lang.Integer(pg_progetto.intValue());
}
public java.lang.Integer getEsercizio() {
	return esercizio;
}
public void setEsercizio(java.lang.Integer esercizio) {
	this.esercizio = esercizio;
}
public java.lang.String getTipo_fase() {
	return tipo_fase;
}
public void setTipo_fase(java.lang.String tipo_fase) {
	this.tipo_fase = tipo_fase;
}
public java.lang.String getCd_unita_organizzativa() {
	return cd_unita_organizzativa;
}
public void setCd_unita_organizzativa(java.lang.String cd_unita_organizzativa) {
	this.cd_unita_organizzativa = cd_unita_organizzativa;
}
}