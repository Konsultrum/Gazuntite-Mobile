package com.gazuntite.patient.history.event.assessment.plan.labOut
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.QIController;
	import com.gazuntite.patient.visit.utils.QIConstants;
	
	public class LoadLabsByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadLabsByPatientIdPagedEvent()
		{
			super (QIController.LOAD_LABS_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}