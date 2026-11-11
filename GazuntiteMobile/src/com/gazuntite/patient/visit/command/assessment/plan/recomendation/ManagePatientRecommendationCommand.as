package com.gazuntite.patient.visit.command.assessment.plan.recomendation
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.dto.assessment.recommendation.RecommendationDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.history.event.assessment.plan.recommendation.LoadRecommendationByPatientIdPagedEvent;
	import com.gazuntite.patient.visit.delegate.assessment.plan.recomendation.ManagePatientRecommendationDelegate;
	import com.gazuntite.patient.visit.event.assessment.plan.recomendation.LoadPatientRecommendationByVisitIdEvent;
	import com.gazuntite.patient.visit.event.assessment.plan.recomendation.ManagePatientRecommendationEvent;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.patient.visit.utils.Constants;
	import com.gazuntite.patient.visit.utils.QIConstants;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class ManagePatientRecommendationCommand implements Command , IResponder
	{
		private var model:QIModelLocator = QIModelLocator.getInstance();
		private var sectionName:String;
		
		public function ManagePatientRecommendationCommand()
		{
		}
		
		public function execute(cgEvent:CairngormEvent):void
		{
			if (model.LoggedInUserId)
			{
				var delegate : ManagePatientRecommendationDelegate= new ManagePatientRecommendationDelegate( this );
				var LE:ManagePatientRecommendationEvent = cgEvent as ManagePatientRecommendationEvent;
				var arrCol:ArrayCollection;
				
				sectionName = LE.sectionName;
				
				switch (sectionName)
				{
					case QIConstants.INPUT_VIEW:
						
						arrCol = model.recommendationDTOList;
						
						break;
					
					case QIConstants.HISTORY_VIEW:
						
						arrCol = model.recommendationDTOHistoryList;
						
						break;
				}
				
				if (arrCol != null)
				{				
					var recommendationDTO:RecommendationDTO;
					var i:int;
					
					for (i = 0; i < arrCol.length; i++)
					{
						recommendationDTO = arrCol.getItemAt(i) as RecommendationDTO;
						
						if (recommendationDTO.VisitDate == null)
						{
							recommendationDTO.VisitDate = Constants.NULL_DATE;
						}
						
						recommendationDTO.ModifiedBy = model.LoggedInUserId;
						recommendationDTO.ModifiedAt = new Date();
					}
					
					var newList:ArrayCollection = new ArrayCollection();
					var actionDate:String = UtilityFunctions.FormatDate( new Date(), "MM-DD-YYYY");
					
					for (i = 0; i < arrCol.length; i++)
					{
						recommendationDTO = arrCol.getItemAt(i) as RecommendationDTO;
						
						if (recommendationDTO.IsDeleted == true || recommendationDTO.IsDirty == true)
						{
							newList.addItem(recommendationDTO);
						}
					}
					
					if (newList.length > 0)
						delegate.ManagePatientRecommendation(newList, model.LoggedInUserId, model.VisitID, model.patientDTO.ID,
									model.LoggedInUserSelectedBranchId, actionDate, model.LoggedInUserSessionID);
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
							
							var lpihEvent: LoadPatientRecommendationByVisitIdEvent = new LoadPatientRecommendationByVisitIdEvent(); 
							CairngormEventDispatcher.getInstance().dispatchEvent(lpihEvent);
							
							break;
						
						case QIConstants.HISTORY_VIEW:
							
							var loadHistoryEv:LoadRecommendationByPatientIdPagedEvent = new LoadRecommendationByPatientIdPagedEvent();
							CairngormEventDispatcher.getInstance().dispatchEvent(loadHistoryEv);
							
							break;
					}
				}
					
				else
				{
					UtilityFunctions.ShowMessage("ManagePatientRecommendationCommand \n\t " +
								"No data returned from service.\nMesage: \n\t" + re.result.@Message + "\nDetails: \n\t" + re.result.@Details ,"Info");
				}
			}
		}
		
		public function fault(rpcEvent:Object):void 
		{
			var errorStatus:String = "Fault occured in ManagePatientRecommendationCommand.";
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId); 
		}
	}
}