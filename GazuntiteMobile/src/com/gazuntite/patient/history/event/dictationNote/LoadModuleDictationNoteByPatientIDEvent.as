package com.gazuntite.patient.history.event.dictationNote
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.patient.visit.controller.QIController;
	
	public class LoadModuleDictationNoteByPatientIDEvent extends CairngormEvent
	{
		public function LoadModuleDictationNoteByPatientIDEvent()
		{
			super (QIController.LOAD_MODULE_DICTATION_NOTE_BY_PATIENT_ID_EVENT);
		}
	}
}