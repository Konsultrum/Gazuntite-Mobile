package com.gazuntite.patient.visit.command.pmh.comphistory
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.dto.pmh.compHistory.SocialHistoryDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.pmh.comphistory.ManagePatientSocialHistoryDeleteDelegate;
	import com.gazuntite.patient.visit.event.pmh.comphistory.LoadSocialHistoryByPatientIdEvent;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.managers.CursorManager;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.utils.StringUtil;

	public class ManagePatientSocialHistoryDeleteCommand implements Command,IResponder
	{
		private var model:QIModelLocator = QIModelLocator.getInstance();
		private var delegate:ManagePatientSocialHistoryDeleteDelegate;
		private var responder:Responder;
		
		public function execute(cgEvent:CairngormEvent):void 
		{
			CursorManager.setBusyCursor();
			
			delegate  = new ManagePatientSocialHistoryDeleteDelegate( this );			
			
			var dto:SocialHistoryDTO = model.socialHistoryDTO;
			dto.Social = StringUtil.trim(dto.Social);
			
			delegate.ManagePatientSocialHistoryDelete(dto.patientSocialHistoryAddictionID, dto.Social, dto.PatientSocialHistoryID, model.LoggedInUserId);
		}
		
		public function result(rpcEvent:Object):void
		{
			CursorManager.removeBusyCursor();
			
			var loadSocialHistoryEvent:LoadSocialHistoryByPatientIdEvent = new LoadSocialHistoryByPatientIdEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent(loadSocialHistoryEvent);
		}
		
		public function  fault(rpcEvent:Object):void
		{
			CursorManager.removeBusyCursor();
			
			var errorStatus:String = "Fault occured in ManagePatientSocialHistoryDeleteCommand.";
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId )? -1 : model.LoggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId); 
		}
	}
}