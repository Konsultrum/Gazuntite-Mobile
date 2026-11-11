package com.gazuntite.provider.eprescription.services.patient.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.provider.eprescription.services.patient.delegate.SaveNewRXDelegate;
	import com.gazuntite.provider.eprescription.services.patient.event.SaveNewRXEvent;
	
//	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	public class SaveNewRXCommand  implements Command 
	{
		private var responder:Responder;
		private var delegate:SaveNewRXDelegate;
		private var LE:SaveNewRXEvent;
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void
		{
			responder = new Responder(result, fault);				
			delegate  = new SaveNewRXDelegate( responder );			
			
			var LE:SaveNewRXEvent = cgEvent as SaveNewRXEvent;
			
			callBack = LE.functionName;
			var d:Date = new Date();
			delegate.SaveNewRX(LE.data, d);
		}
		
		public function result( rpcEvent : ResultEvent ) : void 
		{
			if( null != callBack )
				callBack(new XML(rpcEvent.message.body) );
		}
		
		public function fault( rpcEvent : Object ) : void 
		{
//			Alert.show("Fault occured in SaveNewRXCommand.\n"+rpcEvent.toString(), 'Info',4, FlexGlobals.topLevelApplication.mainContainer);
		}
	}
}