package it.cnr.contab.missioni00.docs.bulk;

import java.util.ArrayList;
import java.util.List;

import org.apache.chemistry.opencmis.client.api.Document;
import org.apache.chemistry.opencmis.commons.PropertyIds;

import it.cnr.contab.cmis.annotation.CMISProperty;
import it.cnr.contab.missioni00.service.MissioniCMISService;
import it.cnr.contab.util00.bulk.cmis.AllegatoGenericoBulk;

public class AllegatoMissioneDettaglioSpesaBulk extends AllegatoGenericoBulk {
	private static final long serialVersionUID = 1L;

	private String aspectName;
	
	public AllegatoMissioneDettaglioSpesaBulk() {
		super();
		setAspectName(MissioniCMISService.ASPECT_MISSIONE_SIGLA_DETTAGLIO);
	}

	public AllegatoMissioneDettaglioSpesaBulk(Document node) {
		super(node);
		setAspectName(MissioniCMISService.ASPECT_MISSIONE_SIGLA_DETTAGLIO);
	}
	
	@CMISProperty(name=PropertyIds.SECONDARY_OBJECT_TYPE_IDS)
	public List<String> getAspect() {
		 List<String> results = new ArrayList<String>();
		 results.add("P:cm:titled");
		 if (getAspectName() != null){
			 results.add(getAspectName());
		 }
		 return results;
	}

	public boolean isAllegatoEsistente()
	{
		if(this.isToBeCreated())
			return false;

		return true;
	}

	public String getAspectName() {
		return aspectName;
	}

	public void setAspectName(String aspectName) {
		this.aspectName = aspectName;
	}
}
