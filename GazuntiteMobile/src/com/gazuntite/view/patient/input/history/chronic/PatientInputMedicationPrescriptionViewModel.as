package com.gazuntite.view.patient.input.history.chronic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.event.LoadPatientMedEvent;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.viewModel.PatientDictationNoteViewModel;
	
	import flashx.textLayout.operations.InsertInlineGraphicOperation;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class PatientInputMedicationPrescriptionViewModel
	{
		protected static var instance:PatientInputMedicationPrescriptionViewModel;
		
		private var model:QIModelLocator = QIModelLocator.getInstance();
		
		public var medicationDictationNoteViewModel:PatientDictationNoteViewModel;
		public var medicationDictationNoteHistoryViewModel:PatientDictationNoteViewModel;
		public var inlineMedicationDictationNoteViewModel:PatientDictationNoteViewModel;
		
		public function PatientInputMedicationPrescriptionViewModel(singleton:Number)
		{
			medicationDictationNoteViewModel = new PatientDictationNoteViewModel();
			
			medicationDictationNoteHistoryViewModel = new PatientDictationNoteViewModel();
			
			inlineMedicationDictationNoteViewModel = new PatientDictationNoteViewModel();
			inlineMedicationDictationNoteViewModel.inlineEditing = true;
		}
		
		public static function getInstance():PatientInputMedicationPrescriptionViewModel
		{
			if (instance == null)
			{
				instance = new PatientInputMedicationPrescriptionViewModel(0);
			}
			
			return instance;
		}
		
		public function loadMedicationPrescription():void
		{
			var securityHeaderXML:XML;
			securityHeaderXML = <Header />;					
			securityHeaderXML.@EUserName = "TESTUSER";
			securityHeaderXML.@EPassword = "TESTPASS";
			securityHeaderXML.@ClinicID	= "sad";
			
			var loadPatientPrescriptionEvent:LoadPatientMedEvent = new LoadPatientMedEvent("0", model.patientDTO.GAXENID, onPrescriptionLoaded);				
			loadPatientPrescriptionEvent.data = securityHeaderXML; 				
			CairngormEventDispatcher.getInstance().dispatchEvent(loadPatientPrescriptionEvent);
		}
		
		public function onPrescriptionLoaded(patientMedAC:ArrayCollection, patientChronicMedAC:ArrayCollection, patientMedAC_inactive:ArrayCollection, patientChronicMedAC_inactive:ArrayCollection):void
		{
			model.medicationDTOList = patientChronicMedAC;	//for QI Chronic Medication
			model.prescriptionDToList = patientMedAC;	//for QI Prescription
		}
		
		public function clearMedicationPrescriptionData():void
		{
			// PMH - Chronic Medication Section/////////
			if (model.medicationDTOList)
				model.medicationDTOList.removeAll();
			else
				model.medicationDTOList = new ArrayCollection();
			
			// ASESSMENTS - Treatment - Prescription Section
			if (model.prescriptionDToList)
				model.prescriptionDToList.removeAll();
			else
				model.prescriptionDToList = new ArrayCollection();
			
			if (model.CurrentprescriptionDToList)
				model.CurrentprescriptionDToList.removeAll();
			else
				model.CurrentprescriptionDToList = new ArrayCollection();
		}
		
		
	}
}