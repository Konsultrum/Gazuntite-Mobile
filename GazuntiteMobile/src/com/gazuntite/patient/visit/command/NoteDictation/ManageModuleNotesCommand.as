package com.gazuntite.patient.visit.command.NoteDictation
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.dto.ModuleNoteDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.history.event.dictationNote.LoadModuleDictationNoteByPatientIDEvent;
	import com.gazuntite.patient.visit.delegate.NoteDictation.ManageModuleNotesDelegate;
	import com.gazuntite.patient.visit.event.NotesDictation.LoadModuleNotesByVisitIdEvent;
	import com.gazuntite.patient.visit.event.NotesDictation.ManageModuleNotesEvent;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.patient.visit.utils.QIConstants;
	import com.gazuntite.utils.UtilityFunctions;
	
//	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class ManageModuleNotesCommand implements Command , IResponder
	{
		[Bindable]
		private var model:QIModelLocator = QIModelLocator.getInstance();
		private var LE:ManageModuleNotesEvent;
		private var notesDTO:ModuleNoteDTO;
		private var sectionName:String;
		
		public function ManageModuleNotesCommand()
		{
		}
		
		public function execute(cgEvent:CairngormEvent):void
		{
			if (model.LoggedInUserId)
			{
				LE = cgEvent as ManageModuleNotesEvent;
				
				notesDTO = LE.notesDTO;
				sectionName = LE.sectionName;
				
				var delegate:ManageModuleNotesDelegate = new ManageModuleNotesDelegate(this);
				
				var actionDate:String = UtilityFunctions.FormatDate(new Date(), "MM-DD-YYYY");
				
				if (notesDTO)
					delegate.ManageNotes(notesDTO, model.LoggedInUserId, notesDTO.VisitID, actionDate, model.LoggedInUserSessionID);
			}
		}	
	
		public function result(rpcEvent:Object):void
		{
			if (model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if (re.result.@Status == "true")
				{
//					Alert.show("Notes Saved.", "Info", Alert.OK, FlexGlobals.topLevelApplication.mainContainer, function():void
//					{
						switch (sectionName)
						{
							case QIConstants.INPUT_VIEW:
								
								var NV:LoadModuleNotesByVisitIdEvent = new LoadModuleNotesByVisitIdEvent();
								CairngormEventDispatcher.getInstance().dispatchEvent(NV);
								
								break;
						}
						
						var ev:LoadModuleDictationNoteByPatientIDEvent = new LoadModuleDictationNoteByPatientIDEvent();
						CairngormEventDispatcher.getInstance().dispatchEvent(ev);
//					});
				}
					
				else
				{
					UtilityFunctions.ShowMessage("ManageNotes \n\t No data returned from service.\nMesage: \n\t" + re.result.@Message + "\nDetails: \n\t" + re.result.@Details ,"Info");
				}
			}
		}
		
		public function fault(rpcEvent:Object):void 
		{
			var errorStatus:String = "Fault occured in ManageNotes.";
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId)? -1:model.LoggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId);
		}
	}
}