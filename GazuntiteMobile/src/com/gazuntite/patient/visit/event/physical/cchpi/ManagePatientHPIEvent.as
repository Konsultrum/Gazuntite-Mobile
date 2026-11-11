package com.gazuntite.patient.visit.event.physical.cchpi
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.QIController;

	public class ManagePatientHPIEvent extends CairngormEvent
	{
		public var sectionName:String;
		
		public function ManagePatientHPIEvent(_sectionName:String)
		{
			super (QIController.MANAGE_PATIENT_HPI_EVENT);
			
			sectionName = _sectionName;
		}
	}
}