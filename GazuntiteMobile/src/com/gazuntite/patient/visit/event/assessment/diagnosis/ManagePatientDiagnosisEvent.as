package com.gazuntite.patient.visit.event.assessment.diagnosis
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.QIController;

	public class ManagePatientDiagnosisEvent extends CairngormEvent
	{
		public var sectionName:String;
		
		public function ManagePatientDiagnosisEvent(_sectionName:String)
		{
			super (QIController.MANAGE_PATIENT_DIAGNOSIS_EVENT);
			
			this.sectionName = _sectionName;
		}
	}
}