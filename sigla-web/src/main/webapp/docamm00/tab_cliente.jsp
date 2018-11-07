<%@ page pageEncoding="UTF-8"
	import="it.cnr.jada.util.jsp.*,
		it.cnr.jada.action.*,
		java.util.*,
		it.cnr.jada.util.action.*,
		it.cnr.contab.docamm00.tabrif.bulk.*,
		it.cnr.contab.docamm00.docs.bulk.*,
		it.cnr.contab.docamm00.bp.*"
%>

<% CRUDFatturaAttivaBP bp = (CRUDFatturaAttivaBP)BusinessProcess.getBusinessProcess(request);
	Fattura_attivaBulk fatturaAttiva = (Fattura_attivaBulk)bp.getModel();
	it.cnr.contab.anagraf00.core.bulk.TerzoBulk cliente = fatturaAttiva.getCliente(); 
	boolean roOnAutoGen = false;
	if (bp instanceof IDocumentoAmministrativoBP)
		roOnAutoGen = ((IDocumentoAmministrativoBP)bp).isAutoGenerated();
%>
	<div class="Group card">
		<table>
			<tr>
				<td>
					<% bp.getController().writeFormLabel(out,"cliente");%>
				</td>
				<td colspan="3">
					<% bp.getController().writeFormInput(out, null, "cliente", roOnAutoGen, null, "");%>
				</td>
			</tr>
			<tr>
				<td>
					<% bp.getController().writeFormLabel(out,"cd_precedente");%>
				</td>
				<td >
					<% bp.getController().writeFormInput(out, null, "cd_precedente", roOnAutoGen, null, "");%>
				</td>
				<% bp.getController().writeFormField(out,"codiceUnivocoUfficioIpa");%>
				<% bp.getController().writeFormField(out,"codiceDestinatarioFatt");%>
			</tr>
			
			<%	if (cliente != null && cliente.getAnagrafico() != null) {
					if ((cliente.getAnagrafico().isStrutturaCNR() ||
						cliente.getAnagrafico().isPersonaGiuridica() ||
						cliente.getAnagrafico().isDittaIndividuale()) &&
						fatturaAttiva.getRagione_sociale() != null &&
						fatturaAttiva.getRagione_sociale().length() > 0) { %>
						<tr>
							<%	if (cliente.getAnagrafico().isStrutturaCNR()) { %>
									<td>
										<b>Nome</b>
									</td>
							<%	} else { %>
									<td>
										<%bp.getController().writeFormLabel(out,"ragione_sociale");%>
									</td>
							<% } %>
							<td  colspan="3">
								<%bp.getController().writeFormInput(out,"ragione_sociale");%>
							</td>
						</tr>
				<%	}
					if (cliente.getAnagrafico().isPersonaFisica()) { %>
						<tr>
							<td>
								<% bp.getController().writeFormLabel(out,"cognome");%>
							</td>
							<td>
								<%bp.getController().writeFormInput(out,"cognome");%>
							</td>
							<td>
								<% bp.getController().writeFormLabel(out,"nome");%>
							</td>
							<td>
								<%bp.getController().writeFormInput(out,"nome");%>
							</td>
						</tr>
				<%	} %>
					<tr>
						<td>
							<% bp.getController().writeFormLabel(out,"denominazione_sede"); %>
						</td>
						<td colspan="3">
							<% bp.getController().writeFormInput(out,"denominazione_sede"); %>
						</td>
					</tr>
				<%	if (!cliente.getAnagrafico().isStrutturaCNR()) { %>
						<tr>
							<% 	if (cliente.getAnagrafico().isPersonaGiuridica() || 
									cliente.getAnagrafico().isDittaIndividuale()) { %>
										<td>
											<% bp.getController().writeFormLabel(out,"partita_iva"); %>
										</td>
										<td>
											<% bp.getController().writeFormInput(out,"partita_iva"); %>
										</td>
							<%	} %>
							<% bp.getController().writeFormField(out,"codice_fiscale"); %>
							<% if (bp.isSearching() || cliente.getCrudStatus() != it.cnr.jada.bulk.OggettoBulk.NORMAL)
								bp.getController().writeFormField(out,"partita_iva");%>
						</tr>
			<%		} 
				} else { %>
					<tr>
						<td>
							<% bp.getController().writeFormLabel(out,"ragione_sociale");%>
						</td>
						<td colspan="3">
							<% bp.getController().writeFormInput(out,"ragione_sociale");%>
						</td>
					</tr>
					<tr>
						<% bp.getController().writeFormField(out,"nome");%>
						<% bp.getController().writeFormField(out,"cognome");%>
					</tr>
					<tr>
						<% bp.getController().writeFormField(out,"codice_fiscale");%>
						<% bp.getController().writeFormField(out,"partita_iva");%>
					</tr>
			<%	} %>
	      <tr>
			<% bp.getController().writeFormField(out,"via_fiscale");%>
			<% bp.getController().writeFormField(out,"num_civico");%>
	      </tr>
	      <tr>
			<% bp.getController().writeFormField(out,"ds_comune");%>
			<% bp.getController().writeFormField(out,"ds_provincia");%>
	      </tr> 
		</table>
	</div>
    <div class="Group">
       <% if (
    		   (fatturaAttiva != null && fatturaAttiva.isDocumentoFatturazioneElettronica() )) { 
				%>
  	<table>
		      <tr>     	
		      	<td>
				<% bp.getController().writeFormField(out,"codiceInvioSdi");%>
		      	</td>      	
		      </tr>
		      <tr>     	
		      	<td>
				<% bp.getController().writeFormField(out,"dtConsegnaSdi");%>
		      	</td>      	
		      </tr>
		      <tr>     	
		      	<td>
				<% bp.getController().writeFormField(out,"noteInvioSdi");%>
		      	</td>      	
		      </tr>
		      <tr>     	
		      	<td>
				<% bp.getController().writeFormField(out,"statoInvioSdi");%>
		      	</td>      	
		      </tr>
		      <tr>     	
		      	<td>
				<% bp.getController().writeFormField(out,"pecFatturaElettronica");%>
		      	</td>      	
		      </tr>
		      <tr>     	
		      	<td>
				<% bp.getController().writeFormField(out,"mailFatturaElettronica");%>
		      	</td>      	
		      </tr>
     </table>
	  <% 	
	  	} %>
    </div>
	