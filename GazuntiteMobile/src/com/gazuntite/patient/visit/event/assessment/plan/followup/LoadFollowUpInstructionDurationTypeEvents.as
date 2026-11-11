package com.gazuntite.patient.visit.event.assessment.plan.followup
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.QIController;

	public class LoadFollowUpInstructionDurationTypeEvents extends CairngormEvent
	{
		public function LoadFollowUpInstructionDurationTypeEvents()
		{
			super(QIController.LOAD_INSTRUCTION_DURATION_TYPE_EVENT);
		}
	}
}