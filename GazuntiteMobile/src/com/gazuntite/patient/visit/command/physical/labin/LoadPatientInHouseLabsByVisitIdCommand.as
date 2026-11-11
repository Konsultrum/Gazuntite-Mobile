package com.gazuntite.patient.visit.command.physical.labin
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.physical.inHouseLab.InHouseLabDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.patient.visit.delegate.physical.labin.LoadPatientInHouseLabsByVisitIdDelegate;
	import com.gazuntite.patient.visit.event.physical.labin.LoadPatientInHouseLabsByVisitIdEvent;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.patient.visit.utils.QIConstants;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	public class LoadPatientInHouseLabsByVisitIdCommand implements Command, IResponder 
	{
		private var model:QIModelLocator = QIModelLocator.getInstance();
		private var LE:LoadPatientInHouseLabsByVisitIdEvent;
		private var onInHouseLabsLoadCallBack:Function;
		
		public function LoadPatientInHouseLabsByVisitIdCommand()
		{
		}
		
		public function execute(cgEvent:CairngormEvent):void 
		{
			if (model.LoggedInUserId)
			{
				LE = cgEvent as LoadPatientInHouseLabsByVisitIdEvent;
				
				onInHouseLabsLoadCallBack = LE.onInHouseLabLoadCallBack;
				
				var delegate:LoadPatientInHouseLabsByVisitIdDelegate = new  LoadPatientInHouseLabsByVisitIdDelegate(this);
				delegate.loadLabInByvisitID(model.VisitID, QIConstants.IsTemplateVisit, model.LoggedInUserSessionID);
			}
		}
		
		public function result(rpcEvent:Object):void 
		{
			if (model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				var xml:XMLList = re.result.ResponseData;
				
				if (xml != null)
				{
					var xlist:XMLList = xml.children();
					if (xlist != null)
					{
						var DTOlist:ArrayCollection = new ArrayCollection();
						
						var i:int = 1;
						
						for each (var x:XML in xlist)
						{
							var t:InHouseLabDTO = new InHouseLabDTO();
							t.FromXML(x);
							DTOlist.addItem(t);
						}
						
						model.inHouseLabDTOList = DTOlist;
						
						if (onInHouseLabsLoadCallBack)
							onInHouseLabsLoadCallBack(QIConstants.INPUT_VIEW);
					}	
				}
				else
				{
					UtilityFunctions.ShowMessage("LoadPatientByVisitIDCommand \n Service didnot respond.", "Info");
				}
			}
		}
		
		public function fault(rpcEvent:Object):void 
		{
			var errorStatus:String = "Fault occured in LoadPatientByVisitIDCommand.";
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId)? -1:model.LoggedInUserId;
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId);
		}
	}
}