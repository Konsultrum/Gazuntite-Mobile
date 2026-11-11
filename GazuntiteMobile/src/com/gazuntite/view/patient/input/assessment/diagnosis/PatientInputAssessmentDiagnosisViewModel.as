package com.gazuntite.view.patient.input.assessment.diagnosis
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.common.dto.ModuleNoteDTO;
	import com.gazuntite.patient.history.event.assessment.diagnosis.LoadAcuteDiagnosisByPatientIdPagedEvent;
	import com.gazuntite.patient.history.event.assessment.diagnosis.LoadChronicDiagnosisByPatientIdPagedEvent;
	import com.gazuntite.patient.history.event.assessment.diagnosis.LoadResolvedDiagnosisByPatientIdPagedEvent;
	import com.gazuntite.patient.visit.event.NotesDictation.ManageModuleNotesEvent;
	import com.gazuntite.common.event.visit.LoadDiagnosisICDCodeEvent;
	import com.gazuntite.patient.visit.event.assessment.diagnosis.LoadPatientDiagnosisByVisitIdEvent;
	import com.gazuntite.patient.visit.event.assessment.diagnosis.ManagePatientDiagnosisEvent;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.view.patient.input.assessment.plan.PatientInputAssessmentPlanViewModel;
	import com.gazuntite.viewModel.PatientDictationNoteViewModel;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class PatientInputAssessmentDiagnosisViewModel
	{
		protected static var instance:PatientInputAssessmentDiagnosisViewModel;
		
		public var model:QIModelLocator = QIModelLocator.getInstance();
		
		public var dictationNoteViewModel:PatientDictationNoteViewModel;
		public var dictationNoteHistoryViewModel:PatientDictationNoteViewModel;
		public var inlineDictationNoteViewModel:PatientDictationNoteViewModel;
		
		public function PatientInputAssessmentDiagnosisViewModel(singleton:Number)
		{
			dictationNoteViewModel = new PatientDictationNoteViewModel();
			dictationNoteHistoryViewModel = new PatientDictationNoteViewModel();
			
			inlineDictationNoteViewModel = new PatientDictationNoteViewModel();
			inlineDictationNoteViewModel.inlineEditing = true;
		}
		
		public static function getInstance():PatientInputAssessmentDiagnosisViewModel
		{
			if (instance == null)
			{
				instance = new PatientInputAssessmentDiagnosisViewModel(1);
			}
			
			return instance;
		}
		
		public function loadPatientDiagnosis():void
		{
			var ev:LoadPatientDiagnosisByVisitIdEvent = new LoadPatientDiagnosisByVisitIdEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent(ev);
		}
		
		public function loadPatientAcuteDiagnosisHistory():void
		{
			var ev:LoadAcuteDiagnosisByPatientIdPagedEvent = new LoadAcuteDiagnosisByPatientIdPagedEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent(ev);
		}
		
		public function loadPatientChronicDiagnosisHistory():void
		{
			var ev:LoadChronicDiagnosisByPatientIdPagedEvent = new LoadChronicDiagnosisByPatientIdPagedEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent(ev);
		}
		
		public function loadPatientResolvedDiagnosisHistory():void
		{
			var ev:LoadResolvedDiagnosisByPatientIdPagedEvent = new LoadResolvedDiagnosisByPatientIdPagedEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent(ev);
		}
		
		public function clearPatientDiagnosis():void
		{
			if (model.diagnosisDTOList)
				model.diagnosisDTOList.removeAll();
			else
				model.diagnosisDTOList = new ArrayCollection();
			
			if (model.diagnosisDTOAcuteHistoryList)
				model.diagnosisDTOAcuteHistoryList.removeAll();
			else
				model.diagnosisDTOAcuteHistoryList = new ArrayCollection();
			
			if (model.diagnosisDTOChronicHistoryList)
				model.diagnosisDTOChronicHistoryList.removeAll();
			else
				model.diagnosisDTOChronicHistoryList = new ArrayCollection();
			
			if (model.diagnosisDTOResolvedHistoryList)
				model.diagnosisDTOResolvedHistoryList.removeAll();
			else
				model.diagnosisDTOResolvedHistoryList = new ArrayCollection();
		}
		
		public function managePatientDiagnosis(sectionName:String):void
		{
			var ev:ManagePatientDiagnosisEvent = new ManagePatientDiagnosisEvent(sectionName);
			CairngormEventDispatcher.getInstance().dispatchEvent(ev);
		}
		
		public function loadPatientDiagnosisStaticData(searchTerm:String):void
		{
			var ev:LoadDiagnosisICDCodeEvent = new LoadDiagnosisICDCodeEvent(searchTerm,model.LoggedInUserSessionID,model.LoggedInUserId, ICDCodeloadResult);
			CairngormEventDispatcher.getInstance().dispatchEvent(ev);
		}
		private function ICDCodeloadResult(icdCodeList:ArrayCollection):void
		{
			model.icdCodeDTOList = icdCodeList;
		}
	}
}