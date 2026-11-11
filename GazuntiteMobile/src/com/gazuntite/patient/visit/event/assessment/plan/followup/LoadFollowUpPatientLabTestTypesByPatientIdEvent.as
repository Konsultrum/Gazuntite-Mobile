package com.gazuntite.patient.visit.event.assessment.plan.followup
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.QIController;
	
	public class LoadFollowUpPatientLabTestTypesByPatientIdEvent extends CairngormEvent
	{
		public function LoadFollowUpPatientLabTestTypesByPatientIdEvent()
		{
			super(QIController.LOAD_FOLLOW_UP_PATIENT_LAB_TEST_TYPES_BY_PATIENT_ID_EVENT);
		}
	}
}