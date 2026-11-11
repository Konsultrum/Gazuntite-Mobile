package com.gazuntite.patient.visit.command.assessment.plan.followup
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.dto.assessment.followUp.FollowUpDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.history.event.assessment.plan.followUp.LoadFollowUpByPatientIdPagedEvent;
	import com.gazuntite.patient.visit.delegate.assessment.plan.followup.ManagePatientFollowUpDelegate;
	import com.gazuntite.patient.visit.event.assessment.plan.followup.LoadFollowUpByVisitIdEvent;
	import com.gazuntite.patient.visit.event.assessment.plan.followup.ManagePatientFollowUpEvent;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.patient.visit.utils.Constants;
	import com.gazuntite.patient.visit.utils.QIConstants;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class ManagePatientFollowUpCommand implements Command, IResponder
	{
		private var model:QIModelLocator = QIModelLocator.getInstance();
		private var sectionName:String;
		
		public function ManagePatientFollowUpCommand()
		{
		}
		
		public function execute(cgEvent:CairngormEvent):void
		{
			if (model.LoggedInUserId)
			{
				var delegate:ManagePatientFollowUpDelegate= new ManagePatientFollowUpDelegate(this);
				var LE:ManagePatientFollowUpEvent = cgEvent as ManagePatientFollowUpEvent;
				var arrCol:ArrayCollection;
				
				sectionName = LE.sectionName;
				
				switch (sectionName)
				{
					case QIConstants.INPUT_VIEW:
						
						arrCol = model.followUpDTOList;
						
						break;
					
					case QIConstants.HISTORY_VIEW:
						
						arrCol = model.followUpDTOHistoryList;
						
						break;
				}
				
				if (arrCol != null)
				{
					var followUp:FollowUpDTO;
					var i:int;
					
					for (i = 0; i < arrCol.length; i++)
					{
						followUp = arrCol.getItemAt(i) as FollowUpDTO;
						
						if (followUp.VisitDate == null)
						{
							followUp.VisitDate= Constants.NULL_DATE;
						}
						
						followUp.ModifiedBy = model.LoggedInUserId;
						followUp.ModifiedAt = new Date();
					}
					
					var newList:ArrayCollection = new ArrayCollection();
					
					for (i = 0; i < arrCol.length; i++)
					{
						 followUp = arrCol.getItemAt(i) as FollowUpDTO;
						
						if (followUp.IsDeleted == true || followUp.IsDirty == true)
						{
							newList.addItem(followUp);
						}
					}
					
					if (newList.length > 0)
						delegate.ManagefollowUp(newList, model.LoggedInUserSessionID);
				}
			}
		}	
		
		public function result(rpcEvent:Object):void
		{
			if (model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if (re.result.@Status == "true")
				{
					switch (sectionName)
					{
						case QIConstants.INPUT_VIEW:
							
							var lpihEvent:LoadFollowUpByVisitIdEvent = new LoadFollowUpByVisitIdEvent(); 
							CairngormEventDispatcher.getInstance().dispatchEvent( lpihEvent );
							
							break;
						
						case QIConstants.HISTORY_VIEW:
							
							var loadHistoryEv:LoadFollowUpByPatientIdPagedEvent = new LoadFollowUpByPatientIdPagedEvent();
							CairngormEventDispatcher.getInstance().dispatchEvent(loadHistoryEv);
							
							break;
					}
				}
					
				else
				{
					UtilityFunctions.ShowMessage("ManagePatientfollowup \n\t No data returned from service.\nMesage: \n\t" + 
								re.result.@Message + "\nDetails: \n\t" + re.result.@Details ,"Info");
				}
			}
		}
		
		public function fault(rpcEvent:Object):void 
		{
			var errorStatus:String = "Fault occured in ManagePatientfollowup.";
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId) ? -1 : model.LoggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId); 
		}
	}
}