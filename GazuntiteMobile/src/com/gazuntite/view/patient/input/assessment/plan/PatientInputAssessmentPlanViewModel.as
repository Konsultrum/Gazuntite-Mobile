package com.gazuntite.view.patient.input.assessment.plan
{
	import com.gazuntite.common.dto.ModuleNoteDTO;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.patient.visit.utils.Constants;
	import com.gazuntite.patient.visit.utils.QIUtilityFunctions;
	import com.gazuntite.view.patient.input.assessment.plan.followUp.PatientInputAssessmentFollowUpViewModel;
	import com.gazuntite.view.patient.input.assessment.plan.labOut.PatientInputAssessmentLabOutViewModel;
	import com.gazuntite.view.patient.input.assessment.plan.recommendation.PatientInputAssessmentRecommendationViewModel;
	import com.gazuntite.viewModel.PatientDictationNoteViewModel;

	[Bindable]
	public class PatientInputAssessmentPlanViewModel
	{
		protected static var instance:PatientInputAssessmentPlanViewModel;
		
		public var dictationNoteViewModel:PatientDictationNoteViewModel = new PatientDictationNoteViewModel();
		public var dictationNoteHistoryViewModel:PatientDictationNoteViewModel;
		
		public var model:QIModelLocator = QIModelLocator.getInstance();
		
		private var labOutViewModel:PatientInputAssessmentLabOutViewModel;
		private var recommendationViewModel:PatientInputAssessmentRecommendationViewModel;
		private var followUpViewModel:PatientInputAssessmentFollowUpViewModel;
		
		public var planInputTabSelectedIdx:int;
		
		public var notesDTO:ModuleNoteDTO;
		public function PatientInputAssessmentPlanViewModel(singleton:Number)
		{
			dictationNoteViewModel = new PatientDictationNoteViewModel();
			dictationNoteHistoryViewModel = new PatientDictationNoteViewModel();
			
			labOutViewModel = PatientInputAssessmentLabOutViewModel.getInstance();
			recommendationViewModel = PatientInputAssessmentRecommendationViewModel.getInstance();
			followUpViewModel = PatientInputAssessmentFollowUpViewModel.getInstance();
			
			planInputTabSelectedIdx = 0;
		}
		
		public static function getInstance():PatientInputAssessmentPlanViewModel
		{
			if (instance == null)
			{
				instance = new PatientInputAssessmentPlanViewModel(1);
			}
			return instance;
		}
		
		public function loadPlanData():void
		{
			loadPatientLabByVisitID();
			loadPatientLabHistory();
			
			loadRecommendationByVisitID();
			loadRecommendationHistory();
			
			loadFollowUpByVisitID();
			loadFollowUpHistory();
		}
		
		public function loadPlanStaticData():void
		{
			labOutViewModel.loadLabOutStaticData();
			recommendationViewModel.loadRecommendationStaticData();
			followUpViewModel.loadFollowUpStaticData();
		}
		
		public function clearPlanData():void
		{
			labOutViewModel.clearPatientLabs();
			recommendationViewModel.clearRecommendation();
			followUpViewModel.clearFollowUp();
			
			clearPlanSectionDictationNote();
		}
		
		public function clearPlanSectionDictationNote():void
		{
			if (!notesDTO)
				return;
			
			notesDTO.Note = "";
		}
		
		public function initializePlanInputSectionNotes():void
		{
			notesDTO = QIUtilityFunctions.getModuleNoteDTO(Constants.PLAN_MODULE_NAME);
		}
		
		public function loadPatientLabByVisitID():void
		{
			labOutViewModel.loadPatientLabOutByVisitID();
		}
		
		public function loadPatientLabHistory():void
		{
			labOutViewModel.loadPatientLabOutHistory();
		}
		
		public function managePatientRecommendation(sectionName:String):void
		{
			recommendationViewModel.managePatientRecommendation(sectionName);
		}
		
		public function loadRecommendationByVisitID():void
		{
			recommendationViewModel.loadRecommendationByVisitID();	
		}
		
		public function loadRecommendationHistory():void
		{
			recommendationViewModel.loadRecommendationHistory();
		}
		
		public function loadRecommedationLinksOnSearch(searchTerm:String):void
		{
			recommendationViewModel.loadRecommendationWebLinks(searchTerm);
		}
		
		public function loadFollowUpByVisitID():void
		{
			followUpViewModel.loadFollowUpByVisitID();
		}
		
		public function loadFollowUpHistory():void
		{
			followUpViewModel.loadFollowUpHistory();
		}
		
		public function loadFollowUpLabs():void
		{
			followUpViewModel.loadFollowUpLabs();
		}
		
		public function managePatientFollowUp(sectionName:String):void
		{
			followUpViewModel.manageFollowUp(sectionName);
		}
		
		public function loadFollowUpServiceType(followUpDataControlType:int, searchTerm:String):void
		{
			followUpViewModel.loadFollowUpServiceType(followUpDataControlType, searchTerm);
		}
	}
}