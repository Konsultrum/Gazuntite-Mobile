package com.gazuntite.patient.history.event.assessment.diagnosis
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.QIController;
	
	public class LoadChronicDiagnosisByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadChronicDiagnosisByPatientIdPagedEvent()
		{
			super (QIController.LOAD_CHRONIC_DIAGNOSIS_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}