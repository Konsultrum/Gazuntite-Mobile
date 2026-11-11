package com.gazuntite.patient.history.event.assessment.treatment
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.QIController;
	
	public class LoadProcedureByPatientIdPagedEvent extends CairngormEvent
	{
		public function LoadProcedureByPatientIdPagedEvent()
		{
			super(QIController.LOAD_PROCEDURE_BY_PATIENT_ID_PAGED_EVENT);
		}
	}
}