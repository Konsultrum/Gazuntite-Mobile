package com.gazuntite.patient.visit.event.assessment.plan.followup
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.QIController;

	public class ManagePatientFollowUpEvent extends CairngormEvent
	{
		public var sectionName:String;
		
		public function ManagePatientFollowUpEvent(_sectionName:String)
		{
			super (QIController.MANAGE_PATIENT_FOLLOW_UP_EVENT);
			
			sectionName = _sectionName;
		}
	}
}