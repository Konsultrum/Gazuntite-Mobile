package com.gazuntite.patient.visit.event.assessment.plan.followup
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.QIController;

	public class LoadFollowUpByVisitIdEvent extends CairngormEvent
	{
		public function LoadFollowUpByVisitIdEvent()
		{
			super(QIController.LOAD_FOLLOW_UP_BY_VISIT_ID_EVENT);
		}
	}
}