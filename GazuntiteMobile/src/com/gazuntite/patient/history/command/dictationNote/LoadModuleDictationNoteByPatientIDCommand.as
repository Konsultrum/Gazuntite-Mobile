package com.gazuntite.patient.history.command.dictationNote
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.dto.DictationNoteHistoryDTO;
	import com.gazuntite.common.dto.ModuleTypeDTO;
	import com.gazuntite.common.dto.pmh.immunization.ImmunizationDTO;
	import com.gazuntite.common.util.exceptionAlert.QSCombinedExceptionAlert;
	import com.gazuntite.components.dictation.PatientDictationNoteHistoryListIR;
	import com.gazuntite.patient.history.delegate.dictationNote.LoadModuleDictationNoteByPatientIDDelegate;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.patient.visit.utils.Constants;
	import com.gazuntite.patient.visit.utils.QIUtilityFunctions;
	import com.gazuntite.utils.UtilityFunctions;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class LoadModuleDictationNoteByPatientIDCommand implements Command, IResponder
	{
		private var model:QIModelLocator = QIModelLocator.getInstance();
		
		private var allergyList:ArrayCollection;
		private var compHistoryList:ArrayCollection;
		private var chronicMedicationList:ArrayCollection;
		
		public function LoadModuleDictationNoteByPatientIDCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			if (model.LoggedInUserId)
			{	
				var delegate:LoadModuleDictationNoteByPatientIDDelegate = new  LoadModuleDictationNoteByPatientIDDelegate(this);
				delegate.loadModuleDictationNoteByPatientID(model.patientDTO.ID, model.LoggedInUserSessionID);
			}
		}
		
		public function result(rpcEvent:Object):void
		{
			if (model.LoggedInUserId)
			{
				var re:ResultEvent = rpcEvent as ResultEvent;
				
				if (re.result.@Status == "true")
				{
					var xml:XMLList = re.result.ResponseData;
					
					if (!xml)
						return;
					
					var list:XMLList = xml.children();
					
					var moduleDictationNoteHistorylist:ArrayCollection = new ArrayCollection();
					
					if (list != null)
					{
						clearAllDictatioNotes();
						
						for each (var c:XML in list)
						{
							var dto:DictationNoteHistoryDTO = new DictationNoteHistoryDTO();
							dto.FromXML(c);
							
							moduleDictationNoteHistorylist.addItem(dto);
							
							filterDictationNotesByModules(dto);
						}
						
						if (model.moduleDictationList.length > 0)
							model.moduleDictationList.removeAll();
						
						
						/*if(model.NotesDictationFlag)
						model.checkNotesExsist = true;
						else
						model.NotesDictationFlag = true;*/
					}
				}
			}
			else
			{
				UtilityFunctions.ShowMessage("LoadModuleDictationByPatientID \n Service didnot respond.", "Info");
			}
		}
		
		private function clearAllDictatioNotes():void
		{
			if (model.allergyDictationNoteHistoryDTOList)
				model.allergyDictationNoteHistoryDTOList.removeAll();
			
			if (model.comprehensiveHistoryDictationNoteHistoryDTOList)
				model.comprehensiveHistoryDictationNoteHistoryDTOList.removeAll();
			
			if (model.chronicMedicationDictationNoteHistoryDTOList)
				model.chronicMedicationDictationNoteHistoryDTOList.removeAll();
			
			if (model.immunizationDictationNoteHistoryDTOList)
				model.immunizationDictationNoteHistoryDTOList.removeAll();
			
			if (model.chiefComplaintDictationNoteHistoryDTOList)
				model.chiefComplaintDictationNoteHistoryDTOList.removeAll();
			
			if (model.reviewOfSystemDictationNoteHistoryDTOList)
				model.reviewOfSystemDictationNoteHistoryDTOList.removeAll();
			
			if (model.physicalDictationNoteHistoryDTOList)
				model.physicalDictationNoteHistoryDTOList.removeAll();
			
			if (model.inHouseLabDictationNoteHistoryDTOList)
				model.inHouseLabDictationNoteHistoryDTOList.removeAll();
			
			if (model.diagosisDictationNoteHistoryDTOList)
				model.diagosisDictationNoteHistoryDTOList.removeAll();
			
			if (model.treatmentDictationNoteHistoryDTOList)
				model.treatmentDictationNoteHistoryDTOList.removeAll();
			
			if (model.planDictationNoteHistoryDTOList)
				model.planDictationNoteHistoryDTOList.removeAll();
		}
		
		private function filterDictationNotesByModules(dictationNoteHistoryDTO:DictationNoteHistoryDTO):void
		{
			if (!dictationNoteHistoryDTO)
				return;
			
			var module:ModuleTypeDTO = QIUtilityFunctions.getModuleTypeDTOByID(dictationNoteHistoryDTO.ModuleTypeID);
			
			if (!module)
				return;
			
			switch (module.ModuleName)
			{
				case Constants.ALLERGY_MODULE_NAME:
					
					if (!model.allergyDictationNoteHistoryDTOList)
						model.allergyDictationNoteHistoryDTOList = new ArrayCollection();
					
					model.allergyDictationNoteHistoryDTOList.addItem(dictationNoteHistoryDTO);
					
					dictationNoteHistoryDTO.serialNumber = model.allergyDictationNoteHistoryDTOList.length;
					
					break;
				
				case Constants.COMPREHENSIVE_HISTORY_MODULE_NAME:
					
					if (!model.comprehensiveHistoryDictationNoteHistoryDTOList)
						model.comprehensiveHistoryDictationNoteHistoryDTOList = new ArrayCollection();
					
					model.comprehensiveHistoryDictationNoteHistoryDTOList.addItem(dictationNoteHistoryDTO);
					
					dictationNoteHistoryDTO.serialNumber = model.comprehensiveHistoryDictationNoteHistoryDTOList.length;
					
					break;
				
				
				case Constants.CHRONIC_MEDICATION_MODULE_NAME:
					
					if (!model.chronicMedicationDictationNoteHistoryDTOList)
						model.chronicMedicationDictationNoteHistoryDTOList = new ArrayCollection();
					
					model.chronicMedicationDictationNoteHistoryDTOList.addItem(dictationNoteHistoryDTO);
					
					dictationNoteHistoryDTO.serialNumber = model.chronicMedicationDictationNoteHistoryDTOList.length;
					
					break;
				
				case Constants.IMMUNIZATION_MODULE_NAME:
					
					if (!model.immunizationDictationNoteHistoryDTOList)
						model.immunizationDictationNoteHistoryDTOList = new ArrayCollection();
					
					model.immunizationDictationNoteHistoryDTOList.addItem(dictationNoteHistoryDTO);
					
					dictationNoteHistoryDTO.serialNumber = model.immunizationDictationNoteHistoryDTOList.length;
					
					break;
				
				case Constants.CHIEF_COMPLAINT_MODULE_NAME:
					
					if (!model.chiefComplaintDictationNoteHistoryDTOList)
						model.chiefComplaintDictationNoteHistoryDTOList = new ArrayCollection();
					
					model.chiefComplaintDictationNoteHistoryDTOList.addItem(dictationNoteHistoryDTO);
					
					dictationNoteHistoryDTO.serialNumber = model.chiefComplaintDictationNoteHistoryDTOList.length;
					
					break;
				
				case Constants.REVIEW_OF_SYSTEM_MODULE_NAME:
					
					if (!model.reviewOfSystemDictationNoteHistoryDTOList)
						model.reviewOfSystemDictationNoteHistoryDTOList = new ArrayCollection();
					
					model.reviewOfSystemDictationNoteHistoryDTOList.addItem(dictationNoteHistoryDTO);
					
					dictationNoteHistoryDTO.serialNumber = model.reviewOfSystemDictationNoteHistoryDTOList.length;
					
					break;
				
				case Constants.PHYSICAL_MODULE_NAME:
					
					if (!model.physicalDictationNoteHistoryDTOList)
						model.physicalDictationNoteHistoryDTOList = new ArrayCollection();
					
					model.physicalDictationNoteHistoryDTOList.addItem(dictationNoteHistoryDTO);
					
					dictationNoteHistoryDTO.serialNumber = model.physicalDictationNoteHistoryDTOList.length;
					
					break;
				
				case Constants.LAB_IN_MODULE_NAME:
					
					if (!model.inHouseLabDictationNoteHistoryDTOList)
						model.inHouseLabDictationNoteHistoryDTOList = new ArrayCollection();
					
					model.inHouseLabDictationNoteHistoryDTOList.addItem(dictationNoteHistoryDTO);
					
					dictationNoteHistoryDTO.serialNumber = model.inHouseLabDictationNoteHistoryDTOList.length;
					
					break;
				
				case Constants.DIAGNOSIS_MODULE_NAME:
					
					if (!model.diagosisDictationNoteHistoryDTOList)
						model.diagosisDictationNoteHistoryDTOList = new ArrayCollection();
					
					model.diagosisDictationNoteHistoryDTOList.addItem(dictationNoteHistoryDTO);
					
					dictationNoteHistoryDTO.serialNumber = model.diagosisDictationNoteHistoryDTOList.length;
					
					break;
				
				case Constants.TREATMENT_MODULE_NAME:
					
					if (!model.treatmentDictationNoteHistoryDTOList)
						model.treatmentDictationNoteHistoryDTOList = new ArrayCollection();
					
					model.treatmentDictationNoteHistoryDTOList.addItem(dictationNoteHistoryDTO);
					
					dictationNoteHistoryDTO.serialNumber = model.treatmentDictationNoteHistoryDTOList.length;
					
					break;
				
				case Constants.PLAN_MODULE_NAME:
					
					if (!model.planDictationNoteHistoryDTOList)
						model.planDictationNoteHistoryDTOList = new ArrayCollection();
					
					model.planDictationNoteHistoryDTOList.addItem(dictationNoteHistoryDTO);
					
					dictationNoteHistoryDTO.serialNumber = model.planDictationNoteHistoryDTOList.length;
					
					break;
			}	
		}
		
		public function fault(rpcEvent:Object):void
		{
			var errorStatus:String = "Fault occured in LoadModuleDictationByPatientID.";
			
			var userId:int = UtilityFunctions.IsNullOrEmpty(model.LoggedInUserId) ? -1 : model.LoggedInUserId;
			
			QSCombinedExceptionAlert.getInstance().Show(errorStatus, rpcEvent.toString(), userId); 
		}
	}
}