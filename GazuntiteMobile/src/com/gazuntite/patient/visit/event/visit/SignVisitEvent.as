package com.gazuntite.patient.visit.event.visit
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.QIController;

	public class SignVisitEvent extends CairngormEvent
	{
		public var visitId : int;
		
		public var functionName 	: Function;
		
		public function SignVisitEvent(visitId : int,functionName 	: Function) {
			super( QIController.SIGN_VISIT_EVENT);
			this.visitId = visitId;
			this.functionName = functionName;
			
		}
	}
}