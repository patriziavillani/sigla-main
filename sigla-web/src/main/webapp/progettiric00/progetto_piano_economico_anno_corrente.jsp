<%@ page pageEncoding="UTF-8"
	import="it.cnr.jada.action.*,
	    java.util.Optional,
		it.cnr.jada.bulk.*,
		it.cnr.jada.util.action.*,
		it.cnr.jada.util.jsp.*,
		it.cnr.contab.progettiric00.bp.*,
		it.cnr.contab.progettiric00.core.bulk.*"
%>

<%
	TestataProgettiRicercaBP bp = (TestataProgettiRicercaBP)BusinessProcess.getBusinessProcess(request);
	SimpleDetailCRUDController controller = bp.getCrudPianoEconomicoAnnoCorrente();
	SimpleDetailCRUDController controllerVoci = bp.getCrudPianoEconomicoVoceBilancioAnnoCorrente();
	String fieldAmm = Optional.ofNullable(bp)
	            .filter(AmministraTestataProgettiRicercaBP.class::isInstance)
	            .map(amm -> "_amm")
	            .orElse("");
	boolean isKeyEditable = controller.getModel()!=null && controller.getModel().isNotNew();
	boolean isROProgettoForStato = Optional.ofNullable(bp.getModel()).filter(ProgettoBulk.class::isInstance).map(ProgettoBulk.class::cast)
			.map(ProgettoBulk::isROProgettoForStato).orElse(Boolean.FALSE);
%>

<%	controller.writeHTMLTable(pageContext,"piano_economico1",true,false,true,"100%","auto"); %>
<table class="Panel card p-2 mt-1">
  <tr>
  	<td><% controller.writeFormLabel(out,"voce_piano");%></td>
  	<td colspan="3"><% controller.writeFormInput(out,null,"voce_piano" + fieldAmm,isKeyEditable,null,null);%></td>
  </tr>
  <tr>
  	<TD><% controller.writeFormLabel(out,"im_spesa_finanziato");%></TD>
  	<TD><% controller.writeFormInput(out,null,"im_spesa_finanziato" + fieldAmm,isROProgettoForStato,null,null);%></TD>
  	<TD><% controller.writeFormLabel(out,"im_spesa_cofinanziato");%></TD>
  	<TD><% controller.writeFormInput(out,null,"im_spesa_cofinanziato" + fieldAmm,isROProgettoForStato,null,null);%></TD> 
  	<% controller.writeFormField(out,"imTotaleSpesa");%>
  </tr>
</table>
</br>
<fieldset class="fieldset">
	<legend class="GroupLabel text-primary">Voci Bilancio Associate</legend>
<%	controllerVoci.writeHTMLTable(pageContext,"voce_bilancio",true,false,true,"100%","auto"); %>
	</br>
	<table class="Panel">
	  <tr>
	  	<TD><% controller.writeFormLabel(out,"elemento_voce");%></TD>
	  	<TD><% controller.writeFormInput(out,null,"elemento_voce",isROProgettoForStato,null,null);%></TD>
	  </tr>	
	</table>	
</fieldset>