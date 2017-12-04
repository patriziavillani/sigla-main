<%@ page 
	import="it.cnr.jada.util.jsp.*,
		it.cnr.jada.action.*,
		it.cnr.jada.bulk.*,
		it.cnr.jada.util.action.*,
		it.cnr.contab.config00.sto.bulk.*,
		it.cnr.contab.prevent01.action.*,
		it.cnr.contab.prevent01.bp.*,
		it.cnr.contab.prevent01.bulk.*"
%>

<html>
<head>
<% JSPUtils.printBaseUrl(pageContext); %>
<script language="JavaScript" src="scripts/util.js"></script>
<script language="javascript" src="scripts/css.js"></script>
<title>Piano di Gestione Preliminare</title>
</head>
<body class="Form">

<%
	CRUDPdGAggregatoModuloBP bp = (CRUDPdGAggregatoModuloBP)BusinessProcess.getBusinessProcess(request);
	SimpleDetailCRUDController controller = ((CRUDPdGAggregatoModuloBP)bp).getCrudDettagli();
	bp.openFormWindow(pageContext);
	CdrBulk cdr = (CdrBulk)bp.getModel();
	boolean pdg_selezionato = ((Pdg_moduloBulk)controller.getModel()) != null && ((Pdg_moduloBulk)controller.getModel()).getCrudStatus() == OggettoBulk.NORMAL;
%>

<div class="Group">
	<table class="Panel card card-block" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td><% bp.getController().writeFormField(out,"cd_cdr_ro");%></td>
			<td><% bp.getController().writeFormField(out,"ds_cdr_ro");%></td>
		</tr>
	</table>
</div>

<div class="Group">
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<td>
		<%	if (bp.getParametriCnr().getFl_nuovo_pdg()) 
				controller.writeHTMLTable(pageContext,"prg_liv2",true,false,true,"100%","180px");
			else
				controller.writeHTMLTable(pageContext,null,true,false,true,"100%","180px");
		%>
		</td>
	</table>
</div>

<div class="Group card">
	<table border="0" cellspacing="0" cellpadding="2">
		<tr>
			<td>
			<%	if (bp.getParametriCnr().getFl_nuovo_pdg()) 
					controller.writeFormField(out,"searchtool_progetto_liv2");
				else
					controller.writeFormField(out,"searchtool_progetto");
			%>
			</td>
		</tr>
	</table>
	<table border="0" cellspacing="0" cellpadding="2" width="100%">
		<tr>
			<td colspan="5" width="45%">
 		    <div class="card">
				<div class="GroupLabel card-header">Stato del PdG</div>
				<div class="Group card-block">
					<table>
						<tr>
							<td><% controller.writeFormLabel(out,"cambia_stato");%></td>
							<td><% controller.writeFormInput( out, null, "cambia_stato", bp.isROStato(), null, null);%></td>
							<td><center><%JSPUtils.button(out, "img/import24.gif", "img/import24.gif", "Cambia Stato", "if (disableDblClick()) javascript:submitForm('doCambiaStato')", null, !bp.isROStato(), bp.getParentRoot().isBootstrap());%></center></td>
						</tr>					
					</table>
				</div>
			</div>				
			</td>
			<td>
 		    <div class="card">
				<div class="GroupLabel card-header">Contrattazione</div>
				<div class="Group card-block">
					<table width="100%" style="text-align: center;">
						<tr>
							<td>
								<%JSPUtils.button(out, 
										bp.getParentRoot().isBootstrap() ? "fa fa-fw fa-money text-primary" : "img/compressed.gif",
										bp.getParentRoot().isBootstrap() ? "fa fa-fw fa-money text-primary" : "img/compressed.gif",
										"Entrate", 
										"if (disableDblClick()) submitForm('doContrattazioneEntrate')",
										"btn-secondary btn-outline-secondary btn-title text-primary",
										pdg_selezionato, 
										bp.getParentRoot().isBootstrap());%>
							</td>
							<td>
								<%JSPUtils.button(out, 
										bp.getParentRoot().isBootstrap() ? "fa fa-fw fa-briefcase text-primary" : "img/transfer.gif",
										bp.getParentRoot().isBootstrap() ? "fa fa-fw fa-briefcase text-primary" : "img/transfer.gif",
										"Spese", 
										"if (disableDblClick()) submitForm('doContrattazioneSpese')",
										"btn-secondary btn-outline-secondary btn-title text-primary",
										pdg_selezionato, 
										bp.getParentRoot().isBootstrap());%></td>
						</tr>
					</table>
				</div>
			</div>
			</td>
		</tr>
		<tr>
			<td colspan=5>
			</td>
			<td>
 		    <div class="card">
				<div class="GroupLabel card-header">Gestionale</div>
				<div class="Group card-block">
					<table width="100%" style="text-align: center;">
						<tr>
							<td>
								<%JSPUtils.button(out, 
										bp.getParentRoot().isBootstrap() ? "fa fa-fw fa-money text-primary" : "img/compressed.gif",
										bp.getParentRoot().isBootstrap() ? "fa fa-fw fa-money text-primary" : "img/compressed.gif",
										"Entrate", 
										"if (disableDblClick()) submitForm('doGestionaleEntrate')",
										"btn-secondary btn-outline-secondary btn-title text-primary",
										pdg_selezionato&&bp.isGestionaleAccessibile(), 
										bp.getParentRoot().isBootstrap());%>
							</td>
							<td>
								<%JSPUtils.button(out, 
										bp.getParentRoot().isBootstrap() ? "fa fa-fw fa-briefcase text-primary" : "img/transfer.gif",
										bp.getParentRoot().isBootstrap() ? "fa fa-fw fa-briefcase text-primary" : "img/transfer.gif",
										"Spese", 
										"if (disableDblClick()) submitForm('doGestionaleSpese')",
										"btn-secondary btn-outline-secondary btn-title text-primary",
										pdg_selezionato&&bp.isGestionaleAccessibile(), 
										bp.getParentRoot().isBootstrap());%></td>
						</tr>
					</table>
				</div>
			</div>				
			</td>
		</tr>
	</table>
</div>
<%	bp.closeFormWindow(pageContext); %>
</body>
</html>