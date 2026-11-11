package com.gazuntite.patient.history.event.physical.inHouseLab
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.gazuntite.skins.chrome.buttonSkins.superBillAddButton;
	import com.gazuntite.patient.history.dto.PageDTO;
	import com.gazuntite.patient.visit.controller.QIController;
	
	public class LoadInHouseLabsByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadInHouseLabsByPatientIdPagedEvent()
		{
			super(QIController.LOAD_IN_HOUSE_LABS_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}