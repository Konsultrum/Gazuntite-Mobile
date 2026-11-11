package com.gazuntite.patient.history.event.assessment.plan.followUp
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.QIController;
	
	public class LoadFollowUpByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadFollowUpByPatientIdPagedEvent()
		{
			super (QIController.LOAD_FOLLOW_UP_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}