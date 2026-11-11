package com.gazuntite.patient.visit.command.pmh.immunization
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.dto.pmh.immunization.ImmunizationDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.pmh.immunization.ManagePatientImmunizationDelegate;
	import com.gazuntite.patient.visit.event.pmh.immunization.LoadImmunizationByVisitIDEvent;
	import com.gazuntite.patient.visit.event.pmh.immunization.ManagePatientImmunizationEvent;
	import com.gazuntite.patient.visit.event.visit.GetVisitChargesEvent;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.patient.visit.utils.Constants;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class ManagePatientImmunizationCommand implements Command , IResponder
	{
		[Bindable] 
		private var model:QIModelLocator = QIModelLocator.getInstance();
		
		public function execute( cgEvent:CairngormEvent ) : void 
		{
			if (model.LoggedInUserId)
			{
				var delegate : ManagePatientImmunizationDelegate = new ManagePatientImmunizationDelegate( this );
				var LE:ManagePatientImmunizationEvent = cgEvent as ManagePatientImmunizationEvent;
				
				if (model.immunizationDTOList!=null)
				{				
					for(var i:int=0;i<model.immunizationDTOList.length;i++)
					{
						var immDTO:ImmunizationDTO = model.immunizationDTOList.getItemAt(i) as ImmunizationDTO;
						
						if(immDTO.DateAdmin == null)
						{
							immDTO.DateAdmin= Constants.NULL_DATE.toDateString();
						}
						if(immDTO.NextDoseDue == null)
						{
							immDTO.NextDoseDue= Constants.NULL_DATE.toDateString();
						}
						if(immDTO.VisitDate == null)
						{
							immDTO.VisitDate= Constants.NULL_DATE;
						}
						if(immDTO.ExpiryDate == null)
						{
							immDTO.ExpiryDate= Constants.NULL_DATE.toDateString();
						}
						
						immDTO.ModifiedBy = model.LoggedInUserId;
						immDTO.ModifiedAt = new Date();
					}
					
					var newList:ArrayCollection = new ArrayCollection();
					var actionDate:String = UtilityFunctions.FormatDate( new Date(), "MM-DD-YYYY");
					
					for(i=0;i<model.immunizationDTOList.length;i++)
					{
						var immunizationDTO:ImmunizationDTO = model.immunizationDTOList.getItemAt(i) as ImmunizationDTO;
						
						if(immunizationDTO.IsDeleted == true || immunizationDTO.IsDirty == true)
						{
							newList.addItem(immunizationDTO);
						}
					}
					if(newList.length > 0)
						delegate.ManagePatientImmunization(newList, model.LoggedInUserId, model.VisitID, actionDate, model.LoggedInUserSessionID);
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
					//[07/19/2013] Shahid Munir, to update visit charges in super bill
					var gvce:GetVisitChargesEvent = new GetVisitChargesEvent(model.VisitID); 
					CairngormEventDispatcher.getInstance().dispatchEvent(gvce);
					
					var lpviEvent:LoadImmunizationByVisitIDEvent = new LoadImmunizationByVisitIDEvent(); 
					CairngormEventDispatcher.getInstance().dispatchEvent(lpviEvent);
				}
				else
					UtilityFunctions.ShowMessage("ManagePatientImmunization \n\t No data returned from service.\nMesage: \n\t" + re.result.@Message + "\nDetails: \n\t" + re.result.@Details ,"Info");
			}
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			var errorStatus:String = "Fault occured in ManageImmunizationCommand.";
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId )? -1:model.LoggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId); 
			
		}
		
	}
}