package com.gazuntite.patient.visit.event.NotesDictation
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.ModuleNoteDTO;
	import com.gazuntite.patient.visit.controller.QIController;
	
	public class ManageModuleNotesEvent extends CairngormEvent
	{
		public var notesDTO:ModuleNoteDTO;
		public var sectionName:String;
		
		public function ManageModuleNotesEvent(note:ModuleNoteDTO, sectionName:String)
		{
			super (QIController.MANAGE_MODULE_NOTES_BY_VISIT_ID_EVENT);
			
			this.notesDTO = note;
			this.sectionName = sectionName;
			
			note = null;
		}
	}
}