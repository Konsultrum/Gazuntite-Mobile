package com.gazuntite.patient.visit.command.assessment.diagnosis
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.dto.assessment.diagnosis.DiagnosisDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.history.event.assessment.diagnosis.LoadAcuteDiagnosisByPatientIdPagedEvent;
	import com.gazuntite.patient.history.event.assessment.diagnosis.LoadChronicDiagnosisByPatientIdPagedEvent;
	import com.gazuntite.patient.history.event.assessment.diagnosis.LoadResolvedDiagnosisByPatientIdPagedEvent;
	import com.gazuntite.patient.visit.delegate.assessment.diagnosis.ManagePatientDiagnosisDelegate;
	import com.gazuntite.patient.visit.event.assessment.diagnosis.LoadPatientDiagnosisByVisitIdEvent;
	import com.gazuntite.patient.visit.event.assessment.diagnosis.ManagePatientDiagnosisEvent;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.patient.visit.utils.Constants;
	import com.gazuntite.patient.visit.utils.QIConstants;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import org.osmf.net.SwitchingRuleBase;

	public class ManagePatientDiagnosisCommand implements Command , IResponder
	{
		[Bindable]
		private var model:QIModelLocator = QIModelLocator.getInstance();
		private var sectionName:String;
		
		public function ManagePatientDiagnosisCommand()
		{
		}
		
		public function execute(cgEvent:CairngormEvent):void
		{
			
			if (model.LoggedInUserId)
			{
				var LE:ManagePatientDiagnosisEvent = cgEvent as ManagePatientDiagnosisEvent;
				
				sectionName = LE.sectionName;
				
				var delegate:ManagePatientDiagnosisDelegate = new ManagePatientDiagnosisDelegate(this);
				var arrCol:ArrayCollection;
				
				switch (sectionName)
				{
					case QIConstants.INPUT_VIEW:
						
						arrCol = model.diagnosisDTOList;
						
						break;
					
					case QIConstants.ACUTE_DIAGNOSIS_HISTORY:
						
						arrCol = model.diagnosisDTOAcuteHistoryList;
						
						break;
					
					case QIConstants.CHRONIC_DIAGNOSIS_HISTORY:
						
						arrCol = model.diagnosisDTOChronicHistoryList;
						
						break;
					
					case QIConstants.RESOLVED_DIAGNOSIS_HISTORY:
						
						arrCol = model.diagnosisDTOResolvedHistoryList;
						
						break;
				}
				
				if (arrCol != null)
				{
					var i:int;
					var diagnosisDTO:DiagnosisDTO;
					
					for (i = 0; i < arrCol.length; i++)
					{
						 diagnosisDTO = arrCol.getItemAt(i) as DiagnosisDTO;
						
						if (diagnosisDTO.VisitDate == null)
						{
							diagnosisDTO.VisitDate= Constants.NULL_DATE;
						}
						
						diagnosisDTO.ModifiedBy = model.LoggedInUserId;
						diagnosisDTO.ModifiedAt = new Date();
					}
					
					var newList:ArrayCollection = new ArrayCollection();
					var actionDate:String = UtilityFunctions.FormatDate( new Date(), "MM-DD-YYYY");
					
					for (i = 0; i < arrCol.length; i++)
					{
						diagnosisDTO = arrCol.getItemAt(i) as DiagnosisDTO;
						
						if (diagnosisDTO.IsDeleted == true || diagnosisDTO.IsDirty == true)
						{
							newList.addItem(diagnosisDTO);
						}	
					}
					
					if (newList.length > 0)
						delegate.ManagePatientDiagnosis(newList, model.LoggedInUserId, model.VisitID , model.patientID, actionDate, model.LoggedInUserSessionID);
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
							 
							 var lpihEvent:LoadPatientDiagnosisByVisitIdEvent = new LoadPatientDiagnosisByVisitIdEvent(); 
							 CairngormEventDispatcher.getInstance().dispatchEvent( lpihEvent );
							 
							 break;
						 
						 case QIConstants.ACUTE_DIAGNOSIS_HISTORY:
							 
							 var ladp:LoadAcuteDiagnosisByPatientIdPagedEvent = new LoadAcuteDiagnosisByPatientIdPagedEvent();
							 CairngormEventDispatcher.getInstance().dispatchEvent(ladp);
							 
							 break;
						 
						 case QIConstants.CHRONIC_DIAGNOSIS_HISTORY:
							 
							 var lcdp:LoadChronicDiagnosisByPatientIdPagedEvent = new LoadChronicDiagnosisByPatientIdPagedEvent();
							 CairngormEventDispatcher.getInstance().dispatchEvent(lcdp);
							 
							 break;
						 
						 case QIConstants.RESOLVED_DIAGNOSIS_HISTORY:
							 
							 var lrdp:LoadResolvedDiagnosisByPatientIdPagedEvent = new LoadResolvedDiagnosisByPatientIdPagedEvent();
							 CairngormEventDispatcher.getInstance().dispatchEvent(lrdp);
							 
							 break;
					}
				}
					
				else
				{
					UtilityFunctions.ShowMessage("ManagePatientDiagnosis \n\t No data returned from service.\nMesage: \n\t" + re.result.@Message + "\nDetails: \n\t" + re.result.@Details ,"Info");
				}
			}
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
			var errorStatus:String = "Fault occured in ManagePatientDiagnosis.";
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId )? -1:model.LoggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show( errorStatus, rpcEvent.toString(), userId); 
		}
	}
}