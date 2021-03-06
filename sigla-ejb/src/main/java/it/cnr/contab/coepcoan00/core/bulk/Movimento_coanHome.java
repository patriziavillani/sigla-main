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

package it.cnr.contab.coepcoan00.core.bulk;

import it.cnr.jada.bulk.*;
import it.cnr.jada.persistency.*;
import it.cnr.jada.persistency.beans.*;
import it.cnr.jada.persistency.sql.*;

import java.sql.*;

public class Movimento_coanHome extends BulkHome {
public Movimento_coanHome(java.sql.Connection conn) {
	super(Movimento_coanBulk.class,conn);
}
public Movimento_coanHome(java.sql.Connection conn,PersistentCache persistentCache) {
	super(Movimento_coanBulk.class,conn,persistentCache);
}
/**
 * Ritorna un SQLBuilder con la columnMap del ricevente
 */
public SQLBuilder createSQLBuilder() 
{
	SQLBuilder sql = super.createSQLBuilder();
	sql.addTableToHeader("SCRITTURA_ANALITICA");
	sql.addSQLJoin( "SCRITTURA_ANALITICA.ESERCIZIO","MOVIMENTO_COAN.ESERCIZIO");
	sql.addSQLJoin( "SCRITTURA_ANALITICA.CD_CDS", "MOVIMENTO_COAN.CD_CDS");
	sql.addSQLJoin( "SCRITTURA_ANALITICA.PG_SCRITTURA","MOVIMENTO_COAN.PG_SCRITTURA");
	sql.addSQLJoin( "SCRITTURA_ANALITICA.CD_UNITA_ORGANIZZATIVA","MOVIMENTO_COAN.CD_UNITA_ORGANIZZATIVA");	

	return sql;
}
/**
 * Imposta il pg_movimento di un oggetto <code>Movimento_coanBulk</code>.
 * @param userContext 
 * @param bulk <code>Movimento_coanBulk</code>
 * @exception PersistencyException
*/

public void initializePrimaryKeyForInsert(it.cnr.jada.UserContext userContext,OggettoBulk bulk) throws PersistencyException 
{
	try
	{
		Movimento_coanBulk mov = (Movimento_coanBulk) bulk;
		Long x;
		
		LoggableStatement ps = new LoggableStatement(getConnection(),
			"SELECT PG_MOVIMENTO FROM " +
			it.cnr.jada.util.ejb.EJBCommonServices.getDefaultSchema() + 			
			"MOVIMENTO_COAN " +
			"WHERE ESERCIZIO = ? AND " +
			"CD_CDS = ? AND " +
			"CD_UNITA_ORGANIZZATIVA = ? AND " +			
			"PG_SCRITTURA = ? AND " +
			"PG_MOVIMENTO = ( SELECT MAX(PG_MOVIMENTO) " +			
			"FROM " +
			it.cnr.jada.util.ejb.EJBCommonServices.getDefaultSchema() + 			
			"MOVIMENTO_COAN " +
			"WHERE ESERCIZIO = ? AND " +
			"CD_CDS = ? AND " +
			"CD_UNITA_ORGANIZZATIVA = ? AND " +						
			"PG_SCRITTURA = ? )" +
			"FOR UPDATE NOWAIT" ,true,this.getClass());
		try
		{
			ps.setObject( 1, mov.getEsercizio() );
			ps.setString( 2, mov.getCd_cds() );
			ps.setString( 3, mov.getCd_unita_organizzativa() );		
			ps.setObject( 4, mov.getPg_scrittura() );
			ps.setObject( 5, mov.getEsercizio() );
			ps.setString( 6, mov.getCd_cds() );
			ps.setString( 7, mov.getCd_unita_organizzativa() );				
			ps.setObject( 8, mov.getPg_scrittura() );					
		
			ResultSet rs = ps.executeQuery();
			try
			{
				if(rs.next())
					x = new Long(rs.getLong(1) + 1);
				else
					x = new Long(0);
			}
			catch( SQLException e )
			{
				throw new PersistencyException( e );	
			}
			finally
			{
				try{rs.close();}catch( java.sql.SQLException e ){};
			}
		}
		catch( SQLException e )
		{
			throw new PersistencyException( e );	
		}
		finally
		{
			try{ps.close();}catch( java.sql.SQLException e ){};
		}
		
		mov.setPg_movimento( x );
	}
	catch ( SQLException e )
	{
		throw new PersistencyException( e );
	}
		
}
}
