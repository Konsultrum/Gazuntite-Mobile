package com.gazuntite.patient.visit.command.visit
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.visit.CoSignVisitDelegate;
	import com.gazuntite.patient.visit.event.visit.CoSignVisitEvent;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.patient.visit.utils.Constants;
	import com.gazuntite.utils.UtilityFunctions;
	
//	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class CoSignVisitCommand  implements Command, IResponder
	{
		private var model : QIModelLocator = QIModelLocator.getInstance();
		public var functionName 	: Function;
		
		public function CoSignVisitCommand()
		{
		}
		
		public function execute( cgEvent:CairngormEvent ) : void {
			if(model.LoggedInUserId)
			{
				var delegate : CoSignVisitDelegate = new CoSignVisitDelegate( this );
				
				var LE:CoSignVisitEvent = cgEvent as CoSignVisitEvent;
				this.functionName	   = LE.functionName;
				//var visitId:int = LE.visitId;
				
				var opetationDate:String = new Date().toString();
				
				if(model.VisitID>0)
				{
					delegate.CoSignVisit(model.VisitID,model.LoggedInUserProviderId , model.LoggedInUserId,model.LoggedInUserProviderTypeId , opetationDate);
				}
			}
		}
		
		
		public function result( rpcEvent : Object ) : void {
			if(model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				//var serviceResponse:re.result  = re.result as ServiceResponse ;
				if(re.result.@Status!=null)
				{
					if(re.result.@Status == "true")
					{
						if(this.functionName!=null)
						{
							this.functionName(Constants.VISIT_SIGNED);
						}
						
					}
					else
					{
						/*model.errorStatus = serviceResponse.ResponseMessage ;
						var valid:Boolean = QSUtilityFunctions.checkSession(serviceResponse.ResponseCode);
						if(valid)*/
//						Alert.show("CoSignVisit"+"\n"+re.result.ResponseMessage,"Info",4, FlexGlobals.topLevelApplication.mainContainer);
					}
				}
				else
				{
//					Alert.show("CoSignVisit"+"\n"+ "SERVICE_DIDNOT_RESPOND"+"",  "Info",4, FlexGlobals.topLevelApplication.mainContainer);
				}
			}
		}
		
		
		public function fault( rpcEvent : Object ) : void {
			
			var errorStatus:String = "Fault occured in CoSignVisitCommand.";
			var userId:int = UtilityFunctions.IsNullOrEmpty( model.LoggedInUserId )? -1:model.LoggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId); 
			
		}
	}
}