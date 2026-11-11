package com.gazuntite.common.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.LoadPatientMedDelegate;
	import com.gazuntite.common.event.LoadPatientMedEvent;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
//	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	public class LoadPatientMedCommand  implements Command 
	{
		private var responder:Responder;
		private var delegate:LoadPatientMedDelegate;
		private var LE:LoadPatientMedEvent;
		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			responder = new Responder(result, fault);				
			delegate  = new LoadPatientMedDelegate( responder );			
			
			var LE:LoadPatientMedEvent = cgEvent as LoadPatientMedEvent;
			
			callBack = LE.resultHandlerFunction;
			
			delegate.GetPatientPrescription(LE.data, LE.encounterId, LE.gaxenPatientId);
		}
		
		public function result( rpcEvent : ResultEvent ) : void 
		{	
			 var patientMedAC:ArrayCollection 		= new ArrayCollection();
			 var patientChronicMedAC:ArrayCollection = new ArrayCollection();
			
			 var patientMedAC_inactive:ArrayCollection 		= new ArrayCollection();
			 var patientChronicMedAC_inactive:ArrayCollection = new ArrayCollection();
			
			var response:XML = XML(rpcEvent.message.body.toString());
			response = removeDefaultNamespaceFromXML(response);
			
			for(var i:int = 0; i < response.PMedication.Messages.length(); i++)
			{
				var drugName:String = response.PMedication.Messages[i].@DrugName.toString();
				var dose:String = response.PMedication.Messages[i].@Dose.toString();
				var quantity:String = response.PMedication.Messages[i].@Quantity.toString(); 
				var ndc:String = response.PMedication.Messages[i].@NDCCODE.toString(); 
				var Refill:String = response.PMedication.Messages[i].@Refill.toString();
				var isPRN:String = response.PMedication.Messages[i].@isPRN.toString();
				var sig:String = response.PMedication.Messages[i].@SIG.toString();
				
				var Obj:Object = new Object();
				
				Obj.VisitDate 	= response.PMedication.Messages[i].@VisitDate.toString();
				/* Obj.Type	 	= response.PMedication.Messages[i].@Type.toString(); */
				Obj.drugName 	= drugName;
				Obj.Sig 		= sig;
				Obj.Dose 		= dose;
				Obj.Quantity 	= quantity+", "+response.PMedication.Messages[i].@QuantityForm.toString();
				//Obj.NDCCODE 	= ndc;
				Obj.Refill 		= Refill;
				Obj.isPRN 		= isPRN;
				
				Obj.frequency 	= response.PMedication.Messages[i].@frequency.toString();					
				Obj.Route 		= response.PMedication.Messages[i].@Route.toString();
				
				/**
				 * Ayesha: 21/05/2013
				 * inEditMode is only related to view, to display renderer either in edit or in view mode
				 **/
				Obj.inEditMode = false;
				
				if(response.PMedication.Messages[i].@isActive.toString() == "false")
				{
					patientMedAC_inactive.addItem(Obj);
				}
				else
				{
					patientMedAC.addItem(Obj);	
				}
			}
			
			for(var i:int=0; i<response.PChronicMedication.Messages.length(); i++)
			{
				var drugName:String 	= response.PChronicMedication.Messages[i].@DrugName.toString();
				var dose:String 		= response.PChronicMedication.Messages[i].@Dose.toString();
				var quantity:String 	= response.PChronicMedication.Messages[i].@Quantity.toString(); 
				var ndc:String 			= response.PChronicMedication.Messages[i].@NDCCODE.toString(); 
				var ndc:String 			= response.PChronicMedication.Messages[i].@NDCCODE.toString(); 
				var isPRN:String 		= response.PChronicMedication.Messages[i].@isPRN.toString();
				var Refill:String 		= response.PChronicMedication.Messages[i].@Refill.toString();
				
				var Obj:Object = new Object();
				
				Obj.Type 		= response.PChronicMedication.Messages[i].@Type.toString();
				Obj.VisitDate	= response.PChronicMedication.Messages[i].@VisitDate.toString();
				Obj.drugName 	= drugName;
				
				Obj.SIG			= response.PChronicMedication.Messages[i].@SIG.toString();										
				Obj.Dose 		= dose;
				Obj.Quantity 	= quantity + ", "+response.PChronicMedication.Messages[i].@QuantityForm.toString();;
				
				Obj.Status	 	= response.PChronicMedication.Messages[i].@MessageStatus.toString();
				Obj.NDCCODE 	= ndc;
				Obj.Refill 		= Refill;
				Obj.isPRN 		= isPRN;
				
				/**
				 * Ayesha: 21/05/2013
				 * inEditMode is only related to view, to display renderer either in edit or in view mode
				 **/
				Obj.inEditMode = false;
				
				if(response.PChronicMedication.Messages[i].@isActive.toString() == "false")
				{
					patientChronicMedAC_inactive.addItem(Obj);
				}
				else
				{
					patientChronicMedAC.addItem(Obj);
				}
			}
			
			if( null != callBack )
			{
				callBack(patientMedAC, patientChronicMedAC, patientMedAC_inactive, patientChronicMedAC_inactive);
				//callBack(new XML(rpcEvent.message.body.toString()));
			}
		}
		
		private function removeDefaultNamespaceFromXML(xml:XML):XML
		{
			var rawXMLString:String = xml.toXMLString();
			
			/* Define the regex pattern to remove the default namespace from the 
			String representation of the XML result. */
			var xmlnsPattern:RegExp = 
				new RegExp("xmlns=[^\"]*\"[^\"]*\"", "gi");
			
			/* Replace the default namespace from the String representation of the 
			result XML with an empty string. */
			var cleanXMLString:String = rawXMLString.replace(xmlnsPattern, "");
			
			// Create a new XML Object from the String just created
			return new XML(cleanXMLString);
		}
		public function fault( rpcEvent : Object ) : void 
		{
//			Alert.show("Fault occured in LoadPatientMedCommand.\n"+rpcEvent.toString(), 'Error occured on server', 4, FlexGlobals.topLevelApplication.mainContainer as Sprite );
		}
	}
}