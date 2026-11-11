package com.gazuntite.patient.visit.event.assessment.plan.recomendation
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.QIController;

	public class ManagePatientRecommendationEvent extends CairngormEvent
	{
		public var sectionName:String;
		
		public function ManagePatientRecommendationEvent(_sectionName:String)
		{
			super(QIController.MANAGE_PATIENT_RECOMMANDATION_EVENT);
			
			sectionName = _sectionName;
		}
	}
}